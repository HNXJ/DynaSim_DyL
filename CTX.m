%% 3-layer neocortical model of PFC

% Manually determined weights version. 

%% Model parameters

clear;
clc;

s = neoCortexPFC();

%% Create Dynamodel Class (variational)

m = DynaModelVary(s);

%% Simulate

fprintf("Running simulation ...\n");

g_poisson = 6.4e-4;
simulator_options = {'solver','rk1','dt',.01,'downsample_factor',10,'verbose_flag',1};
tspan = [0 900]; % [beg, end] (ms)

vary = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', [300 600]; 'SA', 'offset_poisson', [600];
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', [300 600]; 'SB', 'offset_poisson', [600];
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', [600]; 'Cx1', 'offset_poisson', [600];
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', [300]; 'Cx2', 'offset_poisson', [600]};
   
data=dsSimulate(s,'vary',vary,'tspan',tspan,simulator_options{:});

fprintf("Simulation done.\n");  

%% Plots results (normal/raster)

clc;
% dsPlot(data);
dsPlot(data,'plot_type','raster'); % Raster

%% Extract outputs & compare

clc;
% Instanteneous firing rate compare between input 1 and 2 (special case) 
ifr_compare_plot(data);

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

%%