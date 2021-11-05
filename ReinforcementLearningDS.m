%%

clear;clc;

eqns={
  'dv/dt=Iapp+@current+noise*randn(1,N_pop); Iapp=0.1; noise=1'
  'monitor iGABAa.functions, iAMPA.functions'
};

s=[];

s.populations(1).name = 'P1';
s.populations(1).size = 5;
s.populations(1).equations = eqns;
s.populations(1).mechanism_list = {'iNa', 'iK'};
s.populations(1).parameters = {'Iapp', 9, 'gNa', 120, 'gK', 40, 'noise', 5};

s.populations(1).name = 'P2';
s.populations(1).size = 5;
s.populations(1).equations = eqns;
s.populations(1).mechanism_list = {'iNa', 'iK'};
s.populations(1).parameters = {'Iapp', 9, 'gNa', 120, 'gK', 40, 'noise', 5};

s.populations(1).name = 'P3';
s.populations(1).size = 5;
s.populations(1).equations = eqns;
s.populations(1).mechanism_list = {'iNa', 'iK'};
s.populations(1).parameters = {'Iapp', 9, 'gNa', 120, 'gK', 40, 'noise', 5};

s.connections(1).direction = [s.populations(1).name, '->', s.populations(2).name];
s.connections(1).mechanism_list={'iGABAa'};
s.connections(1).parameters={'tauD', 3, 'gGABAa', .1, 'netcon', ones(5, 5)}; 

%%

data=dsSimulate(s);
dsPlot(data);

%% Model template of definition

eqns={
  'dv/dt=Iapp+@current+noise*randn(1,N_pop); Iapp=0.1; noise=1'
  'monitor iGABAa.functions, iAMPA.functions'
};

s=[];

s.populations(1).name = 'P1';
s.populations(1).size = 5;
s.populations(1).equations = eqns;
s.populations(1).mechanism_list = {'iNa', 'iK'};
s.populations(1).parameters = {'Iapp', 9, 'gNa', 120, 'gK', 40, 'noise', 5};

disp("Populations created...");

s.connections(1).direction = [s.populations(1).name, '->', s.populations(1).name];
s.connections(1).mechanism_list={'iGABAa'};
s.connections(1).parameters={'tauD', 3, 'gGABAa', .1, 'netcon', ones(5, 5)}; 

disp("Connections created...");

%%