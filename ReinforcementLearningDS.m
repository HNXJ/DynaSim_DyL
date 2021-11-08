%%

% TODO: I/O on DynaSim for interactive and online scenarios

% Noise correlation for inputs test
% Change model parameters for net design
% Two population one-hot [0, 1] and its 4 states may be good form of output for the neural model''s net
% Should find a way for representing plasticity (learning/memory variables)
% Relation between frequency and gNa/gK?

% Look for Brian2 package of Python, Izhikevich_2007 as RL model
% Design RL scenario for PredCoding

% Extract model properties from data, e.g. tSNE and similarities between frames
% NeuroPy Idea: tSNE on single trial, 100ms tPSDs as 45 data. Perplx ~= 5
% Augmentation via adding another similar trial, e.g. trials 61 and 62 which both are unexpected/unpredictable trials
% Chech on NeuroPy

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

s.populations(2).name = 'P2';
s.populations(2).size = 5;
s.populations(2).equations = eqns;
s.populations(2).mechanism_list = {'iNa', 'iK'};
s.populations(2).parameters = {'Iapp',1, 'gNa', 110, 'gK', 40, 'noise', 5};

s.populations(3).name = 'P3';
s.populations(3).size = 5;
s.populations(3).equations = eqns;
s.populations(3).mechanism_list = {'iNa', 'iK'};
s.populations(3).parameters = {'Iapp', 9, 'gNa', 120, 'gK', 40, 'noise', 5};

s.connections(1).direction = [s.populations(1).name, '->', s.populations(2).name];
s.connections(1).mechanism_list={'iGABAa'};
s.connections(1).parameters={'tauD', 3, 'gGABAa', .1, 'netcon', ones(5, 5)}; 

s.connections(2).direction = [s.populations(3).name, '->', s.populations(2).name];
s.connections(2).mechanism_list={'iGABAa'};
s.connections(2).parameters={'tauD', 3, 'gGABAa', .1, 'netcon', ones(5, 5)}; 

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