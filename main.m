%%

clc;

eqns={
  'dv/dt=Iapp+@current+noise*randn(1,N_pop); Iapp=0.1; noise=1'
  'monitor iGABAa.functions, iAMPA.functions'
};

model_size = 5;
s=[];
gNa = [90, 95, 100, 125, 120];
gK = [35, 36, 44, 31, 37];

for i = 1:model_size

    s.populations(i).name= ['P', num2str(i)];
    s.populations(i).size=5;
    s.populations(i).equations=eqns;
    s.populations(i).mechanism_list={'iNa', 'iK'};
    s.populations(i).parameters={'Iapp', 9, 'gNa', gNa(i), 'gK', gK(i), 'noise', 5};

end

disp("Populations created...");

for i = 1:model_size
    for j = 1:model_size

        s.connections((i-1)*model_size + j).direction = [s.populations(i).name, '->', s.populations(j).name];
        s.connections((i-1)*model_size + j).mechanism_list={'iGABAa'};
        s.connections((i-1)*model_size + j).parameters={'tauD', 3, 'gGABAa', .1, 'netcon', ones(5, 5)}; 
        
    end
end

disp("Connections created...");

%%

data=dsSimulate(s);
dsPlot(data);

%%
