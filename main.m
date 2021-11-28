% Equations

clc;
eqns1={
%   'u(t) = (t < 50)'
  'dv/dt=Iapp*0.01+0.93*@current+noise*randn(1,N_pop);'
  'monitor iGABAa.functions, iAMPA.functions'
};

eqns2={
  'u(t) = (t < 50)'
  'dv/dt=Iapp*u(t)+0.19*@current+noise*randn(1,N_pop);'
  'monitor iGABAa.functions, iAMPA.functions'
};

eqns = eqns1;

s=[];

s.populations(1).name='L1';
s.populations(1).size=7;
s.populations(1).equations=eqns1;
s.populations(1).mechanism_list={'iNa','iK'};
s.populations(1).parameters={'Iapp',3,'gNa',120,'gK',36,'noise',50};

s.populations(2).name='L2';
s.populations(2).size=8;
s.populations(2).equations=eqns1;
s.populations(2).mechanism_list={'iNa','iK'};
s.populations(2).parameters={'Iapp',4,'gNa',90,'gK',12,'noise',10};

s.populations(3).name='L3';
s.populations(3).size=5;
s.populations(3).equations=eqns1;
s.populations(3).mechanism_list={'iNa','iK'};
s.populations(3).parameters={'Iapp',3,'gNa',70,'gK',24,'noise',10};

s.populations(4).name='L4';
s.populations(4).size=12;
s.populations(4).equations=eqns2;
s.populations(4).mechanism_list={'iNa','iK'};
s.populations(4).parameters={'Iapp',9,'gNa',360,'gK',48,'noise',30};

s.populations(5).name='L5';
s.populations(5).size=6;
s.populations(5).equations=eqns2;
s.populations(5).mechanism_list={'iNa','iK'};
s.populations(5).parameters={'Iapp',20,'gNa',360,'gK',36,'noise',60};

s.connections(1).direction='L1->L2';
s.connections(1).mechanism_list={'iGABAa'};
s.connections(1).parameters={'tauD',10,'gGABAa',.1,'netcon','ones(N_pre,N_post)'};

s.connections(2).direction='L5->L2';
s.connections(2).mechanism_list={'iAMPA'};
s.connections(2).parameters={'tauD',5,'gAMPA',.05,'netcon', 'ones(N_pre,N_post)'}; 

s.connections(3).direction='L2->L3';
s.connections(3).mechanism_list={'iAMPA'};
s.connections(3).parameters={'tauD',2,'gAMPA',.1,'netcon', 'ones(N_pre,N_post)'}; 

s.connections(4).direction='L3->L2';
s.connections(4).mechanism_list={'iAMPA'};
s.connections(4).parameters={'tauD',5,'gAMPA',.05,'netcon', 'ones(N_pre,N_post)'}; 

s.connections(5).direction='L4->L1';
s.connections(5).mechanism_list={'iGABA'};
s.connections(5).parameters={'tauD',2,'gGABAa',.1,'netcon', 'ones(N_pre,N_post)'}; 

s.connections(6).direction='L3->L1';
s.connections(6).mechanism_list={'iAMPA'};
s.connections(6).parameters={'tauD',3,'gAMPA',.3,'netcon', 'ones(N_pre,N_post)'}; 

data=dsSimulate(s);
dsPlot(data); 
