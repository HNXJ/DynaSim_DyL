%% 6-Layer laminar example

clc;
m = DynaModel('Files/f1_init.mat'); % Loading
m.save_model('Files/f1_init.mat'); % Saving

%% Raw laminar example

clc;
m = RawLaminar();

eqns_input1={
    'u(t, T) = exp(-10*(t-T)^2);'
    'dv/dt = 20*u(t, 200);'
    'monitor iGABAa.functions, iAMPA.functions'
    'monitor v.spikes(0)'
};

eqns_input2={
    'u(t, T) = exp(-10*(t-T)^2);'
    'dv/dt = - 20*u(t, 200);'
    'v(0) = 11.21;'
    'monitor iGABAa.functions, iAMPA.functions'
    'monitor v.spikes(0)'
};

%% Trial: training script

clc;

% Define parameters

lambda = 0.001;
input_cues = {{eqns_input1, eqns_input2}, {eqns_input2, eqns_input1}};
target_responses = [12, 6];
batch_size = size(target_responses, 2);

input_layers = [7, 8];
output_indice = {53}; % L3I Spikes
T = 300;
dT = 0.01;

update_mode = 'uniform';
error_mode = 'MSE';
verbose = 1;
iterations = 4;

fprintf("Training started, connectivity update mode : %s, error calc method : %s\n", update_mode, error_mode);

for i = 1:iterations
    
    for j = 1:batch_size
        
        c_input = input_cues(j);
        c_input = c_input{1};
        c_target = target_responses(j);
        m.run_trial(c_input, input_layers, output_indice, T, dT, c_target, lambda, update_mode, error_mode, verbose);
    
    end
    
    fprintf("Batch %d, Avg.MAE = %f \n", i, mean(m.errors_log(end-1:end)));
    
end

disp('done');

%% Voltage visualization

clc;
dsPlot(m.data);

%% Error plot

clc;
m.error_plot('Error of target-output (MAE)');

%% Single trial step

disp("Testing ... ");

for j = 1:2
    c_input = input_cues(j);
    c_input = c_input{1};
    c_target = target_responses(j);
    m.run_simulation(c_input, input_layers, output_indice, T, dT, verbose);
    fprintf("O = %f, T = %f\n", m.get_outputs_spike(), c_target);     
end

%% Extract and see field names for input/output index checking

clc;
f = fieldnames(m.data);

%%