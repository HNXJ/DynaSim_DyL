%% 3-layer neocortical model

clear;clc;
fprintf("Initialization...\n");

% Population sizes
Ne = 16;     % # of E cells per layer
Ni = Ne/4;  % # of I cells per layer
k = 0.7; % Randomness of initial weights

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
tauGABA_gamma = 3; % ms, decay time constant of inhibition for gamma (50Hz)
tauGABA_beta = 20; % ms, decay time constant of inhibition for beta (25Hz)
tauAMPA = 3; % ms, decay time constant of fast excitation (AMPA)

% Maximal synaptic strengths
gAMPA_ei = .2; % E->I within layer
gAMPA_ffee = .2; % feedforward E->E, mid->sup, sup->deep
gGABAa_ffie = .1; % feedforward I->E, mid->deep

gAMPA_ee = 0; % E->E within layer
gGABAa_ie = 5; % I->E within layer
gGABAa_ii = 0; % I->I within layer

% neuronal dynamics
eqns = 'dV/dt = (Iapp + @current + noise*randn(1,Npop))/C; Iapp=0; noise=0; C=1';

% SPN
g_l_D1 = 0.096;      % mS/cm^2, Leak conductance for D1 SPNs 
g_l_D2 = 0.1;        % mS/cm^2, Leak conductance for D2 SPNs
g_cat_D1 = 0.018;    % mS/cm^2, Conductance of the T-type Ca2+ current for D1 SPNs
g_cat_D2 = 0.025;    % mS/cm^2, Conductance of the T-type Ca2+ current for D2 SPNs

g_poisson = 1e-4;

% cell type
spn_cells = {'spn_iNa','spn_iK','spn_iLeak','spn_iM','spn_iCa','spn_CaBuffer','spn_iKca', 'ctx_iPoisson'};
ctx_cells = {'iNa','iK', 'ctx_iPoisson'};

cell_type = ctx_cells; % choose spn_cells and ctx_cells

% create DynaSim specification structure

% PING template
ping=[];

% E-cells
ping.populations(1).name = 'E';
ping.populations(1).size = Ne;
ping.populations(1).equations = eqns;
ping.populations(1).mechanism_list = cell_type;
ping.populations(1).parameters = {'Iapp',5,'noise', 60, 'g_poisson',g_poisson,'onset_poisson',0,'offset_poisson',0};

% I-cells
ping.populations(2).name = 'I';
ping.populations(2).size = Ni;
ping.populations(2).equations = eqns;
ping.populations(2).mechanism_list = cell_type;
ping.populations(2).parameters = {'Iapp',0,'noise', 16, 'g_poisson',g_poisson,'onset_poisson',0,'offset_poisson',0};

% E/I connectivity
ping.connections(1).direction = 'E->I';
ping.connections(1).mechanism_list = {'iAMPActx'};
ping.connections(1).parameters = {'gAMPA',gAMPA_ei,'tauAMPA',tauAMPA,'netcon',Kei};

ping.connections(2).direction = 'E->E';
ping.connections(2).mechanism_list = {'iAMPActx'};
ping.connections(2).parameters = {'gAMPA',gAMPA_ee,'tauAMPA',tauAMPA,'netcon',Kee};

ping.connections(3).direction = 'I->E';
ping.connections(3).mechanism_list = {'iGABActx'};
ping.connections(3).parameters = {'gGABAa',gGABAa_ie,'tauGABA',tauGABA_gamma,'netcon',Kie};

ping.connections(4).direction = 'I->I';
ping.connections(4).mechanism_list = {'iGABActx'};
ping.connections(4).parameters = {'gGABAa',gGABAa_ii,'tauGABA',tauGABA_gamma,'netcon',Kii};

% create independent layers
sup = dsApplyModifications(ping,{'E','name','supE'; 'I','name','supI'}); % superficial layer 
mid = dsApplyModifications(ping,{'E','name','midE'; 'I','name','midI'}); % middle layer 
deep = dsApplyModifications(ping,{'E','name','deepE'; 'I','name','deepI'}); % deep layer 
io = dsApplyModifications(ping,{'E','name','A'; 'I','name','B'}); % I/O layer 

% uppdate deep layer parameters to produce beta rhythm (25Hz)
deep = dsApplyModifications(deep,{'deepI->deepE','tauGABA',tauGABA_beta});
% io = dsApplyModifications(io,{'A','size',1});
% io = dsApplyModifications(io,{'B','size',1});

io = dsApplyModifications(io,{'A','Iapp',1});
io = dsApplyModifications(io,{'B','Iapp',1});
io = dsApplyModifications(io,{'A','noise',10});
io = dsApplyModifications(io,{'B','noise',10});

io = dsApplyModifications(io,{'A->B','netcon','zeros(N_pre, N_post)'});
io = dsApplyModifications(io,{'B->A','netcon','zeros(N_pre, N_post)'});
io = dsApplyModifications(io,{'A->B','netcon','zeros(N_pre, N_post)'});
io = dsApplyModifications(io,{'B->A','netcon','zeros(N_pre, N_post)'});

% create full cortical specification
s = dsCombineSpecifications(sup, mid, deep, io);

% connect the layers
% InA -> midE
Aconn = [ones(16, 8), zeros(16, 8)];

c = length(s.connections)+1;
s.connections(c).direction = 'A->midE';
s.connections(c).mechanism_list={'iAMPActx'};
s.connections(c).parameters={'gAMPA',gAMPA_ffee*3,'tauAMPA',tauAMPA,'netcon',Aconn};

% InB -> midE
Bconn = [zeros(4, 8), ones(4, 8)];

c = length(s.connections)+1;
s.connections(c).direction = 'B->midE';
s.connections(c).mechanism_list={'iAMPActx'};
s.connections(c).parameters={'gAMPA',gAMPA_ffee*3,'tauAMPA',tauAMPA,'netcon',Bconn};

% midE -> supE
c = length(s.connections)+1;
s.connections(c).direction = 'midE->supE';
s.connections(c).mechanism_list={'iAMPActx'};
s.connections(c).parameters={'gAMPA',gAMPA_ffee,'tauAMPA',tauAMPA,'netcon',Kffee};

% midI -> deepE
c = length(s.connections)+1;
s.connections(c).direction = 'midI->deepE';
s.connections(c).mechanism_list={'iGABActx'};
s.connections(c).parameters={'gGABAa',gGABAa_ffie,'tauGABA',tauGABA_beta,'netcon',Kffie};

% supE -> deepE
c = length(s.connections)+1;
s.connections(c).direction = 'supE->deepE';
s.connections(c).mechanism_list={'iAMPActx'};
s.connections(c).parameters={'gAMPA',gAMPA_ffee,'tauAMPA',tauAMPA,'netcon',Kffee};

% Simulate
simulator_options = {'solver','rk1','dt',.01,'downsample_factor',10,'verbose_flag',1};
tspan = [0 500]; % [beg, end] (ms)

% vary = [];
% vary = {'supI->supE','tauGABA',[2]; 
%        'deepI->deepE','tauGABA',[2 20]};
vary = {'A','g_poisson',[g_poisson]; 'A','DC_poisson', [1e7];'A','AC_poisson', [0]; 'A', 'onset_poisson', [200 300]; 'A', 'offset_poisson', [300];
       'B','g_poisson',[g_poisson]; 'B','DC_poisson', [1e7];'B','AC_poisson', [0]; 'B', 'onset_poisson', [300 400]; 'B', 'offset_poisson', [400]};
   
data=dsSimulate(s,'vary',vary,'tspan',tspan,simulator_options{:});

%% Plots results

dsPlot(data);
%dsPlot(data,'plot_type','raster');

%% iFR & comparison

clc;
pool1 = [1:8];
pool2 = [9:16];
t = data.time;
x = data(4).midE_V;

raster = computeRaster(t, x);
ifr1 = 1e3 * NWepanechnikovKernelRegrRaster(t, raster, pool1, 49, 1, 1);
ifr2 = 1e3 * NWepanechnikovKernelRegrRaster(t, raster, pool2, 49, 1, 1);

figure();

subplot(2, 2, 1);plot(t, ifr1);title('S4: iFR for midE cells 1-8');
subplot(2, 2, 2);plot(t, x(:, pool1));title('V(t)');
subplot(2, 2, 3);plot(t, ifr2);title('iFR for midE cells 9-16');
subplot(2, 2, 4);plot(t, x(:, pool2));title('V(t)');


