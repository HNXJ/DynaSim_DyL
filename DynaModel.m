classdef DynaModel

    properties
        model = [];
        current_trial = 0;
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
        
        function update_weights_stochastic(obj, lambda, error)
            
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