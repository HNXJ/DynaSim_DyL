classdef DynaModel

    properties
        model = [];
        last_trial = 0;
        last_input = [];
        last_output = [];
        
        cues = [];
        data = [];
        connections = [];
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
        
        function c = get_connections_list(obj)
           st = obj.data.model.fixed_variables;
           c = fieldnames(st);
        end
        
        function run_trial(obj, inputs)
            
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