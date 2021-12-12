classdef DynaModel < matlab.mixin.SetGet

    %
    % An integrated class for interactive and trainable DynaSim network models
    % Current learning method: Reinforcement learning - Delta rule
    %
    
    properties
        
        model = []; % Dynasim's model struct, containing model's populations (layers) and connections, mechanisms ... .
        data = []; % Output data of last simulation.
        errors_log = []; % Log of errors since first trial.
        connections = []; % List of connection names.
    
        last_trial = 0; % Last trial; how many times this model have been trianed with stimuli.
        last_inputs = []; % Last input(s) that have been passed to this model.
        last_outputs = []; % Last output (eg. spike vector) of this model.
        last_error = []; % Last error of this model for target, equivalent to the last value of errors_log property
        
        last_targets = []; % Last expected output that this model should've generated.
        
    end
    
    methods
        
        function obj = DynaModel(model_) % Constructor
            
            set(obj, 'model', model_);
            set(obj, 'data', obj.init());
            set(obj, 'connections', obj.get_connections_list());
            
        end
        
        function set.model(obj, val) % Getter/setters
            
             if ~isstruct(val) 
                error('Model must be a struct');
             end
             obj.model = val;
             
        end
        
        function set.data(obj, val)
            
             if ~isstruct(val) 
                error('Data must be a struct');
             end
             obj.data = val;
             
        end
        
        function set.errors_log(obj, val)
            
             if ~strcmpi(class(val), 'double') 
                error('Errors log must be a double array');
             end
             obj.errors_log = val;
             
        end
        
        function set.connections(obj, val)
            
             if ~iscell(val) 
                error('Connections must be a cell');
             end
             obj.connections = val;
             
        end
        
        function set.last_trial(obj, val)
             
             obj.last_trial = floor(double(val));
             
        end
        
        function set.last_inputs(obj, val)
             
             obj.last_inputs = val;
             
        end
        
        function set.last_outputs(obj, val)
             
             obj.last_outputs = val;
             
        end
        
        function set.last_error(obj, val)
             
             obj.last_error = val;
             
        end
        
        function set.last_targets(obj, val)
             
             obj.last_targets = val;
             
        end
        
        function o = init(obj) % Initializer
            
            o = dsSimulate(obj.model, 'solver', 'rk1', 'dt', .01, 'time_limits', [0 100], 'downsample_factor', 10, 'verbose_flag', 1);
        
        end
        
        function o = simulate(obj, t, dt) % DynaSimulator
            
            o = dsSimulate(obj.model, 'solver', 'rk1', 'dt', dt, 'time_limits', [0 t], 'downsample_factor', 10, 'verbose_flag', 0);
      
        end
        
        function c = get_connections_list(obj)
            
            st = obj.data.model.fixed_variables;
            c = fieldnames(st);
            
        end
        
        function o = get_outputs(obj, inds)
            
            st = struct2cell(obj.data);
            inds = inds{1};
            o = st(inds);
            
        end
        
        function o = get_outputs_spike(obj)
            
            output = get(obj, 'last_outputs');
            k = size(output{1}, 2);
            o = sum(sum(double(output{1})))/k;
        
        end
        
        function obj = update_error(obj, mode)
            
            output = obj.get_outputs_spike();
            target = get(obj, 'last_targets');
            
%             disp(output-target);
            
            if strcmpi(mode, 'diff')
                
                err = (target-output); % Basic difference
                
            elseif strcmpi(mode, 'MAE')
                
                err = 0.5*abs(target-output);
                
            elseif strcmpi(mode, 'MSE')
                
                err = 0.5*(target-output)^2;
                
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
        
        function obj = run_trial(obj, inputs, inputs_index, outputs_index, t, dt, target, lambda, mode, error_mode, momentum)
            
            set(obj, 'last_trial', get(obj, 'last_trial') + 1);
            set(obj, 'last_targets', target);
            
            cnt = 0;
            model_n = get(obj, 'model');
            
            for i = inputs_index
                cnt = cnt + 1;
                eq = inputs(cnt);
                model_n.populations(i).equations = eq{1};
            end
            
            set(obj, 'model', model_n);
            set(obj, 'data', obj.simulate(t, dt));
            set(obj, 'last_outputs', obj.get_outputs(outputs_index));
            set(obj, 'last_inputs', inputs);
            
            obj.update_error(error_mode);
            obj.train_step(lambda, mode, momentum);
            
        end
        
        function train_step(obj, lambda, mode, momentum) 
                            
            error = get(obj, 'last_error');
            
            if strcmpi(mode, 'normal')

                obj.update_weights_normal(lambda, error, momentum);
            
            elseif strcmpi(mode, 'uniform')
                
                obj.update_weights_uniform(lambda, error, momentum);
                
            else
                
                obj.update_weights_constant(lambda, error)
                
            end
            
        end
        
        function update_weights_normal(obj, lambda, error, momentum)
            
            for i = 1:size(obj.connections, 1)
                
                wp = obj.get_weight(i);
                delta = lambda*error*randn(size(wp));
                wn = momentum*wp + (1-momentum)*delta;
                
                if max(max(abs(wn))) > 1

                    wn = wn / max(max(abs(wn)));

                end
               
                obj.update_weight(i, wn);
               
            end
            
        end
        
        function update_weights_uniform(obj, lambda, error, momentum)
            
            for i = 1:size(obj.connections, 1)
                
                wp = obj.get_weight(i);
                delta = lambda*error*(rand(size(wp))-0.5);
                wn = momentum*wp + (1-momentum)*delta;

                if max(max(abs(wn))) > 1

                  wn = wn / max(max(abs(wn)));

                end

                obj.update_weight(i, wn);
               
            end
            
        end
        
        function update_weights_constant(obj, lambda, error)
            
            for i = 1:size(obj.connections, 1)
                
                wp = obj.get_weight(i);
                wn = wp + lambda*error*ones(size(wp));
                if max(max(abs(wn))) > 1

                    wn = wn / max(max(abs(wn)));

                end

                obj.update_weight(i, wn);
            end
            
        end
        
        function update_weight(obj, connection, Wn)
            
            model_n = get(obj, 'model');
            model_n.connections(connection).parameters = {'netcon', Wn};
            set(obj, 'model', model_n);
            
        end
        
        function w = get_weight(obj, connection)
            
            w_s = obj.data.model.fixed_variables;
            w_c = struct2cell(w_s);
            w = w_c(connection);
            w = w{1};
            
        end
        
        function error_plot(obj, error_title)
           
            errors = get(obj, 'errors_log');
            figure("Position", [50 75 1450 575]);
            plot(errors);
            xlabel("Trials");
            grid('on');
            ylabel(error_title);
            
        end
        
    end
end
