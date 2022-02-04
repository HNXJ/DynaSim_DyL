%%

clc;clear;
fprintf("Initialization...\n");

% Population sizes
Ne = 20;     % # of E cells per layer
Ni = Ne/4;  % # of I cells per layer
k = 0.5; % Randomness of initial weights

% Connectivity matrices

% E->I
Kei = k*rand(Ne, Ni) + (1-k); % all-to-all, connectivity from E cells to I cells; mid, sup, deep
% I->E
Kie = k*rand(Ni, Ne) + (1-k); % all-to-all, connectivity from I cells to E cells; mid, sup, deep

% E->E
Kee = k*rand(Ne, Ne) + (1-k); % recurrent E-to-E: mid, sup, deep
Kii = k*rand(Ni, Ni) + (1-k); % recurrent I-to-I: mid, sup, deep
Kffee = k*rand(Ne, Ne) + (1-k); % feedforward E-to-E: mid->sup, sup->deep
Kffie = k*rand(Ni, Ne) + (1-k); % feedforward I-to-E: mid->deep

% Time constants
tauGABA_gamma = 4.5; % ms, decay time constant of inhibition for gamma (50Hz)
tauGABA_beta = 22.5; % ms, decay time constant of inhibition for beta (25Hz)
tauAMPA = 2.25; % ms, decay time constant of fast excitation (AMPA)

% Maximal synaptic strengths
gAMPA_ei = .1; % E->I within layer
gAMPA_ffee = .1; % feedforward E->E, mid->sup, sup->deep
gGABAa_ffie = 0; % feedforward I->E, mid->deep

gAMPA_ee = 0; % E->E within layer
gGABAa_ie = 5; % I->E within layer
gGABAa_ii = 0; % I->I within layer

% neuronal dynamics
%eqns = 'dV/dt = (Iapp + @current + noise*randn(1,Npop))/C; {iNa,iK}; Iapp=0; noise=0; C=1';
eqns = 'dV/dt = (Iapp + @current + noise*randn(1,Npop))/C; Iapp=0; noise=0; C=1; V(0)=-65';

% create DynaSim specification structure

% Mechanism parameters

g_l_D1 = 0.096;      % mS/cm^2, Leak conductance for D1 SPNs 
g_l_D2 = 0.1;        % mS/cm^2, Leak conductance for D2 SPNs
g_cat_D1 = 0.018;    % mS/cm^2, Conductance of the T-type Ca2+ current for D1 SPNs
g_cat_D2 = 0.025;    % mS/cm^2, Conductance of the T-type Ca2+ current for D2 SPNs

tOn_pfcInp =  100;            % onset in ms, transient
tOff_pfcInp = 0+300; % 0 Was onset time in the PNAS, dyration was 1.5s
g_pfc_poisson = 3.5e-4;
DC_pfc_poisson = .1;

spn_cells = {'spn_iNa','spn_iK','spn_iLeak','spn_iM','spn_iCa','spn_CaBuffer','spn_iKca', 'spn_iPoisson'};
ctx_cells = {'iNa','iK'};%, 'ctx_iPoisson'};

cell_type = ctx_cells; % choose spn_cells and ctx_cells

t_end = 500;
dt = .01;
tspan = [0 t_end]; % [beg, end] (ms)

ping=[];
% Superficial layer
% E-cells
ping.populations(1).name = 'E';
ping.populations(1).size = Ne;
ping.populations(1).equations = eqns;
ping.populations(1).mechanism_list = cell_type;
ping.populations(1).parameters = {'Iapp',5,'noise',40};

% I-cells
ping.populations(2).name = 'I';
ping.populations(2).size = Ni;
ping.populations(2).mechanism_list = cell_type;
ping.populations(2).equations = eqns;
ping.populations(2).parameters = {'Iapp',0,'noise',10};

% E/I connectivity
ping.connections(1).direction = 'E->I';
ping.connections(1).mechanism_list = {'iAMPA'};
ping.connections(1).parameters = {'gAMPA',gAMPA_ei,'tauAMPA',tauAMPA,'netcon',Kei};
ping.connections(2).direction = 'E->E';
ping.connections(2).mechanism_list = {'iAMPA'};
ping.connections(2).parameters = {'gAMPA',gAMPA_ee,'tauAMPA',tauAMPA,'netcon',Kee};
ping.connections(3).direction = 'I->E';
ping.connections(3).mechanism_list = {'iGABAa'};
ping.connections(3).parameters = {'gGABAa',gGABAa_ie,'tauGABA',tauGABA_gamma,'netcon',Kie};
ping.connections(4).direction = 'I->I';
ping.connections(4).mechanism_list = {'iGABAa'};
ping.connections(4).parameters = {'gGABAa',gGABAa_ii,'tauGABA',tauGABA_gamma,'netcon',Kii};

% E-cells
% ping.populations(1).name = 'E';
% ping.populations(1).size = Ne;
% ping.populations(1).equations = eqns;
% ping.populations(1).mechanism_list = {cell_type{:},'ctx_iPoisson'};
% ping.populations(1).parameters = {'g_pfc_poisson',g_pfc_poisson,'Iapp',4,'noise',40,'cm',1,'g_l',g_l_D2,'g_cat',g_cat_D2,'onset_pfc_poisson',tOn_pfcInp,'offset_pfc_poisson',tOff_pfcInp};
% 
% % I-cells
% ping.populations(2).name = 'I';
% ping.populations(2).size = Ni;
% ping.populations(2).equations = eqns;
% ping.populations(1).mechanism_list = {cell_type{:},'ctx_iPoisson'};
% ping.populations(2).parameters = {'g_pfc_poisson',g_pfc_poisson,'Iapp',0,'noise',10,'cm',1,'g_l',g_l_D2,'g_cat',g_cat_D2,'onset_pfc_poisson',tOn_pfcInp,'offset_pfc_poisson',tOff_pfcInp};
% 
% % E/I connectivity
% ping.connections(1).direction = 'E->I';
% ping.connections(1).mechanism_list = {'iAMPA'};
% ping.connections(1).parameters = {'gAMPA',gAMPA_ei,'tauAMPA',tauAMPA,'netcon',Kei};
% ping.connections(2).direction = 'E->E';
% ping.connections(2).mechanism_list = {'iAMPA'};
% ping.connections(2).parameters = {'gAMPA',gAMPA_ee,'tauAMPA',tauAMPA,'netcon',Kee};
% ping.connections(3).direction = 'I->E';
% ping.connections(3).mechanism_list = {'iGABA'};
% ping.connections(3).parameters = {'gGABA',gGABAa_ie,'tauGABA',tauGABA_gamma,'netcon',Kie};
% ping.connections(4).direction = 'I->I';
% ping.connections(4).mechanism_list = {'iGABA'};
% ping.connections(4).parameters = {'gGABA',gGABAa_ii,'tauGABA',tauGABA_gamma,'netcon',Kii};

fprintf("Done.\n");

%%
% create independent layers

fprintf("Creating structure of model ...\n");

sup = dsApplyModifications(ping,{'E','name','supE'; 'I','name','supI'}); % superficial layer 
mid = dsApplyModifications(ping,{'E','name','midE'; 'I','name','midI'}); % middle layer 
deep = dsApplyModifications(ping,{'E','name','deepE'; 'I','name','deepI'}); % deep layer 

% update deep layer parameters to produce beta rhythm (25Hz)
deep = dsApplyModifications(deep,{'deepI->deepE','tauGABA',tauGABA_beta});

% % update ipoisson mechanism for deep layers
% deep = dsApplyModifications(deep,{'deepI','tau_pfc_poisson', 21});
% deep = dsApplyModifications(deep,{'deepE','tau_pfc_poisson', 18});
% 
% % update ipoisson mechanism for mid layers
% mid = dsApplyModifications(mid,{'midI','tau_pfc_poisson', 17});
% mid = dsApplyModifications(mid,{'midE','tau_pfc_poisson', 17});
% 
% % update ipoisson mechanism for superficial layers
% sup = dsApplyModifications(sup,{'supI','tau_pfc_poisson', 16});
% sup = dsApplyModifications(sup,{'supE','tau_pfc_poisson', 16});

% create full cortical specification
s = dsCombineSpecifications(sup, mid, deep);

%s.populations(1).mechanism_list{end+1} = 'ctx_iPoisson';

% connect the layers

% midE -> supE
c = length(s.connections)+1;
s.connections(c).direction = 'midE->supE';
s.connections(c).mechanism_list={'iAMPA'};
s.connections(c).parameters={'gAMPA',gAMPA_ffee,'tauAMPA',tauAMPA,'netcon',Kffee};
% midI -> deepE
c = length(s.connections)+1;
s.connections(c).direction = 'midI->deepE';
s.connections(c).mechanism_list={'iGABAa'};
s.connections(c).parameters={'gGABAa',gGABAa_ffie,'tauGABA',tauGABA_gamma,'netcon',Kffie};
% supE -> deepE
c = length(s.connections)+1;
s.connections(c).direction = 'supE->deepE';
s.connections(c).mechanism_list={'iAMPA'};
s.connections(c).parameters={'gAMPA',gAMPA_ffee,'tauAMPA',tauAMPA,'netcon',Kffee};

fprintf("Done.\n");

% Simulate
simulator_options = {'solver','rk1','dt',dt,'downsample_factor',1,'verbose_flag',1};

vary = [];
vary = {'supE','g_pfc_poisson',[.05]; 'supE','g_pfc_poisson',[1]; 'supE','DC_pfc_poisson',[0 100 1000]};%DC_pfc_poisson*[10]};
vary = {'supE','g_pfc_poisson',[.05]; 'supE','g_pfc_poisson',[1]; 'supE','DC_pfc_poisson',[1000]};%DC_pfc_poisson*[10]};
data=dsSimulate(s,'vary',vary,'tspan',tspan,simulator_options{:});

% Plots results
dsPlot(data);
dsPlot(data,'variable','supE_V');

return

%%

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

clc;

lambda = 0.001;
input_cues = {{eqns_input1}, {eqns_input2}};
target_responses = [10, 20];
batch_size = size(target_responses, 2);

input_layers = [3];
output_indice = {23}; % L3I Spikes
T = 300;
dT = 0.01;

update_mode = 'uniform';
error_mode = 'MSE';
verbose = 1;
iterations = 10;

m = DynaModel(s);

%%

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

fprintf("Starting simulation ...\n");

% Simulate
simulator_options = {'solver','rk1','dt',.01,'downsample_factor',10,'verbose_flag',1};
tspan = [0 400]; % [beg, end] (ms)

vary = [];
% vary = {'supI->supE','tauGABA',[2]; 
%        'deepI->deepE','tauGABA',[20]};   
% vary = {'I->E','tauGABA',[2 20]};

% vary = {'deepE', 'baseline_pfc_poisson=0', [18]};
% vary = {'deepE', 'tau_pfc_poisson', [2 20]};
% vary = {'deepE', 'g_pfc_poisson', [3e-2 3e-0]};
% vary = {'midI', 'f_pfc_poisson', [44]};

% data=dsSimulate(s,'vary',vary,'tspan',tspan,simulator_options{:});

% Plots results
% dsPlot(data);
dsPlot(data,'plot_type','raster');

fprintf("Done.\n");

%%

%{
beta2 (25Hz):
% Time constants
tauGABA = 10; % ms, decay time constant of inhibition
tauAMPA = 2; % ms, decay time constant of fast excitation (AMPA)
% Maximal synaptic strengths
gAMPA = .1;
gGABAa = 5;

gamma (50Hz):
% Time constants
tauGABA = 5; % ms, decay time constant of inhibition
tauAMPA = 2; % ms, decay time constant of fast excitation (AMPA)
% Maximal synaptic strengths
gAMPA = .1;
gGABAa = 5;
%}

%%