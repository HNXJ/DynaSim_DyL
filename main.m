% define equations of cell model (same for E and I populations)
eqns={
  'dv/dt=Iapp+@current+noise*randn(1,N_pop); Iapp=0.1; noise=0'
  'monitor iGABAa.functions, iAMPA.functions'
};
% Tip: monitor all functions of a mechanism using: monitor MECHANISM.functions

% create DynaSim specification structure
s=[];
s.populations(1).name='E';
s.populations(1).size=10;
s.populations(1).equations=eqns;
s.populations(1).mechanism_list={'iNa','iK'};
s.populations(1).parameters={'Iapp',5,'gNa',120,'gK',36,'noise',40};
s.populations(2).name='I';
s.populations(2).size=10;
s.populations(2).equations=eqns;
s.populations(2).mechanism_list={'iNa','iK'};
s.populations(2).parameters={'Iapp',0,'gNa',120,'gK',36,'noise',10};
s.connections(1).direction='I->E';
s.connections(1).mechanism_list={'iGABAa'};
s.connections(1).parameters={'tauD',10,'gGABAa',.1,'netcon','ones(N_pre,N_post)'}; % connectivity matrix defined using a string that evalutes to a numeric matrix
s.connections(2).direction='E->I';
s.connections(2).mechanism_list={'iAMPA'};
s.connections(2).parameters={'tauD',2,'gAMPA',.1,'netcon',ones(10,10)}; % connectivity set using a numeric matrix defined in script
% Simulate Sparse Pyramidal-Interneuron-Network-Gamma (sPING)
data=dsSimulate(s);

dsPlot(data); % <-- Figure 4 in DynaSim paper