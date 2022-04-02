classdef DynaLearn < matlab.mixin.SetGet

    %
    % DynaModel; variational version
    % An integrated class for interactive and trainable DynaSim network models
    % Current learning method: Reinforcement learning - Delta rule
    %
    
    properties
        
        dlModel = []; % Dynasim's model struct, containing model's populations (layers) and connections, mechanisms ... .
        dlStudyDir = 'solve'; % Output data of last simulation.
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
        
    end
    
    methods

        function obj = DynaLearn(varargin) % Constructors, will be expanded
            
            disp("Creating Dyna model object ... ");
            
            if nargin == 1

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
        
        function [s] = dlGetMexName(obj)
            
            path = [obj.data, '/solve'];
            d = dir(path);
            
            for i = 1:size(d, 1)
                if contains(d(i).name, 'mexw64')
                    s = d(i).name;
                end
            end
            
        end
        
        function dlInit(obj, studydir) % Initializer TODO
            
            tspan = [0 10];
            simulator_options = {'tspan', tspan, 'solver', 'rk1', 'dt', .01, ...
                        'downsample_factor', 10, 'verbose_flag', 1, ...
                        'study_dir', studydir, 'mex_flag', 1};
            obj.dsData = dsSimulate(obj.dlModel, 'vary', [], simulator_options{:});
            
        end
        
        function dlMexBridgeInit(obj)
           
            set(obj, 'dlMexFuncName', obj.dlGetMexName());
            dlMexBridge('dlTempFunc.m', obj.dlMexFuncName);
            
        end
        
        function dlSimulate(obj) % DynaSimulator TODO
            
            set(obj, 'dlOutputs', dlTempFunc(obj.outputs));
      
        end
        
        function c = get_connections_list(obj)
            
            p = load(obj.data + "/solve/params.mat");
            st = p.p;
            cl = fieldnames(st);
            c = [];
            
            for i = 1:size(cl, 1)
                if contains(cl(i), '_netcon')
                    c = [c; cl(i)];
                end
            end
            
        end
        
        function [c, e, t] = get_potentials(obj)% TODO
            
            d = obj.data;
            cl = fieldnames(d);
            dl = struct2cell(d);
            
            c = [];
            e = [];
            t = d.time;
            
            for i = 1:size(cl, 1)
                if contains(cl(i), '_V')
                    c = [c; cl(i)];
                    e = [e; dl(i, 1, 1)];
                end
            end
            
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
        
        function obj = run_simulation(obj, vary, opt) % TODO
            
            fprintf("Running simulation ...\n");
            p = load("solve/params.mat");
            disp(p);
%             set(obj, 'data', obj.simulate(vary, opt));
            fprintf("Simulation done.\n"); 
            
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
