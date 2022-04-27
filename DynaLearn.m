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
        
            dlSaveFileNamePath = [obj.dlStudyDir, '/dlFile.mat'];
            set(obj, 'dlPathToFile', 'dlFile.mat');
            p = load([obj.dlPath, '/params.mat']);
            save([obj.dlStudyDir, '/params.mat'], '-struct', 'p');
            save(dlSaveFileNamePath, 'obj');
            
        end
        
        function obj = dlLoad(obj, PathToFile) % TODO load params.mat from /solve
           
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
            
            obj.dlTrialNumber = 0;
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
            Error = 0;
            
            for i = 1:n
               
                TempError = 0;
                
                dlErrorType = dlTargetParams{i, 1};
                dlOutputIndices = dlTargetParams{i, 2};
                dlOutputTargets = dlTargetParams{i, 3};
                dlErrorWeight = dlTargetParams{i, 4};
                
                if strcmpi(dlErrorType, 'MAE')
                   
                    TempError = abs(obj.dlLastOutputs{dlOutputIndices} - dlOutputTargets);
                    
                elseif strcmpi(dlErrorType, 'MSE')
                    
                    TempError = abs(obj.dlLastOutputs{dlOutputIndices} - dlOutputTargets)^2;
                
                    
                elseif strcmpi(dlErrorType, 'Compare')
                    
                    x = dlOutputIndices;
                    c = 1;
                    
                    for j = dlOutputIndices
                        
                        x(c) = obj.dlLastOutputs{j};
                        
                        if c > 1
                            TempError = TempError + obj.dlRampFunc(x(c) - x(c-1));
                        end
                        
                        c = c + 1;
                        
                    end
                    
                else
                    
                    fprintf("Undefined error type ""%s""\n", dlErrorType);
                    
                end
                
                Error = Error + TempError*dlErrorWeight;
                
            end
            
            obj.dlErrorsLog = [obj.dlErrorsLog, Error];
            obj.dlLastError = Error;
            
        end
        
        function dlTrain(obj, dlEpochs, dlBatchs, dlVaryList, dlOutputParameters, dlTargetParameters, dlLearningRule, dlLambda) % TODO !!! -> Steps, Update, parameters and variables
           
            for i = 1:dlEpochs
                
                fprintf("\tTrial no. %d\n", i);
                for j = 1:dlBatchs
                
                    set(obj, 'dlTrialNumber', obj.dlTrialNumber + 1);
                    obj.dlUpdateParams(dlVaryList{j});
                    obj.dlSimulate();
                    
                    obj.dlCalculateOutputs(dlOutputParameters);
                    obj.dlCalculateError(dlTargetParameters);
                    obj.dlTrainStep(dlLearningRule, dlLambda);
                
                end
                fprintf("\t\tError = %f\n", obj.dlLastError);
                
            end
            
        end
        
        function dlTrainStep(obj, dlLearningRule, dlLambda)
           
            error = obj.dlLastError;
            p = load([obj.dlPath, '/params.mat']);
            
            val = struct2cell(p.p);
            lab = fieldnames(p.p);
            l = find(contains(lab, '_netcon'));
            
            if strcmpi(dlLearningRule, 'DeltaRule')
            
                for i = l'

                    w = val{i, 1};
                    wn = w + randn(size(w))*error*dlLambda;
%                     wn = w + (1-w).*randn(size(w))*error*dlLambda; %
%                     Biochemical Delta rule.
                    val{i, 1} = wn;
                    
                end
                
            elseif strcmpi(dlLearningRule, 'RWDeltaRule')
            
                disp("TODO Rascorla-Wagner delta rule");
                
            else
                
                disp("TODO train step and learning 'else' part");
                disp(error);
                
            end
            
            q = cell2struct(val, lab);
            p.p = q;
            save([obj.dlPath, '/params.mat'], '-struct', 'p');

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
        
        function out = dlRampFunc(obj, x)
           
            out = (x + abs(x))/2;
            
        end
        
    end
end
