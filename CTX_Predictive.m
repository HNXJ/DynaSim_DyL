%% 3-layer neocortical model of PFC / Predictive task

% Manually determined weights version. 

%% Model parameters

clear;
clc;

Ne = 20;Ni = 4;Nio = 10;noise_rate = 13;
% s = NeoCortexPFC(Ne, Ni, Nio, noise_rate);
s = PredictiveNeoCortexPFC(Ne, Ni, Nio, noise_rate);

%% Create Dynamodel Class (variational)

m = DynaModelVary(s);

%% Simulate (Test of all scenarios)

g_poisson = 6.3e-4;
tspan = [0 500]; % [beg, end] (ms)
simulator_options = {'tspan', tspan, 'solver','rk1','dt',.01,'downsample_factor',10,'verbose_flag',1, 'mex_flag',0 };
% simulator_options = {'dv/dt=0', 'mex_flag', 1};

vary1 = {'SA1','g_poisson', g_poisson; 'SA1','DC_poisson', 4e7;'SA1','AC_poisson', 0; 'SA1', 'onset_poisson', [150 250]; 'SA1', 'offset_poisson', 250;
       'SA2','g_poisson', g_poisson; 'SA2','DC_poisson', 4e7;'SA2','AC_poisson', 0; 'SA2', 'onset_poisson', 250; 'SA2', 'offset_poisson', 350;
       'SB1','g_poisson', g_poisson; 'SB1','DC_poisson', 4e7;'SB1','AC_poisson', 0; 'SB1', 'onset_poisson', [150 250]; 'SB1', 'offset_poisson', 250;
       'SB2','g_poisson', g_poisson; 'SB2','DC_poisson', 4e7;'SB2','AC_poisson', 0; 'SB2', 'onset_poisson', 250; 'SB2', 'offset_poisson', 350;
       'SC1','g_poisson', g_poisson; 'SC1','DC_poisson', 4e7;'SC1','AC_poisson', 0; 'SC1', 'onset_poisson', [150 250]; 'SC1', 'offset_poisson', 250;
       'SC2','g_poisson', g_poisson; 'SC2','DC_poisson', 4e7;'SC2','AC_poisson', 0; 'SC2', 'onset_poisson', 250; 'SC2', 'offset_poisson', 350;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 4e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 150; 'Cx1', 'offset_poisson', 350;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 4e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 350; 'Cx2', 'offset_poisson', 350};

% data1 = dsSimulate(s, 'vary', vary, simulator_options{:});
m.run_simulation(vary1, simulator_options); 

%% Plots results (normal/raster)

clc;
cue_states = 1:8;
a = m.data(cue_states);
dsPlot(a,'plot_type','raster'); % Raster

%% Extract outputs & compare

clc;  
cue_states = [4, 6, 7, 8];
ifr_compare_plot_p(m.data(cue_states), 1:10, 11:20, 150, 240, 260, 350, 51);

%% Trial: training script

% Define parameters

iterations = 1;
lambda = 0.001;
update_mode = 'uniform';
error_mode = 'MSE';

target_order = [1, 0; 0, 1; 0, 1; 1, 0; 0, 0; 0, 0];
target_label = 'deepE_V';
target_cells = [1:10; 11:20];
target_tspan = [120, 280];

tspan = [0 400]; % [beg, end] (ms)
simulator_options = {'tspan', tspan, 'solver','rk1','dt',.01,'downsample_factor',10,'verbose_flag', 0, 'mex_flag', 0};
g_poisson = 6.4e-4;

vary1 = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', 120; 'SA', 'offset_poisson', 280;
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', 280; 'SB', 'offset_poisson', 280;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 120; 'Cx1', 'offset_poisson', 280;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 280; 'Cx2', 'offset_poisson', 280};

vary2 = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', 280; 'SA', 'offset_poisson', 280;
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', 120; 'SB', 'offset_poisson', 280;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 120; 'Cx1', 'offset_poisson', 280;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 280; 'Cx2', 'offset_poisson', 280};
   
vary3 = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', 120; 'SA', 'offset_poisson', 280;
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', 280; 'SB', 'offset_poisson', 280;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 280; 'Cx1', 'offset_poisson', 280;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 120; 'Cx2', 'offset_poisson', 280};

vary4 = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', 280; 'SA', 'offset_poisson', 280;
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', 120; 'SB', 'offset_poisson', 280;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 280; 'Cx1', 'offset_poisson', 280;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 120; 'Cx2', 'offset_poisson', 280};

vary5 = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', 280; 'SA', 'offset_poisson', 280;
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', 280; 'SB', 'offset_poisson', 280;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 120; 'Cx1', 'offset_poisson', 280;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 280; 'Cx2', 'offset_poisson', 280};

vary6 = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', 280; 'SA', 'offset_poisson', 280;
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', 280; 'SB', 'offset_poisson', 280;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 280; 'Cx1', 'offset_poisson', 280;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 120; 'Cx2', 'offset_poisson', 280};
   
varies = [{vary1}, {vary2}, {vary3}, {vary4}, {vary5}, {vary6}];
input_labels = ["A_C1", "B_C1", "A_C2", 'B_C2', 'N_C1', 'N_C2'];
batch_size = 6;
verbose = 1;

%%

tic;
clc;
fprintf("Training started, connectivity update mode : %s, error calc method : %s\n", update_mode, error_mode);

for i = 1:iterations
    
    for j = 1:batch_size
        
        params = [];
        
        params.input_label = input_labels(j);
        params.vary = varies{j};
        params.target_label = target_label;
        params.target_cells = target_cells;
        
        params.target_tspan = target_tspan;
        params.target_order = target_order;
        params.simulation_options = simulator_options;
        params.lambda = lambda;
        
        params.error_mode = error_mode;
        params.update_mode = update_mode;
        params.verbose = verbose;
        m.run_trial(params);
        
    end
    
%     fprintf("Batch %d, Avg.MAE = %f \n", i, mean(m.errors_log(end-1:end)));
    
end

disp('done');
toc;

%% Electrophysiological analysis

clc;
[c, e, t] = m.get_potentials();

k = 6;
figure();
plot(t, mean(e{k, 1}, 2));
title("LFP of " + c{k, 1});
grid("on");

%%