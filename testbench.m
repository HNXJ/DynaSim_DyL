%%

clc;clear;
fprintf("Initialization...");

% Population sizes
Ne = 8;     % # of E cells per layer
Ni = Ne/4;  % # of I cells per layer
k = 0.5; % Randomness of initial weights

% Connectivity matrices

% E->I
Kei = k*rand(Ne, Ni) + (1-k); % all-to-all, connectivity from E cells to I cells; mid, sup, deep
% I->E
Kie = k*rand(Ni, Ne) + (1-k); % all-to-all, connectivity from I cells to E cells; mid, sup, deep

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

% Mechanism parameters

g_l_D1 = 0.096;      % mS/cm^2, Leak conductance for D1 SPNs 
g_l_D2 = 0.1;        % mS/cm^2, Leak conductance for D2 SPNs
g_cat_D1 = 0.018;    % mS/cm^2, Conductance of the T-type Ca2+ current for D1 SPNs
g_cat_D2 = 0.025;    % mS/cm^2, Conductance of the T-type Ca2+ current for D2 SPNs
tOn_pfcInp =  100;            % onset in ms, transient
tOff_pfcInp = 0+200; % 0 Was onset time in the PNAS, dyration was 1.5s

% E-cells
ping.populations(1).name = 'E';
ping.populations(1).size = Ne;
ping.populations(1).equations = eqns;
ping.populations(1).mechanism_list = {'spn_iNa','spn_iK','spn_iLeak','spn_iM','spn_iCa','spn_CaBuffer','spn_iKca','spn_iPoisson','spn_ipfcPoisson'};
ping.populations(1).parameters = {'Iapp',4,'noise',40,'cm',1,'g_l',g_l_D2,'g_cat',g_cat_D2,'onset_pfc_poisson',tOn_pfcInp,'offset_pfc_poisson',tOff_pfcInp};

% I-cells
ping.populations(2).name = 'I';
ping.populations(2).size = Ni;
ping.populations(2).equations = eqns;
ping.populations(1).mechanism_list = {'spn_iNa','spn_iK','spn_iLeak','spn_iM','spn_iCa','spn_CaBuffer','spn_iKca','spn_iPoisson','spn_ipfcPoisson'};
ping.populations(2).parameters = {'Iapp',0,'noise',10,'cm',1,'g_l',g_l_D2,'g_cat',g_cat_D2,'onset_pfc_poisson',tOn_pfcInp,'offset_pfc_poisson',tOff_pfcInp};

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

s = ping;

% Simulate
simulator_options = {'solver','rk1','dt',.01,'downsample_factor',10,'verbose_flag',1};
tspan = [0 300]; % [beg, end] (ms)

vary = [];
% vary = {'E', 'onset_pfc_poisson', [100 300]};
%     'I', 'onset_pfc_poisson', [100 300]};
% vary = {'I->E', 'tauGABA', [2 4]};
data=dsSimulate(s,'vary',vary,'tspan',tspan,simulator_options{:});

% Plots results
dsPlot(data);


%%