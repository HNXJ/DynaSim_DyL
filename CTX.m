%% 3-layer neocortical model of PFC

% Manually determined weights version. 

%% Model parameters

clear;clc;

s = neoCortexPFC();

% %% Simulate

fprintf("Running simulation ...\n");

simulator_options = {'solver','rk1','dt',.01,'downsample_factor',10,'verbose_flag',1};
tspan = [0 900]; % [beg, end] (ms)

vary = {'SA','g_poisson',[g_poisson]; 'SA','DC_poisson', [3e7];'SA','AC_poisson', [0]; 'SA', 'onset_poisson', [300 600]; 'SA', 'offset_poisson', [600];
       'SB','g_poisson',[g_poisson]; 'SB','DC_poisson', [3e7];'SB','AC_poisson', [0]; 'SB', 'onset_poisson', [300 600]; 'SB', 'offset_poisson', [600];
       'Cx1','g_poisson',[g_poisson]; 'Cx1','DC_poisson', [3e7];'Cx1','AC_poisson', [0]; 'Cx1', 'onset_poisson', [600]; 'Cx1', 'offset_poisson', [600];
       'Cx2','g_poisson',[g_poisson]; 'Cx2','DC_poisson', [3e7];'Cx2','AC_poisson', [0]; 'Cx2', 'onset_poisson', [300]; 'Cx2', 'offset_poisson', [600]};
   
data=dsSimulate(s,'vary',vary,'tspan',tspan,simulator_options{:});

fprintf("Simulation done.\n");  

%% Plots results (normal/raster)

clc;
% dsPlot(data);
dsPlot(data,'plot_type','raster'); % Raster

%% Extract outputs & compare

clc;
% Instanteneous firing rate compare between input 1 and 2 (special case) 
ifr_compare_plot(data);

%%

clc;

plot_rasters(data(1));

%% 

dsfname = "Files/dataT.mat";

try
   
    load(dsfname);
    n = max(size(dataset));

catch
    
    dataset = {};
    n = 0;
    
end

savetrial(dsfname, dataset, n, data);

%%