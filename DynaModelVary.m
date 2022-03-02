classdef DynaModelVary < matlab.mixin.SetGet

    %
    % DynaModel; variational version
    % An integrated class for interactive and trainable DynaSim network models
    % Current learning method: Reinforcement learning - Delta rule
    %
    
    properties
        
        model = []; % Dynasim's model struct, containing model's populations (layers) and connections, mechanisms ... .
        data = []; % Output data of last simulation.
        errors_log = []; % Log of errors since first trial.
        connections = []; % List of connection names.
    
        last_trial = 0; % Last trial; how many times this model have been trianed with stimuli.
        last_outputs = []; % Last output (eg. spike vector) of this model.
        last_error = []; % Last error of this model for target, equivalent to the last value of errors_log property
        last_targets = []; % Last expected output that this model should've generated.
        
    end
    
    methods

        function obj = DynaModelVary(varargin) % Constructors, will be expanded
            
            if nargin == 1
                
                if isstruct(varargin{1})
                    
                    vary = [];tspan = [0 100];
                    opt = {'solver','rk1','dt',.01,'downsample_factor',10,'verbose_flag',1};
                    model_ = varargin{1};           
                    set(obj, 'model', model_);
                    set(obj, 'data', obj.init(vary, tspan, opt));
                    set(obj, 'connections', obj.get_connections_list());
                    
                elseif isstring(varargin{1}) || ischar(varargin{1})
                    
                    filename_ = varargin{1};                
                    l = obj.load_model(filename_);    
                    obj = l;
                    
                else
                    disp('invalid use of DynaNet; pass a filename or a struct of DynaSim.');
                end
                
            end  
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
        
        function set.last_outputs(obj, val)
             
             obj.last_outputs = val;
             
        end
        
        function set.last_error(obj, val)
             
             obj.last_error = val;
             
        end
        
        function set.last_targets(obj, val)
             
             obj.last_targets = val;
             
        end
        
        function save_model(obj, filename)
             
             save(filename, 'obj');
             
        end
        
        function l = load_model(obj, filename)

             l = load(filename);
             l = l.obj;
             fprintf("Model loaded from : %s \n", filename);
             
        end
        
        function o = init(obj, vary, tspan, opt) % Initializer
            
            o = dsSimulate(obj.model, 'vary', vary, 'tspan', tspan, opt{:});
        
        end
        
        function o = simulate(obj, vary, opt) % DynaSimulator
            
            o = dsSimulate(obj.model, 'vary', vary, opt{:});
      
        end
        
        function c = get_connections_list(obj)
            
            st = obj.data.model.fixed_variables;
            c = fieldnames(st);
            
        end
        
        function o = get_outputs(obj, inds)
            
            st = struct2cell(obj.data);
            inds = inds{1};
%             disp(inds);
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
        
        function obj = run_simulation(obj, target_layer, target_cells, target_order, vary, tspan, opt, verbose)
            
            model_n = get(obj, 'model');
            
            set(obj, 'model', model_n);
            set(obj, 'data', obj.simulate(vary, tspan, opt));
            set(obj, 'last_outputs', obj.get_outputs(target_layer, target_cells, target_order));
            set(obj, 'last_inputs', vary.a);
           
            if verbose
                fprintf("Trial no. %d, output = %f \n", obj.last_trial, obj.get_outputs_spike());
            end
            
        end
        
        function obj = run_trial(obj, inputs, inputs_index, outputs_index, t, dt, target, lambda, mode, error_mode, verbose)
            
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
            
            if verbose
                fprintf("Trial no. %d, %s = %f, output = %f, target = %f\n", obj.last_trial, error_mode, obj.last_error, obj.get_outputs_spike(), target);
            end
            
            obj.train_step(lambda, mode);
            
        end
        
        function train_step(obj, lambda, mode) 
                            
            error = get(obj, 'last_error');
            
            if strcmpi(mode, 'normal')

                obj.update_weights_normal(lambda, error);
            
            elseif strcmpi(mode, 'uniform')
                
                obj.update_weights_uniform(lambda, error);
                
            else
                
                obj.update_weights_constant(lambda, error)
                
            end
            
        end
        
        function update_weights_normal(obj, lambda, error)
            
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
        
        function update_weights_uniform(obj, lambda, error)
            
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
