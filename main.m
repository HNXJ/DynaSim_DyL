% Equations

clc;

eqns1={
%   'u(t) = (t < 50)'
  'dv/dt=0.5*Iapp+0.5*@current+noise*rand(1,N_pop);'
  'monitor iGABAa.functions, iAMPA.functions'
};

eqns2={
%   'u(t) = (t < 50)'
  'dv/dt=Iapp+3*@current+noise*rand(1,N_pop);'
  'monitor iGABAa.functions, iAMPA.functions'
};

eqns3={
  'u(t) = (t > 50)'
  'dv/dt = 30*sin(3*t) * u(t);'
  'monitor iGABAa.functions, iAMPA.functions'
};

eqns4={
  'u(t) = (t < 50)'
  'dv/dt = 30*sin(3*t) * u(t);'
  'monitor iGABAa.functions, iAMPA.functions'
};

eqns = eqns1;

s=[];

s.populations(1).name='L1';
s.populations(1).size=7;
s.populations(1).equations=eqns1;
s.populations(1).mechanism_list={'iNa','iK'};
s.populations(1).parameters={'Iapp',1,'gNa',40,'gK',36,'noise',5};

s.populations(2).name='L2';
s.populations(2).size=8;
s.populations(2).equations=eqns1;
s.populations(2).mechanism_list={'iNa','iK'};
s.populations(2).parameters={'Iapp',1,'gNa',50,'gK',12,'noise',10};

s.populations(3).name='L3';
s.populations(3).size=5;
s.populations(3).equations=eqns1;
s.populations(3).mechanism_list={'iNa','iK'};
s.populations(3).parameters={'Iapp',0.5,'gNa',70,'gK',24,'noise',10};

s.populations(4).name='L4';
s.populations(4).size=12;
s.populations(4).equations=eqns2;
s.populations(4).mechanism_list={'iNa','iK'};
s.populations(4).parameters={'Iapp',5,'gNa',250,'gK',36,'noise',20};

s.populations(5).name='L5';
s.populations(5).size=6;
s.populations(5).equations=eqns2;
s.populations(5).mechanism_list={'iNa','iK'};
s.populations(5).parameters={'Iapp',5,'gNa',250,'gK',36,'noise',20};

s.populations(6).name='L6';
s.populations(6).size=4;
s.populations(6).equations=eqns2;
s.populations(6).mechanism_list={'iNa','iK'};
s.populations(6).parameters={'Iapp',5,'gNa',360,'gK',36,'noise',20};

s.populations(7).name='Input1';
s.populations(7).size=1;
s.populations(7).equations=eqns3;
s.populations(7).mechanism_list={'iNa','iK'};
s.populations(7).parameters={'Iapp',1,'gNa',360,'gK',36,'noise',0};

s.populations(8).name='Input2';
s.populations(8).size=1;
s.populations(8).equations=eqns4;
s.populations(8).mechanism_list={'iNa','iK'};
s.populations(8).parameters={'Iapp',1,'gNa',360,'gK',36,'noise',0};

s.connections(1).direction='L1->L2';
s.connections(1).mechanism_list={'iGABAa'};
s.connections(1).parameters={'tauD',16,'gGABAa',.1,'netcon','rand(N_pre,N_post)'};

s.connections(2).direction='L5->L2';
s.connections(2).mechanism_list={'iAMPA'};
s.connections(2).parameters={'tauD',16,'gAMPA',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(3).direction='L2->L3';
s.connections(3).mechanism_list={'iAMPA'};
s.connections(3).parameters={'tauD',18,'gAMPA',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(4).direction='L3->L2';
s.connections(4).mechanism_list={'iAMPA'};
s.connections(4).parameters={'tauD',17,'gAMPA',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(5).direction='L4->L1';
s.connections(5).mechanism_list={'iGABA'};
s.connections(5).parameters={'tauD',12,'gGABAa',.1,'netcon', 'ones(N_pre,N_post)'}; 

s.connections(6).direction='L3->L1';
s.connections(6).mechanism_list={'iAMPA'};
s.connections(6).parameters={'tauD',19,'gAMPA',.1,'netcon', 'ones(N_pre,N_post)'}; 

s.connections(7).direction='Input1->L5';
s.connections(7).mechanism_list={'iAMPA'};
s.connections(7).parameters={'tauD',5,'gAMPA',.1,'netcon', 'ones(N_pre,N_post)'}; 

s.connections(8).direction='Input2->L6';
s.connections(8).mechanism_list={'iAMPA'};
s.connections(8).parameters={'tauD',5,'gAMPA',.5,'netcon', 'ones(N_pre,N_post)'}; 

s.connections(9).direction='L6->L5';
s.connections(9).mechanism_list={'iAMPA'};
s.connections(9).parameters={'tauD',3,'gAMPA',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(10).direction='L5->L4';
s.connections(10).mechanism_list={'iAMPA'};
s.connections(10).parameters={'tauD',3,'gAMPA',.5,'netcon', 'rand(N_pre,N_post)'}; 

% data=dsSimulate(s);

data = dsSimulate(s, 'solver', 'rk1', 'dt', .01, 'downsample_factor', 10, 'verbose_flag',1);

dsPlot(data); 
