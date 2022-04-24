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

outputParams = [{'DeepE_V', 1:4, [250 350], 'afr'}; {'DeepE_V', 5:8, [250 350], 'afr'}; {'DeepE_V', 9:12, [250 350], 'afr'}; {'DeepE_V', 13:16, [250 350], 'afr'}; {'DeepE_V', 17:20, [250 350], 'afr'}];
targetParams = [{'MSE', 1, 4, 0.25}; {'Compare', [2, 1, 3], 0, 0.5}; {'Compare', [4, 2, 5], 0, 0.25}];
%% Trial: training script

clc;
dlEpochs = 3;
dlBatchs = 3;
dlVaryList = varys;

dlTargetParameters = targetParams;
dlOutputParameters = outputParams;
dlLearningRule = 'DeltaRule';
dlLambda = 0.00;

m.dlTrain(dlEpochs, dlBatchs, dlVaryList, dlOutputParameters, dlTargetParameters, dlLearningRule, dlLambda);

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