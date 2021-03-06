%%

%%
% Equations

clc;clear;

eqns1={
%   'u(t) = (t < 50)'
  'dv/dt=Iapp+@current+noise*rand(1,N_pop);'
  'monitor iGABAa.functions, iAMPA.functions'
  'monitor v.spikes(0)'
};

eqns2={
%   'u(t) = (t < 50)'
  'dv/dt=Iapp+@current+noise*rand(1,N_pop);'
  'monitor iGABAa.functions, iAMPA.functions'
  'monitor v.spikes(0)'
};

eqns3={
  'u(t) = (t > 50)'
  'dv/dt = 100*(sin(2*t)) * u(t);'
  'monitor iGABAa.functions, iAMPA.functions'
  'monitor v.spikes(0)'
};

eqns4={
  'u(t) = (t < 50)'
  'dv/dt = 100*(sin(2*t)) * u(t);'
  'monitor iGABAa.functions, iAMPA.functions'
  'monitor v.spikes(0)'
};

s=[];

s.populations(1).name='L1';
s.populations(1).size=9;
s.populations(1).equations=eqns1;
s.populations(1).mechanism_list={'iNa','iK'};
s.populations(1).parameters={'Iapp',1,'gNa',120,'gK',36,'noise',10};

s.populations(2).name='L2';
s.populations(2).size=9;
s.populations(2).equations=eqns1;
s.populations(2).mechanism_list={'iNa','iK'};
s.populations(2).parameters={'Iapp',1,'gNa',120,'gK',36,'noise',10};

s.populations(3).name='L3';
s.populations(3).size=6;
s.populations(3).equations=eqns1;
s.populations(3).mechanism_list={'iNa','iK'};
s.populations(3).parameters={'Iapp',1,'gNa',120,'gK',36,'noise',10};

s.populations(4).name='L4';
s.populations(4).size=12;
s.populations(4).equations=eqns2;
s.populations(4).mechanism_list={'iNa','iK'};
s.populations(4).parameters={'Iapp',1,'gNa',120,'gK',48,'noise',10};

s.populations(5).name='L5';
s.populations(5).size=6;
s.populations(5).equations=eqns2;
s.populations(5).mechanism_list={'iNa','iK'};
s.populations(5).parameters={'Iapp',1,'gNa',120,'gK',48,'noise',10};

s.populations(6).name='L6';
s.populations(6).size=6;
s.populations(6).equations=eqns2;
s.populations(6).mechanism_list={'iNa','iK'};
s.populations(6).parameters={'Iapp',1,'gNa',120,'gK',48,'noise',10};

s.populations(7).name='Input1';
s.populations(7).size=1;
s.populations(7).equations=eqns3;
s.populations(7).mechanism_list={'iNa','iK'};
s.populations(7).parameters={'Iapp',1,'gNa',120,'gK',36,'noise',1};

s.populations(8).name='Input2';
s.populations(8).size=1;
s.populations(8).equations=eqns4;
s.populations(8).mechanism_list={'iNa','iK'};
s.populations(8).parameters={'Iapp',1,'gNa',120,'gK',36,'noise',1};

s.connections(1).direction='L1->L2';
s.connections(1).mechanism_list={'iGABAa'};
s.connections(1).parameters={'tauD',5,'gGABAa',.1,'netcon','rand(N_pre,N_post)'};

s.connections(2).direction='L2->L1';
s.connections(2).mechanism_list={'iAMPA'};
s.connections(2).parameters={'tauD',5,'gAMPA',.1,'netcon','rand(N_pre,N_post)'};

s.connections(3).direction='L5->L2';
s.connections(3).mechanism_list={'iAMPA'};
s.connections(3).parameters={'tauD',5,'gAMPA',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(4).direction='L2->L5';
s.connections(4).mechanism_list={'iGABA'};
s.connections(4).parameters={'tauD',5,'gGABAa',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(5).direction='L2->L3';
s.connections(5).mechanism_list={'iAMPA'};
s.connections(5).parameters={'tauD',5,'gAMPA',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(6).direction='L3->L2';
s.connections(6).mechanism_list={'iGABA'};
s.connections(6).parameters={'tauD',5,'gGABAa',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(7).direction='L4->L1';
s.connections(7).mechanism_list={'iGABA'};
s.connections(7).parameters={'tauD',5,'gGABAa',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(8).direction='L1->L4';
s.connections(8).mechanism_list={'iAMPA'};
s.connections(8).parameters={'tauD',5,'gAMPA',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(9).direction='L3->L1';
s.connections(9).mechanism_list={'iAMPA'};
s.connections(9).parameters={'tauD',5,'gAMPA',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(10).direction='L1->L3';
s.connections(10).mechanism_list={'iGABA'};
s.connections(10).parameters={'tauD',5,'gGABAa',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(11).direction='Input1->L5';
s.connections(11).mechanism_list={'iAMPA'};
s.connections(11).parameters={'tauD',2,'gAMPA',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(12).direction='Input2->L6';
s.connections(12).mechanism_list={'iAMPA'};
s.connections(12).parameters={'tauD',5,'gAMPA',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(13).direction='L6->L5';
s.connections(13).mechanism_list={'iAMPA'};
s.connections(13).parameters={'tauD',5,'gAMPA',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(14).direction='L5->L4';
s.connections(14).mechanism_list={'iGABA'};
s.connections(14).parameters={'tauD',5,'gGABAa',.1,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(15).direction='L4->L6';
s.connections(15).mechanism_list={'iAMPA'};
s.connections(15).parameters={'tauD',5,'gAMPA',.1,'netcon', 'rand(N_pre,N_post)'};

s.connections(16).direction='L4->L5';
s.connections(16).mechanism_list={'iAMPA'};
s.connections(16).parameters={'tauD',5,'gAMPA',.1,'netcon', 'rand(N_pre,N_post)'}; 

m = DynaModel(s);
disp('done');

% data=dsSimulate(s);
% data = dsSimulate(s, 'solver', 'rk1', 'dt', .01, 'downsample_factor', 10, 'verbose_flag',1);
% dsPlot(m.data); 

%% Trials' training script script

clc;

lambda = 0.5;
input_cues = {{eqns3, eqns4}, {eqns4, eqns3}, {eqns3, eqns3}};
target_responses = [40, 20, 80];
batch_size = size(target_responses, 2);

input_layers = [7, 8];
output_indice = {49}; 
T = 100;
dT = 0.01;

update_mode = 'uniform';
error_mode = 'MAE';
momentum = 0.8;
iterations = 10;

for i = 1:iterations
    
    for j = 1:batch_size
        
        c_input = input_cues(j);
        c_input = c_input{1};
        c_target = target_responses(j);
        m.run_trial(c_input, input_layers, output_indice, T, dT, c_target, lambda, update_mode, error_mode, momentum);
    
    end
    
    fprintf("Trial no. %d of current batch %d, MAE = %f \n", get(m, 'last_trial'), i, mean(m.errors_log(end-2:end)));
    
end

disp('done');

%%

dsPlot(m.data);

%%

m.error_plot('Error of target-output (MAE)');

%%

j = 1;
c_input = input_cues(j);
c_input = c_input{1};
c_target = target_responses(j);
m.run_trial(c_input, input_layers, output_indice, T, dT, c_target, lambda, update_mode, error_mode, momentum);
        
%%

clc;
% f = fieldnames(m.data);

%%