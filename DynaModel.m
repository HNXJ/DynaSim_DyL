classdef DynaModel < matlab.mixin.SetGet

    properties
        
        model = [];
        data = [];
        errors = [];
        connections = [];
    
        last_trial = 0;
        last_inputs = [];
        last_outputs = [];
        last_error = [];
        
        last_targets = [];
        
    end
    
    methods
        
        function obj = DynaModel(model_)
            
            set(obj, 'model', model_);
            set(obj, 'data', obj.init());
            set(obj, 'connections', obj.get_connections_list());
            
        end
        
        function set.model(obj, val)
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
        
        function set.errors(obj, val)
             if ~strcmpi(class(val), 'double') 
                error('Errors log must be a double array');
             end
             obj.errors = val;
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
        
        function o = init(obj)
            
            o = dsSimulate(obj.model, 'solver', 'rk1', 'dt', .01, 'time_limits', [0 100], 'downsample_factor', 10, 'verbose_flag',1);
        
        end
        
        function o = simulate(obj, t, dt)
            
            o = dsSimulate(obj.model, 'solver', 'rk1', 'dt', dt, 'time_limits', [0 t], 'downsample_factor', 10, 'verbose_flag',1);
      
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
        
        function obj = update_error(obj)
            
            output = get(obj, 'last_outputs');
            output = sum(sum(double(output{1})));
            target = get(obj, 'last_targets');
            
            err = (target-output)/10; % TODO ERROR CALC
            set(obj, 'errors', [get(obj, 'errors'), err]);
            set(obj, 'last_error', err);
            
        end
        
        function obj = run_trial(obj, inputs, inputs_index, outputs_index, t, dt, target, lambda)
            
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
            
            obj.update_error();
            obj.train_step(lambda);
            
        end
        
        function train_step(obj, lambda) 
            
            for i = 1:size(obj.connections)
                
                % Incomplete Rascorla-Wagner rule
                
            end
            
        end
        
        function update_weights_stochastic_normal(obj, lambda, error)
            for i = 1:size(obj.connections, 1)
               wp = obj.get_weights(i);
               wn = wp + lambda*error*randn(size(wp));
               obj.set_weights(i, wn);
            end
        end
        
        function update_weights_stochastic_uniform(obj, lambda, error)
            
            for i = 1:size(obj.connections, 1)
               wp = obj.get_weights(i);
               wn = wp + lambda*error*rand(size(wp));
               obj.set_weights(i, wn);
            end
            
        end
        
        function update_weights_constant(obj, lambda, error)
            for i = 1:size(obj.connections, 1)
               wp = obj.get_weights(i);
               wn = wp + lambda*error*ones(size(wp));
               obj.set_weights(i, wn);
            end
        end
        
        function set_weights(obj, connection, Wn)
            obj.s.connections(connection).parameters = {'netcon', Wn};
        end
        
        function w = get_weights(obj, connection)
            w_s = obj.data.model.fixed_variables;
            w_c = struct2cell(w_s);
            w = w_c(connection);
            w = w{1};
        end
        
    end
end