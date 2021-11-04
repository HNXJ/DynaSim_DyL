%% Add to path

clc;clear;
addpath C:\Users\hamed\Research\PredictiveCoding\DynaSim-dev
savepath

%%
% define equations of cell model (same for E and I populations)

clc;

eqns={
  'dv/dt=Iapp+@current+noise*randn(1,N_pop); Iapp=0; noise=0'
  'monitor iGABAa.functions, iAMPA.functions'
};

% Tip: monitor all functions of a mechanism using: monitor MECHANISM.functions

% create DynaSim specification structure
s=[];
s.populations(1).name='E';
s.populations(1).size=10;
s.populations(1).equations=eqns;
s.populations(1).mechanism_list={'iNa','iK'};
s.populations(1).parameters={'Iapp',9,'gNa',120,'gK',36,'noise',10};

s.populations(2).name='I';
s.populations(2).size=10;
s.populations(2).equations=eqns;
s.populations(2).mechanism_list={'iNa','iK'};
s.populations(2).parameters={'Iapp',15,'gNa',120,'gK',36,'noise',20};

s.populations(3).name='Q';
s.populations(3).size=10;
s.populations(3).equations=eqns;
s.populations(3).mechanism_list={'iNa','iK'};
s.populations(3).parameters={'Iapp',19,'gNa',120,'gK',36,'noise',50};

disp("Populations created ...");

s.connections(1).direction='I->E';
s.connections(1).mechanism_list={'iGABAa'};
s.connections(1).parameters={'tauD',3,'gGABAa',.1,'netcon',ones(10,10)}; % connectivity matrix defined using a string that evalutes to a numeric matrix

s.connections(2).direction='E->I';
s.connections(2).mechanism_list={'iAMPA'};
s.connections(2).parameters={'tauD',3,'gAMPA',.1,'netcon',ones(10,10)}; % connectivity set using a numeric matrix defined in script

s.connections(3).direction='Q->I';
s.connections(3).mechanism_list={'iAMPA'};
s.connections(3).parameters={'tauD',3,'gAMPA',.1,'netcon',ones(10,10)}; % connectivity set using a numeric matrix defined in script

s.connections(4).direction='E->Q';
s.connections(4).mechanism_list={'iAMPA'};
s.connections(4).parameters={'tauD',3,'gAMPA',.1,'netcon',ones(10,10)}; % connectivity set using a numeric matrix defined in script

s.connections(5).direction='Q->E';
s.connections(5).mechanism_list={'iAMPA'};
s.connections(5).parameters={'tauD',3,'gAMPA',.1,'netcon',ones(10,10)}; % connectivity set using a numeric matrix defined in script

s.connections(6).direction='I->Q';
s.connections(6).mechanism_list={'iAMPA'};
s.connections(6).parameters={'tauD',3,'gAMPA',.1,'netcon',ones(10,10)}; % connectivity set using a numeric matrix defined in script

disp("Connections created.");

% Simulate Sparse Pyramidal-Interneuron-Network-Gamma (sPING)
data=dsSimulate(s);

dsPlot(data); % <-- Figure 4 in DynaSim paper



