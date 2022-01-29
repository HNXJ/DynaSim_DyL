% 3-layer neocortical model

% Population sizes
Ne = 4;     % # of E cells per layer
Ni = Ne/4;  % # of I cells per layer

% Connectivity matrices
% E->I
Kei = ones(Ne, Ni); % all-to-all, connectivity from E cells to I cells; mid, sup, deep
% I->E
Kie = ones(Ni, Ne); % all-to-all, connectivity from I cells to E cells; mid, sup, deep
% E->E
Kee = ones(Ne, Ne); % recurrent E-to-E: mid, sup, deep
Kii = ones(Ni, Ni); % recurrent I-to-I: mid, sup, deep
Kffee = ones(Ne, Ne); % feedforward E-to-E: mid->sup, sup->deep
Kffie = ones(Ni, Ne); % feedforward I-to-E: mid->deep

% Time constants
tauGABA_gamma = 5; % ms, decay time constant of inhibition for gamma (50Hz)
tauGABA_beta = 10; % ms, decay time constant of inhibition for beta (25Hz)
tauAMPA = 2; % ms, decay time constant of fast excitation (AMPA)

% Maximal synaptic strengths
gAMPA_ei = .1; % E->I within layer
gAMPA_ffee = .1; % feedforward E->E, mid->sup, sup->deep
gGABAa_ffie = 0; % feedforward I->E, mid->deep
gAMPA_ee = 0; % E->E within layer
gGABAa_ie = 5; % I->E within layer
gGABAa_ii = 0; % I->I within layer

% neuronal dynamics
eqns = 'dV/dt = (Iapp + @current + noise*randn(1,Npop))/C; {iNa,iK}; Iapp=0; noise=0; C=1';

% create DynaSim specification structure
ping=[];
% Superficial layer
% E-cells
ping.populations(1).name = 'E';
ping.populations(1).size = Ne;
ping.populations(1).equations = eqns;
ping.populations(1).parameters = {'Iapp',5,'noise',40};
% I-cells
ping.populations(2).name = 'I';
ping.populations(2).size = Ni;
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

%vary = {'I->E','gGABAa',[0, .1, 1, 10]};
%vary = {'I->E','gGABAa',[1, 5]; 
%        'I->E','tauGABA',[5, 10]};

% create independent layers
sup = dsApplyModifications(ping,{'E','name','supE'; 'I','name','supI'}); % superficial layer 
mid = dsApplyModifications(ping,{'E','name','midE'; 'I','name','midI'}); % middle layer 
deep = dsApplyModifications(ping,{'E','name','deepE'; 'I','name','deepI'}); % deep layer 

% uppdate deep layer parameters to produce beta rhythm (25Hz)
deep = dsApplyModifications(deep,{'deepI->deepE','tauGABA',tauGABA_beta});

% create full cortical specification
s = dsCombineSpecifications(sup, mid, deep);

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

% Simulate
simulator_options = {'solver','rk1','dt',.01,'downsample_factor',10,'verbose_flag',1};
tspan = [0 200]; % [beg, end] (ms)

%vary = [];
vary = {'supI->supE','tauGABA',[2]; 
       'deepI->deepE','tauGABA',[20]};
data=dsSimulate(s,'vary',vary,'tspan',tspan,simulator_options{:});

% Plots results
dsPlot(data);
%dsPlot(data,'plot_type','raster');


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
