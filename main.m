%% Add to path

clc;clear;
addpath C:\Users\hamed\Research\PredictiveCoding\DynaSim-dev
savepath

%%

clc;

eqns={
  'dv/dt=Iapp+@current+noise*randn(1,N_pop); Iapp=0; noise=1'
  'monitor iGABAa.functions, iAMPA.functions'
};

model_size = 5;
s=[];

for i = 1:model_size

    s.populations(i).name= ['P', num2str(i)];
    s.populations(i).size=10;
    s.populations(i).equations=eqns;
    s.populations(i).mechanism_list={'iNa','iK'};
    s.populations(i).parameters={'Iapp',9,'gNa',120,'gK',36,'noise',10};

end

disp("Populations created...");

for i = 1:model_size
    for j = 1:model_size

        s.connections((i-1)*model_size + j).direction = [s.populations(i).name, '->', s.populations(j).name];
        s.connections((i-1)*model_size + j).mechanism_list={'iGABAa'};
        s.connections((i-1)*model_size + j).parameters={'tauD', 3, 'gGABAa', .1, 'netcon', ones(10,10)}; 
        
    end
end

disp("Connections created...");

%%

data=dsSimulate(s);
dsPlot(data);

%%
