function [T,L1I_v,L1I_iNa_m,L1I_iNa_h,L1I_iK_n,L2I_v,L2I_iNa_m,L2I_iNa_h,L2I_iK_n,L3I_v,L3I_iNa_m,L3I_iNa_h,L3I_iK_n,L1E_v,L1E_iNa_m,L1E_iNa_h,L1E_iK_n,L2E_v,L2E_iNa_m,L2E_iNa_h,L2E_iK_n,L3E_v,L3E_iNa_m,L3E_iNa_h,L3E_iK_n,Input1_iNa_m,Input1_iNa_h,Input1_iK_n,Input2_iNa_m,Input2_iNa_h,Input2_iK_n,L1I_L1E_iAMPA_s,L1E_L1I_iGABA_s,L2I_L1I_iGABA_s,L1I_L2I_iGABA_s,L2E_L1E_iAMPA_s,L1E_L2E_iAMPA_s,L2I_L2E_iAMPA_s,L2E_L2I_iGABA_s,L3E_L2E_iAMPA_s,L3I_L2I_iGABA_s,L2E_L3E_iAMPA_s,L2I_L3I_iGABA_s,L3I_L3E_iAMPA_s,L3E_L3I_iGABA_s,L2E_Input1_iAMPA_s,L2I_Input2_iAMPA_s,L1I_v_spikes,L2I_v_spikes,L3I_v_spikes,L1E_v_spikes,L2E_v_spikes,L3E_v_spikes,Input1_v_spikes,Input2_v_spikes,L1E_L1I_iGABA_IGABA,L1E_L2E_iAMPA_IAMPA,L1I_L1E_iAMPA_IAMPA,L1I_L2I_iGABA_IGABA,L2E_Input1_iAMPA_IAMPA,L2E_L1E_iAMPA_IAMPA,L2E_L2I_iGABA_IGABA,L2E_L3E_iAMPA_IAMPA,L2I_Input2_iAMPA_IAMPA,L2I_L1I_iGABA_IGABA,L2I_L2E_iAMPA_IAMPA,L2I_L3I_iGABA_IGABA,L3E_L2E_iAMPA_IAMPA,L3E_L3I_iGABA_IGABA,L3I_L2I_iGABA_IGABA,L3I_L3E_iAMPA_IAMPA,L1I_L1E_iAMPA_netcon,L1E_L1I_iGABA_netcon,L2I_L1I_iGABA_netcon,L1I_L2I_iGABA_netcon,L2E_L1E_iAMPA_netcon,L1E_L2E_iAMPA_netcon,L2I_L2E_iAMPA_netcon,L2E_L2I_iGABA_netcon,L3E_L2E_iAMPA_netcon,L3I_L2I_iGABA_netcon,L2E_L3E_iAMPA_netcon,L2I_L3I_iGABA_netcon,L3I_L3E_iAMPA_netcon,L3E_L3I_iGABA_netcon,L2E_Input1_iAMPA_netcon,L2I_Input2_iAMPA_netcon]=solve_ode

% ------------------------------------------------------------
% Parameters:
% ------------------------------------------------------------
params = load('params.mat','p');
p = params.p;
downsample_factor=p.downsample_factor;
dt=p.dt;
T=(p.tspan(1):dt:p.tspan(2))';
ntime=length(T);
nsamp=length(1:downsample_factor:ntime);

% random_seed was set to shuffle earlier. 

% ------------------------------------------------------------
% Fixed variables:
% ------------------------------------------------------------
L1I_L1E_iAMPA_netcon = rand(p.L1E_Npop,p.L1I_Npop);
L1E_L1I_iGABA_netcon = rand(p.L1I_Npop,p.L1E_Npop);
L2I_L1I_iGABA_netcon = rand(p.L1I_Npop,p.L2I_Npop);
L1I_L2I_iGABA_netcon = rand(p.L2I_Npop,p.L1I_Npop);
L2E_L1E_iAMPA_netcon = rand(p.L1E_Npop,p.L2E_Npop);
L1E_L2E_iAMPA_netcon = rand(p.L2E_Npop,p.L1E_Npop);
L2I_L2E_iAMPA_netcon = rand(p.L2E_Npop,p.L2I_Npop);
L2E_L2I_iGABA_netcon = rand(p.L2I_Npop,p.L2E_Npop);
L3E_L2E_iAMPA_netcon = rand(p.L2E_Npop,p.L3E_Npop);
L3I_L2I_iGABA_netcon = rand(p.L2I_Npop,p.L3I_Npop);
L2E_L3E_iAMPA_netcon = rand(p.L3E_Npop,p.L2E_Npop);
L2I_L3I_iGABA_netcon = rand(p.L3I_Npop,p.L2I_Npop);
L3I_L3E_iAMPA_netcon = rand(p.L3E_Npop,p.L3I_Npop);
L3E_L3I_iGABA_netcon = rand(p.L3I_Npop,p.L3E_Npop);
L2E_Input1_iAMPA_netcon = rand(p.Input1_Npop,p.L2E_Npop);
L2I_Input2_iAMPA_netcon = rand(p.Input2_Npop,p.L2I_Npop);

% ------------------------------------------------------------
% Initial conditions:
% ------------------------------------------------------------
t=0; k=1;

% STATE_VARIABLES:
L1I_v_last = zeros(1,p.L1I_Npop);
L1I_v = zeros(nsamp,p.L1I_Npop);
L1I_v(1,:) = L1I_v_last;
L1I_iNa_m_last = p.L1I_iNa_m_IC+p.L1I_iNa_IC_noise*rand(1,p.L1I_Npop);
L1I_iNa_m = zeros(nsamp,p.L1I_Npop);
L1I_iNa_m(1,:) = L1I_iNa_m_last;
L1I_iNa_h_last = p.L1I_iNa_h_IC+p.L1I_iNa_IC_noise*rand(1,p.L1I_Npop);
L1I_iNa_h = zeros(nsamp,p.L1I_Npop);
L1I_iNa_h(1,:) = L1I_iNa_h_last;
L1I_iK_n_last = p.L1I_iK_n_IC+p.L1I_iK_IC_noise*rand(1,p.L1I_Npop);
L1I_iK_n = zeros(nsamp,p.L1I_Npop);
L1I_iK_n(1,:) = L1I_iK_n_last;
L2I_v_last = zeros(1,p.L2I_Npop);
L2I_v = zeros(nsamp,p.L2I_Npop);
L2I_v(1,:) = L2I_v_last;
L2I_iNa_m_last = p.L2I_iNa_m_IC+p.L2I_iNa_IC_noise*rand(1,p.L2I_Npop);
L2I_iNa_m = zeros(nsamp,p.L2I_Npop);
L2I_iNa_m(1,:) = L2I_iNa_m_last;
L2I_iNa_h_last = p.L2I_iNa_h_IC+p.L2I_iNa_IC_noise*rand(1,p.L2I_Npop);
L2I_iNa_h = zeros(nsamp,p.L2I_Npop);
L2I_iNa_h(1,:) = L2I_iNa_h_last;
L2I_iK_n_last = p.L2I_iK_n_IC+p.L2I_iK_IC_noise*rand(1,p.L2I_Npop);
L2I_iK_n = zeros(nsamp,p.L2I_Npop);
L2I_iK_n(1,:) = L2I_iK_n_last;
L3I_v_last = zeros(1,p.L3I_Npop);
L3I_v = zeros(nsamp,p.L3I_Npop);
L3I_v(1,:) = L3I_v_last;
L3I_iNa_m_last = p.L3I_iNa_m_IC+p.L3I_iNa_IC_noise*rand(1,p.L3I_Npop);
L3I_iNa_m = zeros(nsamp,p.L3I_Npop);
L3I_iNa_m(1,:) = L3I_iNa_m_last;
L3I_iNa_h_last = p.L3I_iNa_h_IC+p.L3I_iNa_IC_noise*rand(1,p.L3I_Npop);
L3I_iNa_h = zeros(nsamp,p.L3I_Npop);
L3I_iNa_h(1,:) = L3I_iNa_h_last;
L3I_iK_n_last = p.L3I_iK_n_IC+p.L3I_iK_IC_noise*rand(1,p.L3I_Npop);
L3I_iK_n = zeros(nsamp,p.L3I_Npop);
L3I_iK_n(1,:) = L3I_iK_n_last;
L1E_v_last = zeros(1,p.L1E_Npop);
L1E_v = zeros(nsamp,p.L1E_Npop);
L1E_v(1,:) = L1E_v_last;
L1E_iNa_m_last = p.L1E_iNa_m_IC+p.L1E_iNa_IC_noise*rand(1,p.L1E_Npop);
L1E_iNa_m = zeros(nsamp,p.L1E_Npop);
L1E_iNa_m(1,:) = L1E_iNa_m_last;
L1E_iNa_h_last = p.L1E_iNa_h_IC+p.L1E_iNa_IC_noise*rand(1,p.L1E_Npop);
L1E_iNa_h = zeros(nsamp,p.L1E_Npop);
L1E_iNa_h(1,:) = L1E_iNa_h_last;
L1E_iK_n_last = p.L1E_iK_n_IC+p.L1E_iK_IC_noise*rand(1,p.L1E_Npop);
L1E_iK_n = zeros(nsamp,p.L1E_Npop);
L1E_iK_n(1,:) = L1E_iK_n_last;
L2E_v_last = zeros(1,p.L2E_Npop);
L2E_v = zeros(nsamp,p.L2E_Npop);
L2E_v(1,:) = L2E_v_last;
L2E_iNa_m_last = p.L2E_iNa_m_IC+p.L2E_iNa_IC_noise*rand(1,p.L2E_Npop);
L2E_iNa_m = zeros(nsamp,p.L2E_Npop);
L2E_iNa_m(1,:) = L2E_iNa_m_last;
L2E_iNa_h_last = p.L2E_iNa_h_IC+p.L2E_iNa_IC_noise*rand(1,p.L2E_Npop);
L2E_iNa_h = zeros(nsamp,p.L2E_Npop);
L2E_iNa_h(1,:) = L2E_iNa_h_last;
L2E_iK_n_last = p.L2E_iK_n_IC+p.L2E_iK_IC_noise*rand(1,p.L2E_Npop);
L2E_iK_n = zeros(nsamp,p.L2E_Npop);
L2E_iK_n(1,:) = L2E_iK_n_last;
L3E_v_last = zeros(1,p.L3E_Npop);
L3E_v = zeros(nsamp,p.L3E_Npop);
L3E_v(1,:) = L3E_v_last;
L3E_iNa_m_last = p.L3E_iNa_m_IC+p.L3E_iNa_IC_noise*rand(1,p.L3E_Npop);
L3E_iNa_m = zeros(nsamp,p.L3E_Npop);
L3E_iNa_m(1,:) = L3E_iNa_m_last;
L3E_iNa_h_last = p.L3E_iNa_h_IC+p.L3E_iNa_IC_noise*rand(1,p.L3E_Npop);
L3E_iNa_h = zeros(nsamp,p.L3E_Npop);
L3E_iNa_h(1,:) = L3E_iNa_h_last;
L3E_iK_n_last = p.L3E_iK_n_IC+p.L3E_iK_IC_noise*rand(1,p.L3E_Npop);
L3E_iK_n = zeros(nsamp,p.L3E_Npop);
L3E_iK_n(1,:) = L3E_iK_n_last;
Input1_iNa_m_last = p.Input1_iNa_m_IC+p.Input1_iNa_IC_noise*rand(1,p.Input1_Npop);
Input1_iNa_m = zeros(nsamp,p.Input1_Npop);
Input1_iNa_m(1,:) = Input1_iNa_m_last;
Input1_iNa_h_last = p.Input1_iNa_h_IC+p.Input1_iNa_IC_noise*rand(1,p.Input1_Npop);
Input1_iNa_h = zeros(nsamp,p.Input1_Npop);
Input1_iNa_h(1,:) = Input1_iNa_h_last;
Input1_iK_n_last = p.Input1_iK_n_IC+p.Input1_iK_IC_noise*rand(1,p.Input1_Npop);
Input1_iK_n = zeros(nsamp,p.Input1_Npop);
Input1_iK_n(1,:) = Input1_iK_n_last;
Input2_iNa_m_last = p.Input2_iNa_m_IC+p.Input2_iNa_IC_noise*rand(1,p.Input2_Npop);
Input2_iNa_m = zeros(nsamp,p.Input2_Npop);
Input2_iNa_m(1,:) = Input2_iNa_m_last;
Input2_iNa_h_last = p.Input2_iNa_h_IC+p.Input2_iNa_IC_noise*rand(1,p.Input2_Npop);
Input2_iNa_h = zeros(nsamp,p.Input2_Npop);
Input2_iNa_h(1,:) = Input2_iNa_h_last;
Input2_iK_n_last = p.Input2_iK_n_IC+p.Input2_iK_IC_noise*rand(1,p.Input2_Npop);
Input2_iK_n = zeros(nsamp,p.Input2_Npop);
Input2_iK_n(1,:) = Input2_iK_n_last;
L1I_L1E_iAMPA_s_last =  p.L1I_L1E_iAMPA_IC+p.L1I_L1E_iAMPA_IC_noise.*rand(1,p.L1E_Npop);
L1I_L1E_iAMPA_s = zeros(nsamp,p.L1E_Npop);
L1I_L1E_iAMPA_s(1,:) = L1I_L1E_iAMPA_s_last;
L1E_L1I_iGABA_s_last =  p.L1E_L1I_iGABA_IC+p.L1E_L1I_iGABA_IC_noise.*rand(1,p.L1I_Npop);
L1E_L1I_iGABA_s = zeros(nsamp,p.L1I_Npop);
L1E_L1I_iGABA_s(1,:) = L1E_L1I_iGABA_s_last;
L2I_L1I_iGABA_s_last =  p.L2I_L1I_iGABA_IC+p.L2I_L1I_iGABA_IC_noise.*rand(1,p.L1I_Npop);
L2I_L1I_iGABA_s = zeros(nsamp,p.L1I_Npop);
L2I_L1I_iGABA_s(1,:) = L2I_L1I_iGABA_s_last;
L1I_L2I_iGABA_s_last =  p.L1I_L2I_iGABA_IC+p.L1I_L2I_iGABA_IC_noise.*rand(1,p.L2I_Npop);
L1I_L2I_iGABA_s = zeros(nsamp,p.L2I_Npop);
L1I_L2I_iGABA_s(1,:) = L1I_L2I_iGABA_s_last;
L2E_L1E_iAMPA_s_last =  p.L2E_L1E_iAMPA_IC+p.L2E_L1E_iAMPA_IC_noise.*rand(1,p.L1E_Npop);
L2E_L1E_iAMPA_s = zeros(nsamp,p.L1E_Npop);
L2E_L1E_iAMPA_s(1,:) = L2E_L1E_iAMPA_s_last;
L1E_L2E_iAMPA_s_last =  p.L1E_L2E_iAMPA_IC+p.L1E_L2E_iAMPA_IC_noise.*rand(1,p.L2E_Npop);
L1E_L2E_iAMPA_s = zeros(nsamp,p.L2E_Npop);
L1E_L2E_iAMPA_s(1,:) = L1E_L2E_iAMPA_s_last;
L2I_L2E_iAMPA_s_last =  p.L2I_L2E_iAMPA_IC+p.L2I_L2E_iAMPA_IC_noise.*rand(1,p.L2E_Npop);
L2I_L2E_iAMPA_s = zeros(nsamp,p.L2E_Npop);
L2I_L2E_iAMPA_s(1,:) = L2I_L2E_iAMPA_s_last;
L2E_L2I_iGABA_s_last =  p.L2E_L2I_iGABA_IC+p.L2E_L2I_iGABA_IC_noise.*rand(1,p.L2I_Npop);
L2E_L2I_iGABA_s = zeros(nsamp,p.L2I_Npop);
L2E_L2I_iGABA_s(1,:) = L2E_L2I_iGABA_s_last;
L3E_L2E_iAMPA_s_last =  p.L3E_L2E_iAMPA_IC+p.L3E_L2E_iAMPA_IC_noise.*rand(1,p.L2E_Npop);
L3E_L2E_iAMPA_s = zeros(nsamp,p.L2E_Npop);
L3E_L2E_iAMPA_s(1,:) = L3E_L2E_iAMPA_s_last;
L3I_L2I_iGABA_s_last =  p.L3I_L2I_iGABA_IC+p.L3I_L2I_iGABA_IC_noise.*rand(1,p.L2I_Npop);
L3I_L2I_iGABA_s = zeros(nsamp,p.L2I_Npop);
L3I_L2I_iGABA_s(1,:) = L3I_L2I_iGABA_s_last;
L2E_L3E_iAMPA_s_last =  p.L2E_L3E_iAMPA_IC+p.L2E_L3E_iAMPA_IC_noise.*rand(1,p.L3E_Npop);
L2E_L3E_iAMPA_s = zeros(nsamp,p.L3E_Npop);
L2E_L3E_iAMPA_s(1,:) = L2E_L3E_iAMPA_s_last;
L2I_L3I_iGABA_s_last =  p.L2I_L3I_iGABA_IC+p.L2I_L3I_iGABA_IC_noise.*rand(1,p.L3I_Npop);
L2I_L3I_iGABA_s = zeros(nsamp,p.L3I_Npop);
L2I_L3I_iGABA_s(1,:) = L2I_L3I_iGABA_s_last;
L3I_L3E_iAMPA_s_last =  p.L3I_L3E_iAMPA_IC+p.L3I_L3E_iAMPA_IC_noise.*rand(1,p.L3E_Npop);
L3I_L3E_iAMPA_s = zeros(nsamp,p.L3E_Npop);
L3I_L3E_iAMPA_s(1,:) = L3I_L3E_iAMPA_s_last;
L3E_L3I_iGABA_s_last =  p.L3E_L3I_iGABA_IC+p.L3E_L3I_iGABA_IC_noise.*rand(1,p.L3I_Npop);
L3E_L3I_iGABA_s = zeros(nsamp,p.L3I_Npop);
L3E_L3I_iGABA_s(1,:) = L3E_L3I_iGABA_s_last;
L2E_Input1_iAMPA_s_last =  p.L2E_Input1_iAMPA_IC+p.L2E_Input1_iAMPA_IC_noise.*rand(1,p.Input1_Npop);
L2E_Input1_iAMPA_s = zeros(nsamp,p.Input1_Npop);
L2E_Input1_iAMPA_s(1,:) = L2E_Input1_iAMPA_s_last;
L2I_Input2_iAMPA_s_last =  p.L2I_Input2_iAMPA_IC+p.L2I_Input2_iAMPA_IC_noise.*rand(1,p.Input2_Npop);
L2I_Input2_iAMPA_s = zeros(nsamp,p.Input2_Npop);
L2I_Input2_iAMPA_s(1,:) = L2I_Input2_iAMPA_s_last;

% MONITORS:
L1I_tspike = -1e32*ones(2,p.L1I_Npop);
L1I_buffer_index = ones(1,p.L1I_Npop);
L1I_v_spikes = zeros(nsamp,p.L1I_Npop);
L2I_tspike = -1e32*ones(2,p.L2I_Npop);
L2I_buffer_index = ones(1,p.L2I_Npop);
L2I_v_spikes = zeros(nsamp,p.L2I_Npop);
L3I_tspike = -1e32*ones(2,p.L3I_Npop);
L3I_buffer_index = ones(1,p.L3I_Npop);
L3I_v_spikes = zeros(nsamp,p.L3I_Npop);
L1E_tspike = -1e32*ones(2,p.L1E_Npop);
L1E_buffer_index = ones(1,p.L1E_Npop);
L1E_v_spikes = zeros(nsamp,p.L1E_Npop);
L2E_tspike = -1e32*ones(2,p.L2E_Npop);
L2E_buffer_index = ones(1,p.L2E_Npop);
L2E_v_spikes = zeros(nsamp,p.L2E_Npop);
L3E_tspike = -1e32*ones(2,p.L3E_Npop);
L3E_buffer_index = ones(1,p.L3E_Npop);
L3E_v_spikes = zeros(nsamp,p.L3E_Npop);
Input1_tspike = -1e32*ones(2,p.Input1_Npop);
Input1_buffer_index = ones(1,p.Input1_Npop);
Input1_v_spikes = zeros(nsamp,p.Input1_Npop);
Input2_tspike = -1e32*ones(2,p.Input2_Npop);
Input2_buffer_index = ones(1,p.Input2_Npop);
Input2_v_spikes = zeros(nsamp,p.Input2_Npop);
L1E_L1I_iGABA_IGABA = zeros(nsamp,p.L1E_Npop);
  L1E_L1I_iGABA_IGABA(1,:)=(p.L1E_L1I_iGABA_gGABA.*(L1E_L1I_iGABA_s_last*L1E_L1I_iGABA_netcon).*(L1E_v_last-p.L1E_L1I_iGABA_EGABA));
L1E_L2E_iAMPA_IAMPA = zeros(nsamp,p.L1E_Npop);
  L1E_L2E_iAMPA_IAMPA(1,:)=-p.L1E_L2E_iAMPA_gAMPA.*(L1E_L2E_iAMPA_s_last*L1E_L2E_iAMPA_netcon).*(L1E_v_last-p.L1E_L2E_iAMPA_EAMPA);
L1I_L1E_iAMPA_IAMPA = zeros(nsamp,p.L1I_Npop);
  L1I_L1E_iAMPA_IAMPA(1,:)=-p.L1I_L1E_iAMPA_gAMPA.*(L1I_L1E_iAMPA_s_last*L1I_L1E_iAMPA_netcon).*(L1I_v_last-p.L1I_L1E_iAMPA_EAMPA);
L1I_L2I_iGABA_IGABA = zeros(nsamp,p.L1I_Npop);
  L1I_L2I_iGABA_IGABA(1,:)=(p.L1I_L2I_iGABA_gGABA.*(L1I_L2I_iGABA_s_last*L1I_L2I_iGABA_netcon).*(L1I_v_last-p.L1I_L2I_iGABA_EGABA));
L2E_Input1_iAMPA_IAMPA = zeros(nsamp,p.L2E_Npop);
  L2E_Input1_iAMPA_IAMPA(1,:)=-p.L2E_Input1_iAMPA_gAMPA.*(L2E_Input1_iAMPA_s_last*L2E_Input1_iAMPA_netcon).*(L2E_v_last-p.L2E_Input1_iAMPA_EAMPA);
L2E_L1E_iAMPA_IAMPA = zeros(nsamp,p.L2E_Npop);
  L2E_L1E_iAMPA_IAMPA(1,:)=-p.L2E_L1E_iAMPA_gAMPA.*(L2E_L1E_iAMPA_s_last*L2E_L1E_iAMPA_netcon).*(L2E_v_last-p.L2E_L1E_iAMPA_EAMPA);
L2E_L2I_iGABA_IGABA = zeros(nsamp,p.L2E_Npop);
  L2E_L2I_iGABA_IGABA(1,:)=(p.L2E_L2I_iGABA_gGABA.*(L2E_L2I_iGABA_s_last*L2E_L2I_iGABA_netcon).*(L2E_v_last-p.L2E_L2I_iGABA_EGABA));
L2E_L3E_iAMPA_IAMPA = zeros(nsamp,p.L2E_Npop);
  L2E_L3E_iAMPA_IAMPA(1,:)=-p.L2E_L3E_iAMPA_gAMPA.*(L2E_L3E_iAMPA_s_last*L2E_L3E_iAMPA_netcon).*(L2E_v_last-p.L2E_L3E_iAMPA_EAMPA);
L2I_Input2_iAMPA_IAMPA = zeros(nsamp,p.L2I_Npop);
  L2I_Input2_iAMPA_IAMPA(1,:)=-p.L2I_Input2_iAMPA_gAMPA.*(L2I_Input2_iAMPA_s_last*L2I_Input2_iAMPA_netcon).*(L2I_v_last-p.L2I_Input2_iAMPA_EAMPA);
L2I_L1I_iGABA_IGABA = zeros(nsamp,p.L2I_Npop);
  L2I_L1I_iGABA_IGABA(1,:)=(p.L2I_L1I_iGABA_gGABA.*(L2I_L1I_iGABA_s_last*L2I_L1I_iGABA_netcon).*(L2I_v_last-p.L2I_L1I_iGABA_EGABA));
L2I_L2E_iAMPA_IAMPA = zeros(nsamp,p.L2I_Npop);
  L2I_L2E_iAMPA_IAMPA(1,:)=-p.L2I_L2E_iAMPA_gAMPA.*(L2I_L2E_iAMPA_s_last*L2I_L2E_iAMPA_netcon).*(L2I_v_last-p.L2I_L2E_iAMPA_EAMPA);
L2I_L3I_iGABA_IGABA = zeros(nsamp,p.L2I_Npop);
  L2I_L3I_iGABA_IGABA(1,:)=(p.L2I_L3I_iGABA_gGABA.*(L2I_L3I_iGABA_s_last*L2I_L3I_iGABA_netcon).*(L2I_v_last-p.L2I_L3I_iGABA_EGABA));
L3E_L2E_iAMPA_IAMPA = zeros(nsamp,p.L3E_Npop);
  L3E_L2E_iAMPA_IAMPA(1,:)=-p.L3E_L2E_iAMPA_gAMPA.*(L3E_L2E_iAMPA_s_last*L3E_L2E_iAMPA_netcon).*(L3E_v_last-p.L3E_L2E_iAMPA_EAMPA);
L3E_L3I_iGABA_IGABA = zeros(nsamp,p.L3E_Npop);
  L3E_L3I_iGABA_IGABA(1,:)=(p.L3E_L3I_iGABA_gGABA.*(L3E_L3I_iGABA_s_last*L3E_L3I_iGABA_netcon).*(L3E_v_last-p.L3E_L3I_iGABA_EGABA));
L3I_L2I_iGABA_IGABA = zeros(nsamp,p.L3I_Npop);
  L3I_L2I_iGABA_IGABA(1,:)=(p.L3I_L2I_iGABA_gGABA.*(L3I_L2I_iGABA_s_last*L3I_L2I_iGABA_netcon).*(L3I_v_last-p.L3I_L2I_iGABA_EGABA));
L3I_L3E_iAMPA_IAMPA = zeros(nsamp,p.L3I_Npop);
  L3I_L3E_iAMPA_IAMPA(1,:)=-p.L3I_L3E_iAMPA_gAMPA.*(L3I_L3E_iAMPA_s_last*L3I_L3E_iAMPA_netcon).*(L3I_v_last-p.L3I_L3E_iAMPA_EAMPA);

% ###########################################################
% Memory check:
% ###########################################################
try 
  memoryUsed = memoryUsageCallerGB(); 
  fprintf('Total Memory Used <= %i GB \n', ceil(memoryUsed)); 
end 

% ###########################################################
% Numerical integration:
% ###########################################################
n=2;
for k=2:ntime
  t=T(k-1);
  L1I_v_k1 = 0.4*p.L1I_Iapp + ((((-p.L1I_iNa_gNa.*L1I_iNa_m_last.^3.*L1I_iNa_h_last.*(L1I_v_last-p.L1I_iNa_ENa))))+((((-p.L1I_iK_gK.*L1I_iK_n_last.^4.*(L1I_v_last-p.L1I_iK_EK))))+((((-p.L1I_L1E_iAMPA_gAMPA.*(L1I_L1E_iAMPA_s_last*L1I_L1E_iAMPA_netcon).*(L1I_v_last-p.L1I_L1E_iAMPA_EAMPA))))+((-(((p.L1I_L2I_iGABA_gGABA.*(L1I_L2I_iGABA_s_last*L1I_L2I_iGABA_netcon).*(L1I_v_last-p.L1I_L2I_iGABA_EGABA)))))))))+p.L1I_noise*rand(1,p.L1I_Npop);
  L1I_iNa_m_k1 = (((2.5-.1*(L1I_v_last+65))./(exp(2.5-.1*(L1I_v_last+65))-1))).*(1-L1I_iNa_m_last)-((4*exp(-(L1I_v_last+65)/18))).*L1I_iNa_m_last;
  L1I_iNa_h_k1 = ((.07*exp(-(L1I_v_last+65)/20))).*(1-L1I_iNa_h_last)-((1./(exp(3-.1*(L1I_v_last+65))+1))).*L1I_iNa_h_last;
  L1I_iK_n_k1 = (((.1-.01*(L1I_v_last+65))./(exp(1-.1*(L1I_v_last+65))-1))).*(1-L1I_iK_n_last)-((.125*exp(-(L1I_v_last+65)/80))).*L1I_iK_n_last;
  L2I_v_k1 = 1.0*p.L2I_Iapp + ((((-p.L2I_iNa_gNa.*L2I_iNa_m_last.^3.*L2I_iNa_h_last.*(L2I_v_last-p.L2I_iNa_ENa))))+((((-p.L2I_iK_gK.*L2I_iK_n_last.^4.*(L2I_v_last-p.L2I_iK_EK))))+((-(((p.L2I_L1I_iGABA_gGABA.*(L2I_L1I_iGABA_s_last*L2I_L1I_iGABA_netcon).*(L2I_v_last-p.L2I_L1I_iGABA_EGABA)))))+((((-p.L2I_L2E_iAMPA_gAMPA.*(L2I_L2E_iAMPA_s_last*L2I_L2E_iAMPA_netcon).*(L2I_v_last-p.L2I_L2E_iAMPA_EAMPA))))+((-(((p.L2I_L3I_iGABA_gGABA.*(L2I_L3I_iGABA_s_last*L2I_L3I_iGABA_netcon).*(L2I_v_last-p.L2I_L3I_iGABA_EGABA)))))+((((-p.L2I_Input2_iAMPA_gAMPA.*(L2I_Input2_iAMPA_s_last*L2I_Input2_iAMPA_netcon).*(L2I_v_last-p.L2I_Input2_iAMPA_EAMPA))))))))))+p.L2I_noise*rand(1,p.L2I_Npop);
  L2I_iNa_m_k1 = (((2.5-.1*(L2I_v_last+65))./(exp(2.5-.1*(L2I_v_last+65))-1))).*(1-L2I_iNa_m_last)-((4*exp(-(L2I_v_last+65)/18))).*L2I_iNa_m_last;
  L2I_iNa_h_k1 = ((.07*exp(-(L2I_v_last+65)/20))).*(1-L2I_iNa_h_last)-((1./(exp(3-.1*(L2I_v_last+65))+1))).*L2I_iNa_h_last;
  L2I_iK_n_k1 = (((.1-.01*(L2I_v_last+65))./(exp(1-.1*(L2I_v_last+65))-1))).*(1-L2I_iK_n_last)-((.125*exp(-(L2I_v_last+65)/80))).*L2I_iK_n_last;
  L3I_v_k1 = 1.0*p.L3I_Iapp + ((((-p.L3I_iNa_gNa.*L3I_iNa_m_last.^3.*L3I_iNa_h_last.*(L3I_v_last-p.L3I_iNa_ENa))))+((((-p.L3I_iK_gK.*L3I_iK_n_last.^4.*(L3I_v_last-p.L3I_iK_EK))))+((-(((p.L3I_L2I_iGABA_gGABA.*(L3I_L2I_iGABA_s_last*L3I_L2I_iGABA_netcon).*(L3I_v_last-p.L3I_L2I_iGABA_EGABA)))))+((((-p.L3I_L3E_iAMPA_gAMPA.*(L3I_L3E_iAMPA_s_last*L3I_L3E_iAMPA_netcon).*(L3I_v_last-p.L3I_L3E_iAMPA_EAMPA))))))))+p.L3I_noise*rand(1,p.L3I_Npop);
  L3I_iNa_m_k1 = (((2.5-.1*(L3I_v_last+65))./(exp(2.5-.1*(L3I_v_last+65))-1))).*(1-L3I_iNa_m_last)-((4*exp(-(L3I_v_last+65)/18))).*L3I_iNa_m_last;
  L3I_iNa_h_k1 = ((.07*exp(-(L3I_v_last+65)/20))).*(1-L3I_iNa_h_last)-((1./(exp(3-.1*(L3I_v_last+65))+1))).*L3I_iNa_h_last;
  L3I_iK_n_k1 = (((.1-.01*(L3I_v_last+65))./(exp(1-.1*(L3I_v_last+65))-1))).*(1-L3I_iK_n_last)-((.125*exp(-(L3I_v_last+65)/80))).*L3I_iK_n_last;
  L1E_v_k1 = 0.4*p.L1E_Iapp + ((((-p.L1E_iNa_gNa.*L1E_iNa_m_last.^3.*L1E_iNa_h_last.*(L1E_v_last-p.L1E_iNa_ENa))))+((((-p.L1E_iK_gK.*L1E_iK_n_last.^4.*(L1E_v_last-p.L1E_iK_EK))))+((-(((p.L1E_L1I_iGABA_gGABA.*(L1E_L1I_iGABA_s_last*L1E_L1I_iGABA_netcon).*(L1E_v_last-p.L1E_L1I_iGABA_EGABA)))))+((((-p.L1E_L2E_iAMPA_gAMPA.*(L1E_L2E_iAMPA_s_last*L1E_L2E_iAMPA_netcon).*(L1E_v_last-p.L1E_L2E_iAMPA_EAMPA))))))))+p.L1E_noise*rand(1,p.L1E_Npop);
  L1E_iNa_m_k1 = (((2.5-.1*(L1E_v_last+65))./(exp(2.5-.1*(L1E_v_last+65))-1))).*(1-L1E_iNa_m_last)-((4*exp(-(L1E_v_last+65)/18))).*L1E_iNa_m_last;
  L1E_iNa_h_k1 = ((.07*exp(-(L1E_v_last+65)/20))).*(1-L1E_iNa_h_last)-((1./(exp(3-.1*(L1E_v_last+65))+1))).*L1E_iNa_h_last;
  L1E_iK_n_k1 = (((.1-.01*(L1E_v_last+65))./(exp(1-.1*(L1E_v_last+65))-1))).*(1-L1E_iK_n_last)-((.125*exp(-(L1E_v_last+65)/80))).*L1E_iK_n_last;
  L2E_v_k1 = 1.0*p.L2E_Iapp + ((((-p.L2E_iNa_gNa.*L2E_iNa_m_last.^3.*L2E_iNa_h_last.*(L2E_v_last-p.L2E_iNa_ENa))))+((((-p.L2E_iK_gK.*L2E_iK_n_last.^4.*(L2E_v_last-p.L2E_iK_EK))))+((((-p.L2E_L1E_iAMPA_gAMPA.*(L2E_L1E_iAMPA_s_last*L2E_L1E_iAMPA_netcon).*(L2E_v_last-p.L2E_L1E_iAMPA_EAMPA))))+((-(((p.L2E_L2I_iGABA_gGABA.*(L2E_L2I_iGABA_s_last*L2E_L2I_iGABA_netcon).*(L2E_v_last-p.L2E_L2I_iGABA_EGABA)))))+((((-p.L2E_L3E_iAMPA_gAMPA.*(L2E_L3E_iAMPA_s_last*L2E_L3E_iAMPA_netcon).*(L2E_v_last-p.L2E_L3E_iAMPA_EAMPA))))+((((-p.L2E_Input1_iAMPA_gAMPA.*(L2E_Input1_iAMPA_s_last*L2E_Input1_iAMPA_netcon).*(L2E_v_last-p.L2E_Input1_iAMPA_EAMPA))))))))))+p.L2E_noise*rand(1,p.L2E_Npop);
  L2E_iNa_m_k1 = (((2.5-.1*(L2E_v_last+65))./(exp(2.5-.1*(L2E_v_last+65))-1))).*(1-L2E_iNa_m_last)-((4*exp(-(L2E_v_last+65)/18))).*L2E_iNa_m_last;
  L2E_iNa_h_k1 = ((.07*exp(-(L2E_v_last+65)/20))).*(1-L2E_iNa_h_last)-((1./(exp(3-.1*(L2E_v_last+65))+1))).*L2E_iNa_h_last;
  L2E_iK_n_k1 = (((.1-.01*(L2E_v_last+65))./(exp(1-.1*(L2E_v_last+65))-1))).*(1-L2E_iK_n_last)-((.125*exp(-(L2E_v_last+65)/80))).*L2E_iK_n_last;
  L3E_v_k1 = 1.0*p.L3E_Iapp + ((((-p.L3E_iNa_gNa.*L3E_iNa_m_last.^3.*L3E_iNa_h_last.*(L3E_v_last-p.L3E_iNa_ENa))))+((((-p.L3E_iK_gK.*L3E_iK_n_last.^4.*(L3E_v_last-p.L3E_iK_EK))))+((((-p.L3E_L2E_iAMPA_gAMPA.*(L3E_L2E_iAMPA_s_last*L3E_L2E_iAMPA_netcon).*(L3E_v_last-p.L3E_L2E_iAMPA_EAMPA))))+((-(((p.L3E_L3I_iGABA_gGABA.*(L3E_L3I_iGABA_s_last*L3E_L3I_iGABA_netcon).*(L3E_v_last-p.L3E_L3I_iGABA_EGABA)))))))))+p.L3E_noise*rand(1,p.L3E_Npop);
  L3E_iNa_m_k1 = (((2.5-.1*(L3E_v_last+65))./(exp(2.5-.1*(L3E_v_last+65))-1))).*(1-L3E_iNa_m_last)-((4*exp(-(L3E_v_last+65)/18))).*L3E_iNa_m_last;
  L3E_iNa_h_k1 = ((.07*exp(-(L3E_v_last+65)/20))).*(1-L3E_iNa_h_last)-((1./(exp(3-.1*(L3E_v_last+65))+1))).*L3E_iNa_h_last;
  L3E_iK_n_k1 = (((.1-.01*(L3E_v_last+65))./(exp(1-.1*(L3E_v_last+65))-1))).*(1-L3E_iK_n_last)-((.125*exp(-(L3E_v_last+65)/80))).*L3E_iK_n_last;
  Input1_iNa_m_k1 = (((2.5-.1*(X+65))./(exp(2.5-.1*(X+65))-1))).*(1-Input1_iNa_m_last)-((4*exp(-(X+65)/18))).*Input1_iNa_m_last;
  Input1_iNa_h_k1 = ((.07*exp(-(X+65)/20))).*(1-Input1_iNa_h_last)-((1./(exp(3-.1*(X+65))+1))).*Input1_iNa_h_last;
  Input1_iK_n_k1 = (((.1-.01*(X+65))./(exp(1-.1*(X+65))-1))).*(1-Input1_iK_n_last)-((.125*exp(-(X+65)/80))).*Input1_iK_n_last;
  Input2_iNa_m_k1 = (((2.5-.1*(X+65))./(exp(2.5-.1*(X+65))-1))).*(1-Input2_iNa_m_last)-((4*exp(-(X+65)/18))).*Input2_iNa_m_last;
  Input2_iNa_h_k1 = ((.07*exp(-(X+65)/20))).*(1-Input2_iNa_h_last)-((1./(exp(3-.1*(X+65))+1))).*Input2_iNa_h_last;
  Input2_iK_n_k1 = (((.1-.01*(X+65))./(exp(1-.1*(X+65))-1))).*(1-Input2_iK_n_last)-((.125*exp(-(X+65)/80))).*Input2_iK_n_last;
  L1I_L1E_iAMPA_s_k1 = -L1I_L1E_iAMPA_s_last./p.L1I_L1E_iAMPA_tauD + 1/2*(1+tanh(L1E_v_last/10)).*((1-L1I_L1E_iAMPA_s_last)/p.L1I_L1E_iAMPA_tauR);
  L1E_L1I_iGABA_s_k1 = -L1E_L1I_iGABA_s_last./p.L1E_L1I_iGABA_tauGABA + ((1-L1E_L1I_iGABA_s_last)/p.L1E_L1I_iGABA_tauGABAr).*(1+tanh(L1I_v_last/10));
  L2I_L1I_iGABA_s_k1 = -L2I_L1I_iGABA_s_last./p.L2I_L1I_iGABA_tauGABA + ((1-L2I_L1I_iGABA_s_last)/p.L2I_L1I_iGABA_tauGABAr).*(1+tanh(L1I_v_last/10));
  L1I_L2I_iGABA_s_k1 = -L1I_L2I_iGABA_s_last./p.L1I_L2I_iGABA_tauGABA + ((1-L1I_L2I_iGABA_s_last)/p.L1I_L2I_iGABA_tauGABAr).*(1+tanh(L2I_v_last/10));
  L2E_L1E_iAMPA_s_k1 = -L2E_L1E_iAMPA_s_last./p.L2E_L1E_iAMPA_tauD + 1/2*(1+tanh(L1E_v_last/10)).*((1-L2E_L1E_iAMPA_s_last)/p.L2E_L1E_iAMPA_tauR);
  L1E_L2E_iAMPA_s_k1 = -L1E_L2E_iAMPA_s_last./p.L1E_L2E_iAMPA_tauD + 1/2*(1+tanh(L2E_v_last/10)).*((1-L1E_L2E_iAMPA_s_last)/p.L1E_L2E_iAMPA_tauR);
  L2I_L2E_iAMPA_s_k1 = -L2I_L2E_iAMPA_s_last./p.L2I_L2E_iAMPA_tauD + 1/2*(1+tanh(L2E_v_last/10)).*((1-L2I_L2E_iAMPA_s_last)/p.L2I_L2E_iAMPA_tauR);
  L2E_L2I_iGABA_s_k1 = -L2E_L2I_iGABA_s_last./p.L2E_L2I_iGABA_tauGABA + ((1-L2E_L2I_iGABA_s_last)/p.L2E_L2I_iGABA_tauGABAr).*(1+tanh(L2I_v_last/10));
  L3E_L2E_iAMPA_s_k1 = -L3E_L2E_iAMPA_s_last./p.L3E_L2E_iAMPA_tauD + 1/2*(1+tanh(L2E_v_last/10)).*((1-L3E_L2E_iAMPA_s_last)/p.L3E_L2E_iAMPA_tauR);
  L3I_L2I_iGABA_s_k1 = -L3I_L2I_iGABA_s_last./p.L3I_L2I_iGABA_tauGABA + ((1-L3I_L2I_iGABA_s_last)/p.L3I_L2I_iGABA_tauGABAr).*(1+tanh(L2I_v_last/10));
  L2E_L3E_iAMPA_s_k1 = -L2E_L3E_iAMPA_s_last./p.L2E_L3E_iAMPA_tauD + 1/2*(1+tanh(L3E_v_last/10)).*((1-L2E_L3E_iAMPA_s_last)/p.L2E_L3E_iAMPA_tauR);
  L2I_L3I_iGABA_s_k1 = -L2I_L3I_iGABA_s_last./p.L2I_L3I_iGABA_tauGABA + ((1-L2I_L3I_iGABA_s_last)/p.L2I_L3I_iGABA_tauGABAr).*(1+tanh(L3I_v_last/10));
  L3I_L3E_iAMPA_s_k1 = -L3I_L3E_iAMPA_s_last./p.L3I_L3E_iAMPA_tauD + 1/2*(1+tanh(L3E_v_last/10)).*((1-L3I_L3E_iAMPA_s_last)/p.L3I_L3E_iAMPA_tauR);
  L3E_L3I_iGABA_s_k1 = -L3E_L3I_iGABA_s_last./p.L3E_L3I_iGABA_tauGABA + ((1-L3E_L3I_iGABA_s_last)/p.L3E_L3I_iGABA_tauGABAr).*(1+tanh(L3I_v_last/10));
  L2E_Input1_iAMPA_s_k1 = -L2E_Input1_iAMPA_s_last./p.L2E_Input1_iAMPA_tauD + 1/2*(1+tanh(X_pre/10)).*((1-L2E_Input1_iAMPA_s_last)/p.L2E_Input1_iAMPA_tauR);
  L2I_Input2_iAMPA_s_k1 = -L2I_Input2_iAMPA_s_last./p.L2I_Input2_iAMPA_tauD + 1/2*(1+tanh(X_pre/10)).*((1-L2I_Input2_iAMPA_s_last)/p.L2I_Input2_iAMPA_tauR);

  % ------------------------------------------------------------
  % Update state variables:
  % ------------------------------------------------------------
  L1I_v_last = L1I_v_last+dt*L1I_v_k1;
  L1I_iNa_m_last = L1I_iNa_m_last+dt*L1I_iNa_m_k1;
  L1I_iNa_h_last = L1I_iNa_h_last+dt*L1I_iNa_h_k1;
  L1I_iK_n_last = L1I_iK_n_last+dt*L1I_iK_n_k1;
  L2I_v_last = L2I_v_last+dt*L2I_v_k1;
  L2I_iNa_m_last = L2I_iNa_m_last+dt*L2I_iNa_m_k1;
  L2I_iNa_h_last = L2I_iNa_h_last+dt*L2I_iNa_h_k1;
  L2I_iK_n_last = L2I_iK_n_last+dt*L2I_iK_n_k1;
  L3I_v_last = L3I_v_last+dt*L3I_v_k1;
  L3I_iNa_m_last = L3I_iNa_m_last+dt*L3I_iNa_m_k1;
  L3I_iNa_h_last = L3I_iNa_h_last+dt*L3I_iNa_h_k1;
  L3I_iK_n_last = L3I_iK_n_last+dt*L3I_iK_n_k1;
  L1E_v_last = L1E_v_last+dt*L1E_v_k1;
  L1E_iNa_m_last = L1E_iNa_m_last+dt*L1E_iNa_m_k1;
  L1E_iNa_h_last = L1E_iNa_h_last+dt*L1E_iNa_h_k1;
  L1E_iK_n_last = L1E_iK_n_last+dt*L1E_iK_n_k1;
  L2E_v_last = L2E_v_last+dt*L2E_v_k1;
  L2E_iNa_m_last = L2E_iNa_m_last+dt*L2E_iNa_m_k1;
  L2E_iNa_h_last = L2E_iNa_h_last+dt*L2E_iNa_h_k1;
  L2E_iK_n_last = L2E_iK_n_last+dt*L2E_iK_n_k1;
  L3E_v_last = L3E_v_last+dt*L3E_v_k1;
  L3E_iNa_m_last = L3E_iNa_m_last+dt*L3E_iNa_m_k1;
  L3E_iNa_h_last = L3E_iNa_h_last+dt*L3E_iNa_h_k1;
  L3E_iK_n_last = L3E_iK_n_last+dt*L3E_iK_n_k1;
  Input1_iNa_m_last = Input1_iNa_m_last+dt*Input1_iNa_m_k1;
  Input1_iNa_h_last = Input1_iNa_h_last+dt*Input1_iNa_h_k1;
  Input1_iK_n_last = Input1_iK_n_last+dt*Input1_iK_n_k1;
  Input2_iNa_m_last = Input2_iNa_m_last+dt*Input2_iNa_m_k1;
  Input2_iNa_h_last = Input2_iNa_h_last+dt*Input2_iNa_h_k1;
  Input2_iK_n_last = Input2_iK_n_last+dt*Input2_iK_n_k1;
  L1I_L1E_iAMPA_s_last = L1I_L1E_iAMPA_s_last+dt*L1I_L1E_iAMPA_s_k1;
  L1E_L1I_iGABA_s_last = L1E_L1I_iGABA_s_last+dt*L1E_L1I_iGABA_s_k1;
  L2I_L1I_iGABA_s_last = L2I_L1I_iGABA_s_last+dt*L2I_L1I_iGABA_s_k1;
  L1I_L2I_iGABA_s_last = L1I_L2I_iGABA_s_last+dt*L1I_L2I_iGABA_s_k1;
  L2E_L1E_iAMPA_s_last = L2E_L1E_iAMPA_s_last+dt*L2E_L1E_iAMPA_s_k1;
  L1E_L2E_iAMPA_s_last = L1E_L2E_iAMPA_s_last+dt*L1E_L2E_iAMPA_s_k1;
  L2I_L2E_iAMPA_s_last = L2I_L2E_iAMPA_s_last+dt*L2I_L2E_iAMPA_s_k1;
  L2E_L2I_iGABA_s_last = L2E_L2I_iGABA_s_last+dt*L2E_L2I_iGABA_s_k1;
  L3E_L2E_iAMPA_s_last = L3E_L2E_iAMPA_s_last+dt*L3E_L2E_iAMPA_s_k1;
  L3I_L2I_iGABA_s_last = L3I_L2I_iGABA_s_last+dt*L3I_L2I_iGABA_s_k1;
  L2E_L3E_iAMPA_s_last = L2E_L3E_iAMPA_s_last+dt*L2E_L3E_iAMPA_s_k1;
  L2I_L3I_iGABA_s_last = L2I_L3I_iGABA_s_last+dt*L2I_L3I_iGABA_s_k1;
  L3I_L3E_iAMPA_s_last = L3I_L3E_iAMPA_s_last+dt*L3I_L3E_iAMPA_s_k1;
  L3E_L3I_iGABA_s_last = L3E_L3I_iGABA_s_last+dt*L3E_L3I_iGABA_s_k1;
  L2E_Input1_iAMPA_s_last = L2E_Input1_iAMPA_s_last+dt*L2E_Input1_iAMPA_s_k1;
  L2I_Input2_iAMPA_s_last = L2I_Input2_iAMPA_s_last+dt*L2I_Input2_iAMPA_s_k1;

  % ------------------------------------------------------------
  % Conditional actions:
  % ------------------------------------------------------------
  conditional_test=any(any(L3E_v_last>=0&L3E_v(n-1,:)<0));
  conditional_indx=(any(L3E_v_last>=0&L3E_v(n-1,:)<0));
  if conditional_test, L3E_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); L3E_tspike(L3E_buffer_index(i),i)=t; L3E_buffer_index(i)=mod(-1+(L3E_buffer_index(i)+1),2)+1; end; end
  conditional_test=any(any(L2E_v_last>=0&L2E_v(n-1,:)<0));
  conditional_indx=(any(L2E_v_last>=0&L2E_v(n-1,:)<0));
  if conditional_test, L2E_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); L2E_tspike(L2E_buffer_index(i),i)=t; L2E_buffer_index(i)=mod(-1+(L2E_buffer_index(i)+1),2)+1; end; end
  conditional_test=any(any(L1E_v_last>=0&L1E_v(n-1,:)<0));
  conditional_indx=(any(L1E_v_last>=0&L1E_v(n-1,:)<0));
  if conditional_test, L1E_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); L1E_tspike(L1E_buffer_index(i),i)=t; L1E_buffer_index(i)=mod(-1+(L1E_buffer_index(i)+1),2)+1; end; end
  conditional_test=any(any(L3I_v_last>=0&L3I_v(n-1,:)<0));
  conditional_indx=(any(L3I_v_last>=0&L3I_v(n-1,:)<0));
  if conditional_test, L3I_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); L3I_tspike(L3I_buffer_index(i),i)=t; L3I_buffer_index(i)=mod(-1+(L3I_buffer_index(i)+1),2)+1; end; end
  conditional_test=any(any(L2I_v_last>=0&L2I_v(n-1,:)<0));
  conditional_indx=(any(L2I_v_last>=0&L2I_v(n-1,:)<0));
  if conditional_test, L2I_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); L2I_tspike(L2I_buffer_index(i),i)=t; L2I_buffer_index(i)=mod(-1+(L2I_buffer_index(i)+1),2)+1; end; end
  conditional_test=any(any(L1I_v_last>=0&L1I_v(n-1,:)<0));
  conditional_indx=(any(L1I_v_last>=0&L1I_v(n-1,:)<0));
  if conditional_test, L1I_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); L1I_tspike(L1I_buffer_index(i),i)=t; L1I_buffer_index(i)=mod(-1+(L1I_buffer_index(i)+1),2)+1; end; end

  if mod(k,downsample_factor)==0 % store this time point

  % ------------------------------------------------------------
  % Store state variables:
  % ------------------------------------------------------------
    L1I_v(n,:) = L1I_v_last;
    L1I_iNa_m(n,:) = L1I_iNa_m_last;
    L1I_iNa_h(n,:) = L1I_iNa_h_last;
    L1I_iK_n(n,:) = L1I_iK_n_last;
    L2I_v(n,:) = L2I_v_last;
    L2I_iNa_m(n,:) = L2I_iNa_m_last;
    L2I_iNa_h(n,:) = L2I_iNa_h_last;
    L2I_iK_n(n,:) = L2I_iK_n_last;
    L3I_v(n,:) = L3I_v_last;
    L3I_iNa_m(n,:) = L3I_iNa_m_last;
    L3I_iNa_h(n,:) = L3I_iNa_h_last;
    L3I_iK_n(n,:) = L3I_iK_n_last;
    L1E_v(n,:) = L1E_v_last;
    L1E_iNa_m(n,:) = L1E_iNa_m_last;
    L1E_iNa_h(n,:) = L1E_iNa_h_last;
    L1E_iK_n(n,:) = L1E_iK_n_last;
    L2E_v(n,:) = L2E_v_last;
    L2E_iNa_m(n,:) = L2E_iNa_m_last;
    L2E_iNa_h(n,:) = L2E_iNa_h_last;
    L2E_iK_n(n,:) = L2E_iK_n_last;
    L3E_v(n,:) = L3E_v_last;
    L3E_iNa_m(n,:) = L3E_iNa_m_last;
    L3E_iNa_h(n,:) = L3E_iNa_h_last;
    L3E_iK_n(n,:) = L3E_iK_n_last;
    Input1_iNa_m(n) = Input1_iNa_m_last;
    Input1_iNa_h(n) = Input1_iNa_h_last;
    Input1_iK_n(n) = Input1_iK_n_last;
    Input2_iNa_m(n) = Input2_iNa_m_last;
    Input2_iNa_h(n) = Input2_iNa_h_last;
    Input2_iK_n(n) = Input2_iK_n_last;
    L1I_L1E_iAMPA_s(n,:) = L1I_L1E_iAMPA_s_last;
    L1E_L1I_iGABA_s(n,:) = L1E_L1I_iGABA_s_last;
    L2I_L1I_iGABA_s(n,:) = L2I_L1I_iGABA_s_last;
    L1I_L2I_iGABA_s(n,:) = L1I_L2I_iGABA_s_last;
    L2E_L1E_iAMPA_s(n,:) = L2E_L1E_iAMPA_s_last;
    L1E_L2E_iAMPA_s(n,:) = L1E_L2E_iAMPA_s_last;
    L2I_L2E_iAMPA_s(n,:) = L2I_L2E_iAMPA_s_last;
    L2E_L2I_iGABA_s(n,:) = L2E_L2I_iGABA_s_last;
    L3E_L2E_iAMPA_s(n,:) = L3E_L2E_iAMPA_s_last;
    L3I_L2I_iGABA_s(n,:) = L3I_L2I_iGABA_s_last;
    L2E_L3E_iAMPA_s(n,:) = L2E_L3E_iAMPA_s_last;
    L2I_L3I_iGABA_s(n,:) = L2I_L3I_iGABA_s_last;
    L3I_L3E_iAMPA_s(n,:) = L3I_L3E_iAMPA_s_last;
    L3E_L3I_iGABA_s(n,:) = L3E_L3I_iGABA_s_last;
    L2E_Input1_iAMPA_s(n) = L2E_Input1_iAMPA_s_last;
    L2I_Input2_iAMPA_s(n) = L2I_Input2_iAMPA_s_last;

  % ------------------------------------------------------------
  % Update monitors:
  % ------------------------------------------------------------
  Input1_v_spikes(n,:)=0;
  Input2_v_spikes(n,:)=0;
  L1E_L1I_iGABA_IGABA(n,:)=(p.L1E_L1I_iGABA_gGABA.*(L1E_L1I_iGABA_s(n,:)*L1E_L1I_iGABA_netcon).*(L1E_v(n,:)-p.L1E_L1I_iGABA_EGABA));
  L1E_L2E_iAMPA_IAMPA(n,:)=-p.L1E_L2E_iAMPA_gAMPA.*(L1E_L2E_iAMPA_s(n,:)*L1E_L2E_iAMPA_netcon).*(L1E_v(n,:)-p.L1E_L2E_iAMPA_EAMPA);
  L1I_L1E_iAMPA_IAMPA(n,:)=-p.L1I_L1E_iAMPA_gAMPA.*(L1I_L1E_iAMPA_s(n,:)*L1I_L1E_iAMPA_netcon).*(L1I_v(n,:)-p.L1I_L1E_iAMPA_EAMPA);
  L1I_L2I_iGABA_IGABA(n,:)=(p.L1I_L2I_iGABA_gGABA.*(L1I_L2I_iGABA_s(n,:)*L1I_L2I_iGABA_netcon).*(L1I_v(n,:)-p.L1I_L2I_iGABA_EGABA));
  L2E_Input1_iAMPA_IAMPA(n,:)=-p.L2E_Input1_iAMPA_gAMPA.*(L2E_Input1_iAMPA_s(n)*L2E_Input1_iAMPA_netcon).*(L2E_v(n,:)-p.L2E_Input1_iAMPA_EAMPA);
  L2E_L1E_iAMPA_IAMPA(n,:)=-p.L2E_L1E_iAMPA_gAMPA.*(L2E_L1E_iAMPA_s(n,:)*L2E_L1E_iAMPA_netcon).*(L2E_v(n,:)-p.L2E_L1E_iAMPA_EAMPA);
  L2E_L2I_iGABA_IGABA(n,:)=(p.L2E_L2I_iGABA_gGABA.*(L2E_L2I_iGABA_s(n,:)*L2E_L2I_iGABA_netcon).*(L2E_v(n,:)-p.L2E_L2I_iGABA_EGABA));
  L2E_L3E_iAMPA_IAMPA(n,:)=-p.L2E_L3E_iAMPA_gAMPA.*(L2E_L3E_iAMPA_s(n,:)*L2E_L3E_iAMPA_netcon).*(L2E_v(n,:)-p.L2E_L3E_iAMPA_EAMPA);
  L2I_Input2_iAMPA_IAMPA(n,:)=-p.L2I_Input2_iAMPA_gAMPA.*(L2I_Input2_iAMPA_s(n)*L2I_Input2_iAMPA_netcon).*(L2I_v(n,:)-p.L2I_Input2_iAMPA_EAMPA);
  L2I_L1I_iGABA_IGABA(n,:)=(p.L2I_L1I_iGABA_gGABA.*(L2I_L1I_iGABA_s(n,:)*L2I_L1I_iGABA_netcon).*(L2I_v(n,:)-p.L2I_L1I_iGABA_EGABA));
  L2I_L2E_iAMPA_IAMPA(n,:)=-p.L2I_L2E_iAMPA_gAMPA.*(L2I_L2E_iAMPA_s(n,:)*L2I_L2E_iAMPA_netcon).*(L2I_v(n,:)-p.L2I_L2E_iAMPA_EAMPA);
  L2I_L3I_iGABA_IGABA(n,:)=(p.L2I_L3I_iGABA_gGABA.*(L2I_L3I_iGABA_s(n,:)*L2I_L3I_iGABA_netcon).*(L2I_v(n,:)-p.L2I_L3I_iGABA_EGABA));
  L3E_L2E_iAMPA_IAMPA(n,:)=-p.L3E_L2E_iAMPA_gAMPA.*(L3E_L2E_iAMPA_s(n,:)*L3E_L2E_iAMPA_netcon).*(L3E_v(n,:)-p.L3E_L2E_iAMPA_EAMPA);
  L3E_L3I_iGABA_IGABA(n,:)=(p.L3E_L3I_iGABA_gGABA.*(L3E_L3I_iGABA_s(n,:)*L3E_L3I_iGABA_netcon).*(L3E_v(n,:)-p.L3E_L3I_iGABA_EGABA));
