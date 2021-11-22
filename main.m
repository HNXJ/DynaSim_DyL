% Equations

eqns1={
  'dv/dt=Iapp+@current+noise*randn(1,N_pop); Iapp=0.1; noise=0.1'
  'monitor iGABAa.functions, iAMPA.functions'
};

eqns2={
  'dv/dt=Iapp+@current+noise*randn(1,N_pop); Iapp=0.1; noise=0.1'
  'monitor iGABAa.functions, iAMPA.functions'
};

eqns = eqns1;
s=[];

s.populations(1).name='L1';
s.populations(1).size=10;
s.populations(1).equations=eqns;
s.populations(1).mechanism_list={'iNa','iK'};
s.populations(1).parameters={'Iapp',3,'gNa',90,'gK',36,'noise',10};

s.populations(2).name='L2';
s.populations(2).size=10;
s.populations(2).equations=eqns;
s.populations(2).mechanism_list={'iNa','iK'};
s.populations(2).parameters={'Iapp',1,'gNa',40,'gK',36,'noise',20};

s.populations(3).name='L3';
s.populations(3).size=10;
s.populations(3).equations=eqns;
s.populations(3).mechanism_list={'iNa','iK'};
s.populations(3).parameters={'Iapp',1,'gNa',40,'gK',24,'noise',10};

s.populations(4).name='L4';
s.populations(4).size=10;
s.populations(4).equations=eqns;
s.populations(4).mechanism_list={'iNa','iK'};
s.populations(4).parameters={'Iapp',5,'gNa',120,'gK',24,'noise',10};

s.populations(5).name='L5';
s.populations(5).size=10;
s.populations(5).equations=eqns;
s.populations(5).mechanism_list={'iNa','iK'};
s.populations(5).parameters={'Iapp',10,'gNa',360,'gK',36,'noise',20};

s.connections(1).direction='L1->L2';
s.connections(1).mechanism_list={'iGABAa'};
s.connections(1).parameters={'tauD',10,'gGABAa',.1,'netcon','ones(N_pre,N_post)'};

s.connections(2).direction='L5->L2';
s.connections(2).mechanism_list={'iAMPA'};
s.connections(2).parameters={'tauD',4,'gAMPA',.1,'netcon', 'ones(N_pre,N_post)'}; 

s.connections(3).direction='L2->L3';
s.connections(3).mechanism_list={'iAMPA'};
s.connections(3).parameters={'tauD',2,'gAMPA',.1,'netcon', 'ones(N_pre,N_post)'}; 

s.connections(4).direction='L3->L2';
s.connections(4).mechanism_list={'iGABA'};
s.connections(4).parameters={'tauD',2,'gGABAa',.1,'netcon', 'ones(N_pre,N_post)'}; 

s.connections(5).direction='L4->L1';
s.connections(5).mechanism_list={'iGABA'};
s.connections(5).parameters={'tauD',2,'gGABAa',.1,'netcon', 'ones(N_pre,N_post)'}; 

data=dsSimulate(s);
dsPlot(data); 

% <-- Figure 4 in DynaSim paper