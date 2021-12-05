classdef DynaModel

    properties
        s = [];
        trials = 1;
        cues = [];
        data = [];
    end
    
    methods
        
        function obj = DynaModel(s)
            if nargin == 1
                obj.s = s;
            end
        end
        
        function set_weights(obj, connection, Wn)
            obj.s.connections(connection).parameters = {'netcon', Wn};
        end
        
        function w = get_weights(obj, connection)
            obj.data.model.fixed_variables.L4_L5_iAMPA_netcon
        end
        
    end
end