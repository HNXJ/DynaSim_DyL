%% 3-layer neocortical model of PFC

% Manually determined weights version. 

%% Model parameters

clear;
clc;
s = neoCortexPFC();

%% Create Dynamodel Class (variational)

m = DynaModelVary(s);

%% Simulate (Test of all scenarios)

g_poisson = 6.4e-4;
tspan = [0 900]; % [beg, end] (ms)
simulator_options = {'tspan', tspan, 'solver','rk1','dt',.01,'downsample_factor',10,'verbose_flag',1, 'mex_flag', 1};

vary = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', [300 600]; 'SA', 'offset_poisson', [600];
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', [300 600]; 'SB', 'offset_poisson', [600];
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', [600]; 'Cx1', 'offset_poisson', [600];
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', [300]; 'Cx2', 'offset_poisson', [600]};
   
data1 = dsSimulate(s, 'vary', vary, simulator_options{:});
% m.run_simulation(vary, simulator_options); 

%% Plots results (normal/raster)

clc;
dsPlot(m.data,'plot_type','raster'); % Raster

%% Extract outputs & compare

clc;
ifr_compare_plot(m.data);

%% Trial: training script

% Define parameters

iterations = 1;
lambda = 0.001;
update_mode = 'uniform';
error_mode = 'MSE';

target_order = [1, 0; 0, 1; 0, 1; 1, 0; 0, 0; 0, 0];
target_label = 'deepE_V';
target_cells = [1:10; 11:20];
target_tspan = [300, 600];

tspan = [0 900]; % [beg, end] (ms)
simulator_options = {'tspan', tspan, 'solver','rk1','dt',.01,'downsample_factor',10,'verbose_flag',1, 'mex_flag', 0};
g_poisson = 6.4e-4;

vary1 = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', 300; 'SA', 'offset_poisson', 600;
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', 600; 'SB', 'offset_poisson', 600;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 300; 'Cx1', 'offset_poisson', 600;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 600; 'Cx2', 'offset_poisson', 600};

vary2 = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', 600; 'SA', 'offset_poisson', 600;
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', 300; 'SB', 'offset_poisson', 600;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 300; 'Cx1', 'offset_poisson', 600;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 600; 'Cx2', 'offset_poisson', 600};
   
vary3 = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', 300; 'SA', 'offset_poisson', 600;
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', 600; 'SB', 'offset_poisson', 600;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 600; 'Cx1', 'offset_poisson', 600;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 300; 'Cx2', 'offset_poisson', 600};

vary4 = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', 600; 'SA', 'offset_poisson', 600;
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', 300; 'SB', 'offset_poisson', 600;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 600; 'Cx1', 'offset_poisson', 600;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 300; 'Cx2', 'offset_poisson', 600};

vary5 = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', 600; 'SA', 'offset_poisson', 600;
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', 600; 'SB', 'offset_poisson', 600;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 300; 'Cx1', 'offset_poisson', 600;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 600; 'Cx2', 'offset_poisson', 600};

vary6 = {'SA','g_poisson', g_poisson; 'SA','DC_poisson', 3e7;'SA','AC_poisson', 0; 'SA', 'onset_poisson', 600; 'SA', 'offset_poisson', 600;
       'SB','g_poisson', g_poisson; 'SB','DC_poisson', 3e7;'SB','AC_poisson', 0; 'SB', 'onset_poisson', 600; 'SB', 'offset_poisson', 600;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 3e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 600; 'Cx1', 'offset_poisson', 600;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 3e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 300; 'Cx2', 'offset_poisson', 600};
   
varies = [{vary1}, {vary2}, {vary3}, {vary4}, {vary5}, {vary6}];
input_labels = ['A_C1', 'B_C1', 'A_C2', 'B_C2', 'N_C1', 'N_C2'];
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

%%