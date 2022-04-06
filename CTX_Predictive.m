%% 3-layer neocortical model of PFC / Predictive task

% Manually determined weights version. 
% memoize.m -> suspended due to an error
% dsModel: 

%% Model parameters

clear;
clc;

Ne = 20;Ni = 4;Nio = 10;noise_rate = 13;
% s = NeoCortexPFC(Ne, Ni, Nio, noise_rate);
s = PING(5, 1, 2, noise_rate); % 17 Mins on mex generator
% s = PredictiveNeoCortexPFC(Ne, Ni, Nio, noise_rate);

%%

clc;
fprintf("Updating parameters ...\n");
p = load('params1.mat');
% p = p.p;
p.p.tspan = [120 2100];
save('params1.mat', '-struct', 'p');
fprintf("Simulation done.\n");
            
%% Create DynaLearn Class (variational)

m = DynaLearn(s, 'ping_test');

%% Simulate (Test of all scenarios)

g_poisson = 6.3e-4;
tspan = [0 500]; % [beg, end] (ms)
simulator_options = {'tspan', tspan, 'solver', 'rk1', 'dt', .01, 'downsample_factor', 10, 'verbose_flag', 1, 'study_dir', 'model2', 'mex_flag', 1};

vary1 = {'SA1','g_poisson', g_poisson; 'SA1','DC_poisson', 4e7;'SA1','AC_poisson', 0; 'SA1', 'onset_poisson', [150 250]; 'SA1', 'offset_poisson', 250;
       'SA2','g_poisson', g_poisson; 'SA2','DC_poisson', 4e7;'SA2','AC_poisson', 0; 'SA2', 'onset_poisson', 250; 'SA2', 'offset_poisson', 350;
       'SB1','g_poisson', g_poisson; 'SB1','DC_poisson', 4e7;'SB1','AC_poisson', 0; 'SB1', 'onset_poisson', [250]; 'SB1', 'offset_poisson', 250;
       'SB2','g_poisson', g_poisson; 'SB2','DC_poisson', 4e7;'SB2','AC_poisson', 0; 'SB2', 'onset_poisson', 250; 'SB2', 'offset_poisson', 350;
       'SC1','g_poisson', g_poisson; 'SC1','DC_poisson', 4e7;'SC1','AC_poisson', 0; 'SC1', 'onset_poisson', [250]; 'SC1', 'offset_poisson', 250;
       'SC2','g_poisson', g_poisson; 'SC2','DC_poisson', 4e7;'SC2','AC_poisson', 0; 'SC2', 'onset_poisson', 250; 'SC2', 'offset_poisson', 350;
       'Cx1','g_poisson', g_poisson; 'Cx1','DC_poisson', 4e7;'Cx1','AC_poisson', 0; 'Cx1', 'onset_poisson', 150; 'Cx1', 'offset_poisson', 350;
       'Cx2','g_poisson', g_poisson; 'Cx2','DC_poisson', 4e7;'Cx2','AC_poisson', 0; 'Cx2', 'onset_poisson', 350; 'Cx2', 'offset_poisson', 350};

data1 = dsSimulate(s, 'vary', vary1, simulator_options{:});
% m.run_simulation(vary1, simulator_options); 

%% MEX run

clc;
tic;
[T,supE_V,supE_iNa_m,supE_iNa_h,supE_iK_n,supI_V,supI_iNa_m,supI_iNa_h,supI_iK_n,midE_V,midE_iNa_m,midE_iNa_h,midE_iK_n,midI_V,midI_iNa_m,midI_iNa_h,midI_iK_n,deepE_V,deepE_iNa_m,deepE_iNa_h,deepE_iK_n,deepI_V,deepI_iNa_m,deepI_iNa_h,deepI_iK_n,SA1_V,SA1_iNa_m,SA1_iNa_h,SA1_iK_n,SB1_V,SB1_iNa_m,SB1_iNa_h,SB1_iK_n,SC1_V,SC1_iNa_m,SC1_iNa_h,SC1_iK_n,SA2_V,SA2_iNa_m,SA2_iNa_h,SA2_iK_n,SB2_V,SB2_iNa_m,SB2_iNa_h,SB2_iK_n,SC2_V,SC2_iNa_m,SC2_iNa_h,SC2_iK_n,Cx1_V,Cx1_iNa_m,Cx1_iNa_h,Cx1_iK_n,Cx2_V,Cx2_iNa_m,Cx2_iNa_h,Cx2_iK_n,supI_supE_iAMPActx_s,supE_supE_iAMPActx_s,supE_supI_iGABActx_s,supI_supI_iGABActx_s,midI_midE_iAMPActx_s,midE_midE_iAMPActx_s,midE_midI_iGABActx_s,midI_midI_iGABActx_s,deepI_deepE_iAMPActx_s,deepE_deepE_iAMPActx_s,deepE_deepI_iGABActx_s,deepI_deepI_iGABActx_s,SB1_SA1_iAMPActx_s,SA1_SA1_iAMPActx_s,SA1_SB1_iGABActx_s,SB1_SB1_iGABActx_s,SA2_SC1_iAMPActx_s,SC1_SC1_iAMPActx_s,SC1_SA2_iGABActx_s,SA2_SA2_iGABActx_s,SC2_SB2_iAMPActx_s,SB2_SB2_iAMPActx_s,SB2_SC2_iGABActx_s,SC2_SC2_iGABActx_s,Cx2_Cx1_iAMPActx_s,Cx1_Cx1_iAMPActx_s,Cx1_Cx2_iGABActx_s,Cx2_Cx2_iGABActx_s,midE_SA1_iAMPActx_s,midE_SA2_iAMPActx_s,midE_SB1_iAMPActx_s,midE_SB2_iAMPActx_s,midE_SC1_iAMPActx_s,midE_SC2_iAMPActx_s,midE_Cx1_iAMPActx_s,midE_Cx2_iAMPActx_s,supE_midE_iAMPActx_s,deepE_midE_iAMPActx_s,deepE_midI_iGABActx_s,deepE_supE_iAMPActx_s,supE_ctx_iPoisson_g_poisson,supE_ctx_iPoisson_I_poisson,supI_ctx_iPoisson_g_poisson,supI_ctx_iPoisson_I_poisson,midE_ctx_iPoisson_g_poisson,midE_ctx_iPoisson_I_poisson,midI_ctx_iPoisson_g_poisson,midI_ctx_iPoisson_I_poisson,deepE_ctx_iPoisson_g_poisson,deepE_ctx_iPoisson_I_poisson,deepI_ctx_iPoisson_g_poisson,deepI_ctx_iPoisson_I_poisson,SA1_ctx_iPoisson_g_poisson,SA1_ctx_iPoisson_I_poisson,SB1_ctx_iPoisson_g_poisson,SB1_ctx_iPoisson_I_poisson,SC1_ctx_iPoisson_g_poisson,SC1_ctx_iPoisson_I_poisson,SA2_ctx_iPoisson_g_poisson,SA2_ctx_iPoisson_I_poisson,SB2_ctx_iPoisson_g_poisson,SB2_ctx_iPoisson_I_poisson,SC2_ctx_iPoisson_g_poisson,SC2_ctx_iPoisson_I_poisson,Cx1_ctx_iPoisson_g_poisson,Cx1_ctx_iPoisson_I_poisson,Cx2_ctx_iPoisson_g_poisson,Cx2_ctx_iPoisson_I_poisson,supE_ctx_iPoisson_s_poisson,supI_ctx_iPoisson_s_poisson,midE_ctx_iPoisson_s_poisson,midI_ctx_iPoisson_s_poisson,deepE_ctx_iPoisson_s_poisson,deepI_ctx_iPoisson_s_poisson,SA1_ctx_iPoisson_s_poisson,SB1_ctx_iPoisson_s_poisson,SC1_ctx_iPoisson_s_poisson,SA2_ctx_iPoisson_s_poisson,SB2_ctx_iPoisson_s_poisson,SC2_ctx_iPoisson_s_poisson,Cx1_ctx_iPoisson_s_poisson,Cx2_ctx_iPoisson_s_poisson] = solve_ode_20220321175632_948_mex();
toc;

%% Parameters

clc;
load("params.mat");

%% Plot (new version)

plot(deepE_V);

%% Plots results (normal/raster)

clc;
cue_states = 1:2;
a = data1(cue_states);
% dsPlot(data1); % Raster

%% Extract outputs & compare

clc;  
cue_states = [1:2];
ifr_compare_plot_p(data1(cue_states), 1:10, 11:20, 150, 240, 260, 350, 51);

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
figure();

for k = 1:6
    
    subplot(3, 2, k);
    plot(t, mean(e{k, 1}, 2));
    title("LFP of " + c{k, 1});
    grid("on");
    
end

%%