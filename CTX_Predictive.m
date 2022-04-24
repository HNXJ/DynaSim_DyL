%% 3-layer neocortical model of PFC / Predictive task

% Manually determined weights version. 
% memoize.m -> suspended due to an error
% dsModel: 

%% Model parameters

clear;
clc;

Ne = 20;Ni = 4;Nio = 10;noise_rate = 13;
% s = NeoCortex(Ne, Ni, Nio, noise_rate);
% s = dlDemoPING(5, 1, 2, noise_rate); % 17 Mins on mex generator
% s = dlDemoPredictivePFC(Ne, Ni, Nio, noise_rate);

%% Create DynaLearn Class (First time)

m = DynaLearn(s, 'models/dlPredictivePFC'); % ~ 120min
m.dlSimulate(); % ~ 40sec
m.dlSave(); % < 1sec

%% Load DynaLearn Class (previously saved file is required, default is dlFileBase.mat)

clc;
m = DynaLearn(); % ~ 1sec
m = m.dlLoad('models/dlPredictivePFC/dlFile.mat'); % ~ 12sec
m.dlSimulate(); % ~ 40sec

%% Continue simulation: Vary example

clc;
g_poisson = 6.3e-4;
dc_poisson = 4e7;

vary = containers.Map();
vary('tspan') = [0 500];

vary('SA1_ctx_iPoisson_g_poisson') = g_poisson;
vary('SA2_ctx_iPoisson_g_poisson') = g_poisson;
vary('SB1_ctx_iPoisson_g_poisson') = g_poisson;
vary('SB2_ctx_iPoisson_g_poisson') = g_poisson;
vary('SC1_ctx_iPoisson_g_poisson') = g_poisson;
vary('SC2_ctx_iPoisson_g_poisson') = g_poisson;

vary('SA1_ctx_iPoisson_DC_poisson') = dc_poisson;
vary('SA2_ctx_iPoisson_DC_poisson') = dc_poisson;
vary('SB1_ctx_iPoisson_DC_poisson') = dc_poisson;
vary('SB2_ctx_iPoisson_DC_poisson') = dc_poisson;
vary('SC1_ctx_iPoisson_DC_poisson') = dc_poisson;
vary('SC2_ctx_iPoisson_DC_poisson') = dc_poisson;

vary('SA1_ctx_iPoisson_onset_poisson') = 150;
vary('SA1_ctx_iPoisson_offset_poisson') = 250;
vary('SA2_ctx_iPoisson_onset_poisson') = 250;
vary('SA2_ctx_iPoisson_offset_poisson') = 350;

vary('SB1_ctx_iPoisson_onset_poisson') = 250;
vary('SB1_ctx_iPoisson_offset_poisson') = 250;
vary('SB2_ctx_iPoisson_onset_poisson') = 350;
vary('SB2_ctx_iPoisson_offset_poisson') = 350;

vary('SC1_ctx_iPoisson_onset_poisson') = 250;
vary('SC1_ctx_iPoisson_offset_poisson') = 250;
vary('SC2_ctx_iPoisson_onset_poisson') = 350;
vary('SC2_ctx_iPoisson_offset_poisson') = 350;

%% Inputs preparation

varys = {vary, vary, vary};

varys{1}('SA1_ctx_iPoisson_onset_poisson') = 150;
varys{1}('SA1_ctx_iPoisson_offset_poisson') = 250;
varys{1}('SA2_ctx_iPoisson_onset_poisson') = 250;
varys{1}('SA2_ctx_iPoisson_offset_poisson') = 350;

varys{1}('SB1_ctx_iPoisson_onset_poisson') = 250;
varys{1}('SB1_ctx_iPoisson_offset_poisson') = 250;
varys{1}('SB2_ctx_iPoisson_onset_poisson') = 350;
varys{1}('SB2_ctx_iPoisson_offset_poisson') = 350;

varys{1}('SC1_ctx_iPoisson_onset_poisson') = 250;
varys{1}('SC1_ctx_iPoisson_offset_poisson') = 250;
varys{1}('SC2_ctx_iPoisson_onset_poisson') = 350;
varys{1}('SC2_ctx_iPoisson_offset_poisson') = 350;

varys{2}('SA1_ctx_iPoisson_onset_poisson') = 250;
varys{2}('SA1_ctx_iPoisson_offset_poisson') = 250;
varys{2}('SA2_ctx_iPoisson_onset_poisson') = 350;
varys{2}('SA2_ctx_iPoisson_offset_poisson') = 350;

varys{2}('SB1_ctx_iPoisson_onset_poisson') = 150;
varys{2}('SB1_ctx_iPoisson_offset_poisson') = 250;
varys{2}('SB2_ctx_iPoisson_onset_poisson') = 250;
varys{2}('SB2_ctx_iPoisson_offset_poisson') = 350;

varys{2}('SC1_ctx_iPoisson_onset_poisson') = 250;
varys{2}('SC1_ctx_iPoisson_offset_poisson') = 250;
varys{2}('SC2_ctx_iPoisson_onset_poisson') = 350;
varys{2}('SC2_ctx_iPoisson_offset_poisson') = 350;

varys{3}('SA1_ctx_iPoisson_onset_poisson') = 250;
varys{3}('SA1_ctx_iPoisson_offset_poisson') = 250;
varys{3}('SA2_ctx_iPoisson_onset_poisson') = 350;
varys{3}('SA2_ctx_iPoisson_offset_poisson') = 350;

varys{3}('SB1_ctx_iPoisson_onset_poisson') = 250;
varys{3}('SB1_ctx_iPoisson_offset_poisson') = 250;
varys{3}('SB2_ctx_iPoisson_onset_poisson') = 350;
varys{3}('SB2_ctx_iPoisson_offset_poisson') = 350;

varys{3}('SC1_ctx_iPoisson_onset_poisson') = 150;
varys{3}('SC1_ctx_iPoisson_offset_poisson') = 250;
varys{3}('SC2_ctx_iPoisson_onset_poisson') = 250;
varys{3}('SC2_ctx_iPoisson_offset_poisson') = 350;

outputlabels = [{'DeepE_V', 1:4, [250 350], 'afr'}; {'DeepE_V', 5:8, [250 350], 'ifr'}; {'DeepE_V', 9:12, [250 350]}];

%% Trial: training script

clc;
dlEpochs = 3;
dlBatchs = 3;
dlVaryList = varys;

dlTargets = [1, 2, 3]; % TODO Change it
dlOutputLabel = outputlabels;
dlOutputType = 'afr';
dlLearningRule = 'DeltaRule';

m.dlTrain(dlEpochs, dlBatchs, dlVaryList, dlTargets, dlOutputLabel, dlOutputType, dlLearningRule);

%% (Deprecated)Define parameters

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