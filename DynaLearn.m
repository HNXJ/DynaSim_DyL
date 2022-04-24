classdef DynaLearn < matlab.mixin.SetGet

    %
    % DynaModel; variational version
    % An integrated class for interactive and trainable DynaSim network models
    % Current learning method: Reinforcement learning - Delta rule
    %
    
    properties
        
        dlModel = []; % Dynasim's model struct, containing model's populations (layers) and connections, mechanisms ... .
        dlStudyDir = 'models/'; % Output data of last simulation.
        dlErrorsLog = []; % Log of errors since first trial.
        dlConnections = []; % List of connection names.
    
        dlTrialNumber = 0; % Last trial; how many times this model have been trianed with stimuli.
        dlLastOutputs = []; % Last output (eg. spike vector) of this model.
        dlLastError = 0; % Last error of this model for target, equivalent to the last value of errors_log property
        dlLastTargets = []; % Last expected output that this model should've generated.
        
        dsData = []; % Last simulation outputs
        dlOutputs = []; % Mex outputs
        dlVariables = []; % Mex variable labels
        dlMexFuncName = []; % Name of Mex function (e.g **********_mex.mex64
        
        dlPath = []; % Path which contains params.mat, mexfuncs, solver ...
        dlPathToFile = 'models/dlBaseModel/dlFile.mat';
        dlBaseVoltage = -77.4;
        dldT = .01; % Time step in ODEs (dt)
        
        dlDownSampleFactor = 10; 
    end
    
    methods

        function obj = DynaLearn(varargin) % Constructors, will be expanded
            
            disp("Creating Dyna model object ... ");
            set(obj, 'dlPathToFile', 'models/dlBaseModel/dlFile.mat');
            
            if nargin == 0
                
                obj = obj.dlLoad(obj.dlPathToFile);
                
            elseif nargin == 1

                model_ = varargin{1};
                set(obj, 'dlModel', model_);
                obj.dlInit(obj.dlStudyDir);
                set(obj, 'dlConnections', obj.dlGetConnectionsList());
                    
            elseif nargin == 2
                    
                model_ = varargin{1};  
                data_ = varargin{2};
%                 mexn_ = varargin{3};
                
                set(obj, 'dlModel', model_);
                set(obj, 'dlStudyDir', data_);
%                 set(obj, 'mex_func_name', mexn_);
                
                obj.dlInit(obj.dlStudyDir);
                set(obj, 'dlConnections', obj.dlGetConnectionsList());
                    
            else
                disp('Invalid use of DynaNet; pass a DynaSim struct and then address of parameters dataset file.');
            end
          
            [out, vars] = dsGetOutputList(obj.dlModel);
            set(obj, 'dlOutputs', out);
            set(obj, 'dlVariables', vars);
            obj.dlMexBridgeInit();
            
            disp("DynaLearn model created.");
            
        end

        function set.dlModel(obj, val) % Getter/setters
            
             if ~isstruct(val) 
                error('Model must be a struct');
             end
             obj.dlModel = val;
             
        end
        
        function set.dlStudyDir(obj, val)
            
             if ~strcmpi(class(val), 'string') && ~ischar(val)
                error('Study directory must be an address, a string');
             end
             obj.dlStudyDir = val;
             
        end
        
        function set.dlErrorsLog(obj, val)
            
             if ~strcmpi(class(val), 'double') 
                error('Errors log must be a double array');
             end
             obj.dlErrorsLog = val;
             
        end
        
        function set.dlConnections(obj, val)
            
             if ~iscell(val) 
                error('Connections must be a cell');
             end
             obj.dlConnections = val;
             
        end
        
        function set.dlTrialNumber(obj, val)
             
             obj.dlTrialNumber = floor(double(val));
             
        end
        
        function set.dlLastOutputs(obj, val)
             
             obj.dlLastOutputs = val;
             
        end
        
        function set.dlLastError(obj, val)
             
             obj.dlLastError = val;
             
        end
        
        function set.dlLastTargets(obj, val)
             
            obj.dlLastTargets = val;
             
        end
        
        function set.dlOutputs(obj, val)
             
            obj.dlOutputs = val;
             
        end
        
        function dlSave(obj)
        
            dlSaveFileNamePath = [obj.dlStudyDir, '/dlFile'];
            set(obj, 'dlPathToFile', 'dlFile.mat');
            save(dlSaveFileNamePath, 'obj');
            
        end
        
        function obj = dlLoad(obj, PathToFile)
           
            set(obj, 'dlPathToFile', PathToFile);
            o = load(obj.dlPathToFile);
            fprintf("Loaded from %s \n", PathToFile);
            obj = o.obj;
            obj.dlReInit();
            
        end
        
        function dlReInit(obj)
           
            [out, vars] = dsGetOutputList(obj.dlModel);
            set(obj, 'dlOutputs', out);
            set(obj, 'dlVariables', vars);
            obj.dlMexBridgeInit()
            
            fprintf("\nReinitialized.\n");
            
        end
        
        function [s] = dlGetMexName(obj)
            
            obj.dlPath = [obj.dlStudyDir, '/solve'];
            addpath(obj.dlPath);
            d = dir(obj.dlPath);
            
            for i = 1:size(d, 1)
                if contains(d(i).name, 'mexw64')
                    s = d(i).name;
                    s = s(1:end-7);
                end
            end
            
        end
        
        function dlInit(obj, studydir) % Initializer TODO
            
            tspan = [0 10]; % Base time span for class construction and initialization.
            simulator_options = {'tspan', tspan, 'solver', 'rk1', 'dt', obj.dldT, ...
                        'downsample_factor', obj.dlDownSampleFactor, 'verbose_flag', 1, ...
                        'study_dir', studydir, 'mex_flag', 1};
            obj.dsData = dsSimulate(obj.dlModel, 'vary', [], simulator_options{:});
            
        end
        
        function dlMexBridgeInit(obj)
           
            set(obj, 'dlMexFuncName', obj.dlGetMexName());
            dsMexBridge('dlTempFunc.m', obj.dlMexFuncName);
            
        end
        
        function dlPlotAllPotentials(obj, mode)
           
            dlPotentialIndices = contains(obj.dlVariables, '_V');
            dlPotentialIndices(1) = 1;
            dlPotentials = obj.dlOutputs(dlPotentialIndices);
            dlLabels = obj.dlVariables(dlPotentialIndices);
            
            figure();
            patch([3 7 7 3], [-30 -30 +30 +30], [0.5 0.9 0.9]);hold("on");
            t = dlPotentials{1, 1};
            n = size(dlPotentials, 2);
            
            if strcmpi(mode, 'ifr')
                
                for i = 2:n

                    x = dlPotentials{1, i};
                    raster = computeRaster(t, x);
                    subplot(ceil(n/2), 2, i-1);

                    if size(raster, 1) > 0

                        pool = 1:size(x, 2);
                        O1 = 5e2 * NWepanechnikovKernelRegrRaster(t, raster, pool, 25, 1, 1);
                        plot(t, O1, 'o');

                    end

                    ylabel(dlLabels(i));

                end
                
                grid("on");title("iFR(s)");xlabel("time (ms)");
                fprintf("Done.\n");
                
            else
                
                for i = 2:n

                    x = dlPotentials{1, i};
                    subplot(ceil(n/2), 2, i-1);
                    plot(t, x);
                    ylabel(dlLabels(i));

                end
                
                grid("on");title("Voltage(s)");xlabel("time (ms)");
                fprintf("Done.\n");
                
            end

        end

        
        function dlSimulate(obj)
            
            disp("Simulation ...");
            set(obj, 'dlOutputs', dlTempFunc(obj.dlOutputs));
            disp("Done."); 
      
        end
        
        function kernel = dlTimeIntervalKernel(obj, dlTimeInterval)
            
            kernel = obj.dlOutputs{1, 1};
            kernel(kernel > dlTimeInterval(2)) = 0;
            kernel(kernel < dlTimeInterval(1)) = 0;
            kernel(kernel > 0) = 1; 
       
        end
        
        function out = dlApplyKernel(obj, dlOutput, dlKernel)
           
            xp = dlOutput;
            for j = 1:size(xp, 2)

                xp(:, j) = xp(:, j).*dlKernel;
                xp(xp == 0) = obj.dlBaseVoltage;

            end
            out = xp;
           
        end
        
        function out = dlApplyIFRKernel(obj, dlOutput)
              
            x = dlOutput;
            t = linspace(0, size(x, 1), size(x, 1))*obj.dldT*obj.dlDownSampleFactor;
            raster = computeRaster(t, x);

            if size(raster, 1) > 0

                pool = 1:size(x, 2);
                out = 5e2 * NWepanechnikovKernelRegrRaster(t, raster, pool, 25, 1, 1);
                
            else 

                out = zeros(1, size(x, 1));
                
            end
            
        end
        
        function out = dlApplyAverageFRKernel(obj, dlOutput)
           
            o1 = obj.dlApplyIFRKernel(dlOutput);
            out = mean(o1);
            
        end
        
        function dlCalculateOutputs(obj, dlOutputParameters)
           
            n = size(dlOutputParameters, 1);
            dlIndices = zeros(1, n);
            
            for i = 1:n
                
                dlIndices(i) = find(strcmpi(obj.dlVariables, dlOutputParameters{i, 1}));
                
            end
            
            set(obj, 'dlLastOutputs' , obj.dlOutputs(dlIndices));
            
            for i = 1:n
                
                dlTimeKernel = ceil(dlOutputParameters{i, 3}/(obj.dldT*obj.dlDownSampleFactor));
                dlOutputType = dlOutputParameters{i, 4};
                dlTempOutputs = obj.dlLastOutputs{i}(dlTimeKernel(1):dlTimeKernel(2), dlOutputParameters{i, 2});
         
                if strcmpi(dlOutputType, 'ifr')

                    obj.dlLastOutputs{i} = obj.dlApplyIFRKernel(dlTempOutputs);

                elseif strcmpi(dlOutputType, 'lfp')

                    obj.dlLastOutputs{i} = obj.dlApplyKernel(dlTempOutputs, dlTimeKernel);

                elseif strcmpi(dlOutputType, 'afr')

                    obj.dlLastOutputs{i} = obj.dlApplyAverageFRKernel(dlTempOutputs);

                else

                    fprintf("\tThis output type is not recognized. Trying to run ""%s.m"" ...\n", dlOutputType);
                    try

                        dsBridgeFunctionRun(dlOutputType);
                        obj.dlLastOutputs{i} = dlTempFuncBridge(dlTempOutputs);
                        fprintf("\t""%s.m"" runned succesfully for output no. %d\n", dlOutputType, i);

                    catch

                        fprintf("\tError occured. Function ""%s.m"" is not found or it contains error. check if you've created ""%s.m"" or entered correct output type.\n--->No valid output is calculated for this trial, response and error are going to be ""NaN""\n", dlOutputType, dlOutputType);
                        obj.dlLastOutputs{i} = "NaN";

                    end
                end
            end
        end
        
        function dlCalculateError(obj, dlTargetParams)
           
            n = size(dlTargetParams, 1);
            disp(n);
            obj.dlLastError = 0;
            disp('TODO Calculate error');
            
        end
        
        function dlTrain(obj, dlEpochs, dlBatchs, dlVaryList, dlOutputParameters, dlTargetParameters, dlLearningRule) % TODO !!! -> Steps, Update, parameters and variables
           
            for i = 1:dlEpochs
                
                fprintf("\tTrial no. %d\n", i);
                for j = 1:dlBatchs
                
                    set(obj, 'dlTrialNumber', obj.dlTrialNumber + 1);
                    obj.dlUpdateParams(dlVaryList{j});
%                     obj.dlSimulate();
                    
                    obj.dlCalculateOutputs(dlOutputParameters);
                    obj.dlCalculateError(dlTargetParameters);
                    obj.dlTrainStep(dlLearningRule);
                
                end
                
            end
            
        end
        
        function dlTrainStep(obj, dlLearningRule)
           
            error = obj.dlLastError;
            if strcmpi(dlLearningRule, 'DeltaRule')
            
                disp("TODO simple delta rule");
                
            elseif strcmpi(dlLearningRule, 'RWDeltaRule')
            
                disp("TODO Rascorla-Wagner delta rule");
                
            else
                
                disp("TODO train step and learning 'else' part");
                disp(error);
                
            end
            
        end
        
        function c = dlGetConnectionsList(obj)
            
            p = load(obj.dlStudyDir + "/solve/params.mat");
            st = p.p;
            cl = fieldnames(st);
            c = [];
            
            for i = 1:size(cl, 1)
                if contains(cl(i), '_netcon')
                    c = [c; cl(i)];
                end
            end
            
        end
        
        function dlUpdateParams(obj, map) 
            
            fprintf("Updating parameters of %s\n", obj.dlPath);
            dsParamsModifier('dlTempFuncParamsChanger.m', map);
            dlTempFuncParamsChanger(obj.dlPath);
            fprintf("params.mat updated.\n"); 
            
        end
        
        function o = get_outputs(obj, target_label, target_cells, target_tspan)% TODO
            
            fn = fieldnames(obj.data);
            ind = strcmp(fn, target_label);
            st = struct2cell(obj.data);
            
            t = obj.data.time;
            x = st(ind);x = x{1};
            raster = computeRaster(t, x);
            y = [];
            
            for i = 1:size(target_cells, 1)
                
                y = [y, 5e2 * NWepanechnikovKernelRegrRaster(t, raster, target_cells(i, :), 51, 1, 1)];    
                
            end
            
            o = y;
%             o = y(target_tspan(1):target_tspan(2), :)';
            
        end
        
        function o = get_outputs_ifr(obj)
            
            output = get(obj, 'last_outputs');
            o = mean(output, 1);
        
        end
        
        function obj = update_error(obj, mode)% TODO
            
            output = obj.get_outputs_ifr();
            target = get(obj, 'last_targets');
            
%             disp(output-target);
            
            if strcmpi(mode, 'diff')
                
                err = (target-output); % Basic difference
                
            elseif strcmpi(mode, 'MAE')
                
                err = 0.5*abs(target-output);
                
            elseif strcmpi(mode, 'MSE')
                
%                 err = 0.5*(target-output)^2; # TODO ERR
                  err = 0;
                
            else
                
                fprintf("Warning! error not defined, by default difference will be used.") 
                err = (target-output); % Basic difference
                
            end
            
            if abs(err) > 1000
               
                err = err / abs(err);
                err = err * 1000;
                
            end
            
            if isnan(err)
               
                err = obj.last_error;
                
            end
            
            
            set(obj, 'errors_log', [get(obj, 'errors_log'), err]);
            set(obj, 'last_error', err);
            
        end
        
        function obj = run_trial(obj, params)% TODO
            
            set(obj, 'last_trial', get(obj, 'last_trial') + 1);
            set(obj, 'data', obj.simulate(params.vary, params.simulation_options));
            set(obj, 'last_targets', params.target_order);  
            disp(params.input_label);
%          
% %             set(obj, 'last_outputs', obj.get_outputs(params.target_label, params.target_cells, params.target_tspan));
%             obj.update_error(params.error_mode);
%             
            if params.verbose
                fprintf("Trial no. %d, %s = %f\n", obj.last_trial, params.error_mode, obj.last_error);
            end
% %               fprintf("Trial no. %d", obj.last_trial);
%             obj.train_step(params.lambda, params.update_mode);
            
        end
        
        function train_step(obj, lambda, mode) % TODO
                            
            error = get(obj, 'last_error');
            
            if strcmpi(mode, 'normal')

                obj.update_weights_normal(lambda, error);
            
            elseif strcmpi(mode, 'uniform')
                
                obj.update_weights_uniform(lambda, error);
                
            else
                
                obj.update_weights_constant(lambda, error)
                
            end
            
        end
        
        function update_weights_normal(obj, lambda, error)% TODO
            
            for i = 1:size(obj.connections, 1)
                
                wp = obj.get_weight(i);
                delta = lambda*error*randn(size(wp));
                wn = wp + delta;
                
                if max(max(abs(wn))) > 1

                    wn = wn / max(max(abs(wn)));

                end
               
                obj.update_weight(i, wn);
               
            end
            
        end
        
        function update_weights_uniform(obj, lambda, error)% TODO
            
            for i = 1:size(obj.connections, 1)
                
                wp = obj.get_weight(i);
                delta = lambda*error*(rand(size(wp))-0.5);
                wn = wp + delta;

                if max(max(abs(wn))) > 1

                  wn = wn / max(max(abs(wn)));

                end

                obj.update_weight(i, wn);
               
            end
            
        end
        
        function update_weights_constant(obj, lambda, error)% TODO
            
            for i = 1:size(obj.connections, 1)
                
                wp = obj.get_weight(i);
                wn = wp + lambda*error*ones(size(wp));
                if max(max(abs(wn))) > 1

                    wn = wn / max(max(abs(wn)));

                end

                obj.update_weight(i, wn);
            end
            
        end
        
        function update_weight(obj, connection, Wn)% TODO
            
            model_n = get(obj, 'model');
            model_n.connections(connection).parameters = {'netcon', Wn};
            set(obj, 'model', model_n);
            
        end
        
        function w = get_weight(obj, connection) % TODO
            
            w_s = obj.data.model.fixed_variables;
            w_c = struct2cell(w_s);
            w = w_c(connection);
            w = w{1};
            
        end
        
        function error_plot(obj, error_title) % TODO
           
            errors = get(obj, 'errors_log');
            figure("Position", [50 75 1450 575]);
            plot(errors);
            xlabel("Trials");
            grid('on');
            ylabel(error_title);
            
        end
        
    end
end
