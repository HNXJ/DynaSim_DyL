%% DynaModel example draft 

%% Save/load model

clc;
m.save_model('Files/f3_init.mat');
% m = DynaModel('Files/f1_init.mat');

%% Initialize model
% Equations

clc;clear;

eqns_superficial={
  'dv/dt = 0.2*Iapp + @current*0.4 + 0.2*noise*rand(1,N_pop);'
  'monitor iGABAa.functions, iAMPA.functions'
  'monitor v.spikes(0)'
};

eqns_deep={
  'dv/dt = 0.5*Iapp + @current*0.9 + 0.5*noise*rand(1,N_pop);'
  'monitor iGABAa.functions, iAMPA.functions'
  'monitor v.spikes(0)'
};

eqns_input1={
  'u(t, T) = exp(-10*(t-T)^2);'
  'dv/dt = 20*u(t, 200);'
  'monitor iGABAa.functions, iAMPA.functions'
  'monitor v.spikes(0)'
};

eqns_input2={
  'u(t, T) = exp(-10*(t-T)^2);'
  'dv/dt = - 20*u(t, 200);'
  'v(0) = 11.21;'
  'monitor iGABAa.functions, iAMPA.functions'
  'monitor v.spikes(0)'
};

s=[];

s.populations(1).name='L1I';
s.populations(1).size=16;
s.populations(1).equations=eqns_superficial;
s.populations(1).mechanism_list={'iNa','iK'};
s.populations(1).parameters={'Iapp', 2, 'gNa', 120, 'gK', 36, 'noise', 12};

s.populations(2).name='L2I';
s.populations(2).size=8;
s.populations(2).equations=eqns_deep;
s.populations(2).mechanism_list={'iNa','iK'};
s.populations(2).parameters={'Iapp', 10,'gNa',120,'gK',36,'noise', 12};

s.populations(3).name='L3I';
s.populations(3).size=12;
s.populations(3).equations=eqns_deep;
s.populations(3).mechanism_list={'iNa','iK'};
s.populations(3).parameters={'Iapp', 12,'gNa',120,'gK',36,'noise', 12};

s.populations(4).name='L1E';
s.populations(4).size=16;
s.populations(4).equations=eqns_superficial;
s.populations(4).mechanism_list={'iNa','iK'};
s.populations(4).parameters={'Iapp', 2, 'gNa', 120, 'gK', 36, 'noise', 10};

s.populations(5).name='L2E';
s.populations(5).size=8;
s.populations(5).equations=eqns_deep;
s.populations(5).mechanism_list={'iNa','iK'};
s.populations(5).parameters={'Iapp', 10,'gNa',120,'gK',36,'noise', 10};

s.populations(6).name='L3E';
s.populations(6).size=12;
s.populations(6).equations=eqns_deep;
s.populations(6).mechanism_list={'iNa','iK'};
s.populations(6).parameters={'Iapp', 12,'gNa',120,'gK',36,'noise', 10};

s.populations(7).name='Input1';
s.populations(7).size=1;
s.populations(7).equations=eqns_input1;
s.populations(7).mechanism_list={'iNa','iK'};
s.populations(7).parameters={'Iapp', 0,'gNa',120,'gK',36,'noise', 0};

s.populations(8).name='Input2';
s.populations(8).size=1;
s.populations(8).equations=eqns_input2;
s.populations(8).mechanism_list={'iNa','iK'};
s.populations(8).parameters={'Iapp', 0,'gNa',120,'gK',36,'noise', 0};

s.connections(1).direction='L1E->L1I';
s.connections(1).mechanism_list={'iAMPA'};
s.connections(1).parameters={'tauD',5,'gAMPA',.5, 'netcon','rand(N_pre,N_post)'};

s.connections(2).direction='L1I->L1E';
s.connections(2).mechanism_list={'iGABA'};
s.connections(2).parameters={'tauD',5,'gGABAa',.5,'netcon','rand(N_pre,N_post)'};

s.connections(3).direction='L1I->L2I';
s.connections(3).mechanism_list={'iGABA'};
s.connections(3).parameters={'tauD',5,'gGABAa',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(4).direction='L2I->L1I';
s.connections(4).mechanism_list={'iGABA'};
s.connections(4).parameters={'tauD',5,'gGABAa',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(5).direction='L1E->L2E';
s.connections(5).mechanism_list={'iAMPA'};
s.connections(5).parameters={'tauD',5,'gAMPA',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(6).direction='L2E->L1E';
s.connections(6).mechanism_list={'iAMPA'};
s.connections(6).parameters={'tauD',5,'gAMPA',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(7).direction='L2E->L2I';
s.connections(7).mechanism_list={'iAMPA'};
s.connections(7).parameters={'tauD',5,'gAMPA',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(8).direction='L2I->L2E';
s.connections(8).mechanism_list={'iGABA'};
s.connections(8).parameters={'tauD',5,'gGABAa',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(9).direction='L2E->L3E';
s.connections(9).mechanism_list={'iAMPA'};
s.connections(9).parameters={'tauD',5,'gAMPA',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(10).direction='L2I->L3I';
s.connections(10).mechanism_list={'iGABA'};
s.connections(10).parameters={'tauD',5,'gGABAa',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(11).direction='L3E->L2E';
s.connections(11).mechanism_list={'iAMPA'};
s.connections(11).parameters={'tauD',5,'gAMPA',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(12).direction='L3I->L2I';
s.connections(12).mechanism_list={'iGABA'};
s.connections(12).parameters={'tauD',5,'gGABAa',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(13).direction='L3E->L3I';
s.connections(13).mechanism_list={'iAMPA'};
s.connections(13).parameters={'tauD',5,'gAMPA',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(14).direction='L3I->L3E';
s.connections(14).mechanism_list={'iGABA'};
s.connections(14).parameters={'tauD',5,'gGABAa',.5,'netcon', 'rand(N_pre,N_post)'}; 

s.connections(15).direction='Input1->L2E';
s.connections(15).mechanism_list={'iAMPA'};
s.connections(15).parameters={'tauD',5,'gAMPA',.9,'netcon', 'ones(N_pre,N_post)'}; 

s.connections(16).direction='Input2->L2I';
s.connections(16).mechanism_list={'iAMPA'};
s.connections(16).parameters={'tauD',5,'gAMPA',.9,'netcon', 'ones(N_pre,N_post)'}; 

disp('init done.');

m = DynaModel(s);
disp('done.');

%% Trials' training script script

clc;

lambda = 0.02;
input_cues = {{eqns_input1, eqns_input1}, {eqns_input1, eqns_input2}, {eqns_input2, eqns_input1}};
target_responses = [7, 9, 11];
batch_size = size(target_responses, 2);

input_layers = [7, 8];
output_indice = {53}; % L3I Spikes
T = 300;
dT = 0.01;

update_mode = 'uniform';
error_mode = 'MAE';
% momentum = 0.8;
iterations = 10;

fprintf("Training started, connectivity update mode : %s, error calc method : %s\n", update_mode, error_mode);

for i = 1:iterations
    
    for j = 1:batch_size
        
        c_input = input_cues(j);
        c_input = c_input{1};
        c_target = target_responses(j);
        m.run_trial(c_input, input_layers, output_indice, T, dT, c_target, lambda, update_mode, error_mode);
    
    end
    
    fprintf("Trial no. %d of current batch %d, MAE = %f \n", get(m, 'last_trial'), i, mean(m.errors_log(end-2:end)));
    
end

disp('done');

%% Voltage visualization

clc;
dsPlot(m.data);

%% Error plot

clc;
m.error_plot('Error of target-output (MAE)');

%% Single trial step

clc;
j = 1;
c_input = input_cues(j);
c_input = c_input{1};
c_target = target_responses(j);
m.run_trial(c_input, input_layers, output_indice, T, dT, c_target, lambda, update_mode, error_mode);
fprintf("O = %f, T = %f\n", m.get_outputs_spike(), m.last_targets);     

%% Extract and see field names for input/output index checking

clc;
f = fieldnames(m.data);

%%