classdef DynaModel

    properties
        model = [];
        data = [];
        errors = [];
        connections = [];
    
        last_trial = 0;
        last_inputs = [];
        last_outputs = [];
        last_error = [];
    end
    
    methods
        
        function obj = DynaModel(model_)
            obj.model = model_;
            obj.data = obj.init();
            obj.connections = obj.get_connections_list();
        end
        
        function d = init(obj)
            d = dsSimulate(obj.model, 'solver', 'rk1', 'dt', .01, 'time_limits', [0 10], 'downsample_factor', 10, 'verbose_flag',1);
        end
        
        function d = simulate(obj, t, dt)
            d = dsSimulate(obj.model, 'solver', 'rk1', 'dt', dt, 'time_limits', [0 t], 'downsample_factor', 10, 'verbose_flag',1);
        end
        
        function c = get_connections_list(obj)
            st = obj.data.model.fixed_variables;
            c = fieldnames(st);
        end
        
        function o = get_outputs(obj, inds)
            st = struct2cell(obj.data);
            o = st(inds);
        end
        
        function obj = run_trial(obj, inputs, inputs_index, outputs_index, t, dt)
            for i = inputs_index
                obj.model.populations(i).equations = inputs(i);
            end
            
            obj.data = obj.simulate(obj, t, dt);
            outputs = obj.get_outputs(outputs_index);
            
            obj.last_inputs = inputs;
            obj.last_outputs = outputs;
            
        end
        
        function train_step(obj, lambda)
            
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