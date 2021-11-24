function [T,L1_v,L1_iNa_m,L1_iNa_h,L1_iK_n,L2_v,L2_iNa_m,L2_iNa_h,L2_iK_n,L3_v,L3_iNa_m,L3_iNa_h,L3_iK_n,L4_v,L4_iNa_m,L4_iNa_h,L4_iK_n,L5_v,L5_iNa_m,L5_iNa_h,L5_iK_n,L2_L1_iGABAa_s,L2_L5_iAMPA_s,L3_L2_iAMPA_s,L2_L3_iAMPA_s,L1_L4_iGABA_s,L1_L3_iAMPA_s,L1_L3_iAMPA_IAMPA,L1_L4_iGABA_IGABA,L2_L1_iGABAa_IGABAa,L2_L3_iAMPA_IAMPA,L2_L5_iAMPA_IAMPA,L3_L2_iAMPA_IAMPA,L2_L1_iGABAa_netcon,L2_L5_iAMPA_netcon,L3_L2_iAMPA_netcon,L2_L3_iAMPA_netcon,L1_L4_iGABA_netcon,L1_L3_iAMPA_netcon]=solve_ode

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
L2_L1_iGABAa_netcon = ones(p.L1_Npop,p.L2_Npop);
L2_L5_iAMPA_netcon = ones(p.L5_Npop,p.L2_Npop);
L3_L2_iAMPA_netcon = ones(p.L2_Npop,p.L3_Npop);
L2_L3_iAMPA_netcon = ones(p.L3_Npop,p.L2_Npop);
L1_L4_iGABA_netcon = ones(p.L4_Npop,p.L1_Npop);
L1_L3_iAMPA_netcon = ones(p.L3_Npop,p.L1_Npop);

% ------------------------------------------------------------
% Initial conditions:
% ------------------------------------------------------------
t=0; k=1;

% STATE_VARIABLES:
L1_v = zeros(nsamp,p.L1_Npop);
  L1_v(1,:) = zeros(1,p.L1_Npop);
L1_iNa_m = zeros(nsamp,p.L1_Npop);
  L1_iNa_m(1,:) = p.L1_iNa_m_IC+p.L1_iNa_IC_noise*rand(1,p.L1_Npop);
L1_iNa_h = zeros(nsamp,p.L1_Npop);
  L1_iNa_h(1,:) = p.L1_iNa_h_IC+p.L1_iNa_IC_noise*rand(1,p.L1_Npop);
L1_iK_n = zeros(nsamp,p.L1_Npop);
  L1_iK_n(1,:) = p.L1_iK_n_IC+p.L1_iK_IC_noise*rand(1,p.L1_Npop);
L2_v = zeros(nsamp,p.L2_Npop);
  L2_v(1,:) = zeros(1,p.L2_Npop);
L2_iNa_m = zeros(nsamp,p.L2_Npop);
  L2_iNa_m(1,:) = p.L2_iNa_m_IC+p.L2_iNa_IC_noise*rand(1,p.L2_Npop);
L2_iNa_h = zeros(nsamp,p.L2_Npop);
  L2_iNa_h(1,:) = p.L2_iNa_h_IC+p.L2_iNa_IC_noise*rand(1,p.L2_Npop);
L2_iK_n = zeros(nsamp,p.L2_Npop);
  L2_iK_n(1,:) = p.L2_iK_n_IC+p.L2_iK_IC_noise*rand(1,p.L2_Npop);
L3_v = zeros(nsamp,p.L3_Npop);
  L3_v(1,:) = zeros(1,p.L3_Npop);
L3_iNa_m = zeros(nsamp,p.L3_Npop);
  L3_iNa_m(1,:) = p.L3_iNa_m_IC+p.L3_iNa_IC_noise*rand(1,p.L3_Npop);
L3_iNa_h = zeros(nsamp,p.L3_Npop);
  L3_iNa_h(1,:) = p.L3_iNa_h_IC+p.L3_iNa_IC_noise*rand(1,p.L3_Npop);
L3_iK_n = zeros(nsamp,p.L3_Npop);
  L3_iK_n(1,:) = p.L3_iK_n_IC+p.L3_iK_IC_noise*rand(1,p.L3_Npop);
L4_v = zeros(nsamp,p.L4_Npop);
  L4_v(1,:) = zeros(1,p.L4_Npop);
L4_iNa_m = zeros(nsamp,p.L4_Npop);
  L4_iNa_m(1,:) = p.L4_iNa_m_IC+p.L4_iNa_IC_noise*rand(1,p.L4_Npop);
L4_iNa_h = zeros(nsamp,p.L4_Npop);
  L4_iNa_h(1,:) = p.L4_iNa_h_IC+p.L4_iNa_IC_noise*rand(1,p.L4_Npop);
L4_iK_n = zeros(nsamp,p.L4_Npop);
  L4_iK_n(1,:) = p.L4_iK_n_IC+p.L4_iK_IC_noise*rand(1,p.L4_Npop);
L5_v = zeros(nsamp,p.L5_Npop);
  L5_v(1,:) = zeros(1,p.L5_Npop);
L5_iNa_m = zeros(nsamp,p.L5_Npop);
  L5_iNa_m(1,:) = p.L5_iNa_m_IC+p.L5_iNa_IC_noise*rand(1,p.L5_Npop);
L5_iNa_h = zeros(nsamp,p.L5_Npop);
  L5_iNa_h(1,:) = p.L5_iNa_h_IC+p.L5_iNa_IC_noise*rand(1,p.L5_Npop);
L5_iK_n = zeros(nsamp,p.L5_Npop);
  L5_iK_n(1,:) = p.L5_iK_n_IC+p.L5_iK_IC_noise*rand(1,p.L5_Npop);
L2_L1_iGABAa_s = zeros(nsamp,p.L1_Npop);
  L2_L1_iGABAa_s(1,:) =  p.L2_L1_iGABAa_IC+p.L2_L1_iGABAa_IC_noise.*rand(1,p.L1_Npop);
L2_L5_iAMPA_s = zeros(nsamp,p.L5_Npop);
  L2_L5_iAMPA_s(1,:) =  p.L2_L5_iAMPA_IC+p.L2_L5_iAMPA_IC_noise.*rand(1,p.L5_Npop);
L3_L2_iAMPA_s = zeros(nsamp,p.L2_Npop);
  L3_L2_iAMPA_s(1,:) =  p.L3_L2_iAMPA_IC+p.L3_L2_iAMPA_IC_noise.*rand(1,p.L2_Npop);
L2_L3_iAMPA_s = zeros(nsamp,p.L3_Npop);
  L2_L3_iAMPA_s(1,:) =  p.L2_L3_iAMPA_IC+p.L2_L3_iAMPA_IC_noise.*rand(1,p.L3_Npop);
L1_L4_iGABA_s = zeros(nsamp,p.L4_Npop);
  L1_L4_iGABA_s(1,:) =  p.L1_L4_iGABA_IC+p.L1_L4_iGABA_IC_noise.*rand(1,p.L4_Npop);
L1_L3_iAMPA_s = zeros(nsamp,p.L3_Npop);
  L1_L3_iAMPA_s(1,:) =  p.L1_L3_iAMPA_IC+p.L1_L3_iAMPA_IC_noise.*rand(1,p.L3_Npop);

% MONITORS:
L1_L3_iAMPA_IAMPA = zeros(nsamp,p.L1_Npop);
  L1_L3_iAMPA_IAMPA(1,:)=-p.L1_L3_iAMPA_gAMPA.*(L1_L3_iAMPA_s(1,:)*L1_L3_iAMPA_netcon).*(L1_v(1,:)-p.L1_L3_iAMPA_EAMPA);
L1_L4_iGABA_IGABA = zeros(nsamp,p.L1_Npop);
  L1_L4_iGABA_IGABA(1,:)=(p.L1_L4_iGABA_gGABA.*(L1_L4_iGABA_s(1,:)*L1_L4_iGABA_netcon).*(L1_v(1,:)-p.L1_L4_iGABA_EGABA));
L2_L1_iGABAa_IGABAa = zeros(nsamp,p.L2_Npop);
  L2_L1_iGABAa_IGABAa(1,:)=-p.L2_L1_iGABAa_gGABAa.*(L2_L1_iGABAa_s(1,:)*L2_L1_iGABAa_netcon).*(L2_v(1,:)-p.L2_L1_iGABAa_EGABAa);
L2_L3_iAMPA_IAMPA = zeros(nsamp,p.L2_Npop);
  L2_L3_iAMPA_IAMPA(1,:)=-p.L2_L3_iAMPA_gAMPA.*(L2_L3_iAMPA_s(1,:)*L2_L3_iAMPA_netcon).*(L2_v(1,:)-p.L2_L3_iAMPA_EAMPA);
L2_L5_iAMPA_IAMPA = zeros(nsamp,p.L2_Npop);
  L2_L5_iAMPA_IAMPA(1,:)=-p.L2_L5_iAMPA_gAMPA.*(L2_L5_iAMPA_s(1,:)*L2_L5_iAMPA_netcon).*(L2_v(1,:)-p.L2_L5_iAMPA_EAMPA);
L3_L2_iAMPA_IAMPA = zeros(nsamp,p.L3_Npop);
  L3_L2_iAMPA_IAMPA(1,:)=-p.L3_L2_iAMPA_gAMPA.*(L3_L2_iAMPA_s(1,:)*L3_L2_iAMPA_netcon).*(L3_v(1,:)-p.L3_L2_iAMPA_EAMPA);

% ###########################################################
% Numerical integration:
% ###########################################################
n=2;
for k=2:ntime
  t=T(k-1);
  L1_v_k1 =p.L1_Iapp+((((-p.L1_iNa_gNa.*L1_iNa_m(n-1,:).^3.*L1_iNa_h(n-1,:).*(L1_v(n-1,:)-p.L1_iNa_ENa))))+((((-p.L1_iK_gK.*L1_iK_n(n-1,:).^4.*(L1_v(n-1,:)-p.L1_iK_EK))))+((-(((p.L1_L4_iGABA_gGABA.*(L1_L4_iGABA_s(n-1,:)*L1_L4_iGABA_netcon).*(L1_v(n-1,:)-p.L1_L4_iGABA_EGABA)))))+((((-p.L1_L3_iAMPA_gAMPA.*(L1_L3_iAMPA_s(n-1,:)*L1_L3_iAMPA_netcon).*(L1_v(n-1,:)-p.L1_L3_iAMPA_EAMPA))))))))+p.L1_noise*randn(1,p.L1_Npop);
  L1_iNa_m_k1 = (((2.5-.1*(L1_v(n-1,:)+65))./(exp(2.5-.1*(L1_v(n-1,:)+65))-1))).*(1-L1_iNa_m(n-1,:))-((4*exp(-(L1_v(n-1,:)+65)/18))).*L1_iNa_m(n-1,:);
  L1_iNa_h_k1 = ((.07*exp(-(L1_v(n-1,:)+65)/20))).*(1-L1_iNa_h(n-1,:))-((1./(exp(3-.1*(L1_v(n-1,:)+65))+1))).*L1_iNa_h(n-1,:);
  L1_iK_n_k1 = (((.1-.01*(L1_v(n-1,:)+65))./(exp(1-.1*(L1_v(n-1,:)+65))-1))).*(1-L1_iK_n(n-1,:))-((.125*exp(-(L1_v(n-1,:)+65)/80))).*L1_iK_n(n-1,:);
  L2_v_k1 =p.L2_Iapp+((((-p.L2_iNa_gNa.*L2_iNa_m(n-1,:).^3.*L2_iNa_h(n-1,:).*(L2_v(n-1,:)-p.L2_iNa_ENa))))+((((-p.L2_iK_gK.*L2_iK_n(n-1,:).^4.*(L2_v(n-1,:)-p.L2_iK_EK))))+((((-p.L2_L1_iGABAa_gGABAa.*(L2_L1_iGABAa_s(n-1,:)*L2_L1_iGABAa_netcon).*(L2_v(n-1,:)-p.L2_L1_iGABAa_EGABAa))))+((((-p.L2_L5_iAMPA_gAMPA.*(L2_L5_iAMPA_s(n-1,:)*L2_L5_iAMPA_netcon).*(L2_v(n-1,:)-p.L2_L5_iAMPA_EAMPA))))+((((-p.L2_L3_iAMPA_gAMPA.*(L2_L3_iAMPA_s(n-1,:)*L2_L3_iAMPA_netcon).*(L2_v(n-1,:)-p.L2_L3_iAMPA_EAMPA)))))))))+p.L2_noise*randn(1,p.L2_Npop);
  L2_iNa_m_k1 = (((2.5-.1*(L2_v(n-1,:)+65))./(exp(2.5-.1*(L2_v(n-1,:)+65))-1))).*(1-L2_iNa_m(n-1,:))-((4*exp(-(L2_v(n-1,:)+65)/18))).*L2_iNa_m(n-1,:);
  L2_iNa_h_k1 = ((.07*exp(-(L2_v(n-1,:)+65)/20))).*(1-L2_iNa_h(n-1,:))-((1./(exp(3-.1*(L2_v(n-1,:)+65))+1))).*L2_iNa_h(n-1,:);
  L2_iK_n_k1 = (((.1-.01*(L2_v(n-1,:)+65))./(exp(1-.1*(L2_v(n-1,:)+65))-1))).*(1-L2_iK_n(n-1,:))-((.125*exp(-(L2_v(n-1,:)+65)/80))).*L2_iK_n(n-1,:);
  L3_v_k1 =p.L3_Iapp+((((-p.L3_iNa_gNa.*L3_iNa_m(n-1,:).^3.*L3_iNa_h(n-1,:).*(L3_v(n-1,:)-p.L3_iNa_ENa))))+((((-p.L3_iK_gK.*L3_iK_n(n-1,:).^4.*(L3_v(n-1,:)-p.L3_iK_EK))))+((((-p.L3_L2_iAMPA_gAMPA.*(L3_L2_iAMPA_s(n-1,:)*L3_L2_iAMPA_netcon).*(L3_v(n-1,:)-p.L3_L2_iAMPA_EAMPA)))))))+p.L3_noise*randn(1,p.L3_Npop);
  L3_iNa_m_k1 = (((2.5-.1*(L3_v(n-1,:)+65))./(exp(2.5-.1*(L3_v(n-1,:)+65))-1))).*(1-L3_iNa_m(n-1,:))-((4*exp(-(L3_v(n-1,:)+65)/18))).*L3_iNa_m(n-1,:);
  L3_iNa_h_k1 = ((.07*exp(-(L3_v(n-1,:)+65)/20))).*(1-L3_iNa_h(n-1,:))-((1./(exp(3-.1*(L3_v(n-1,:)+65))+1))).*L3_iNa_h(n-1,:);
  L3_iK_n_k1 = (((.1-.01*(L3_v(n-1,:)+65))./(exp(1-.1*(L3_v(n-1,:)+65))-1))).*(1-L3_iK_n(n-1,:))-((.125*exp(-(L3_v(n-1,:)+65)/80))).*L3_iK_n(n-1,:);
  L4_v_k1 =0.5*p.L4_Iapp+0.5*((((-p.L4_iNa_gNa.*L4_iNa_m(n-1,:).^3.*L4_iNa_h(n-1,:).*(L4_v(n-1,:)-p.L4_iNa_ENa))))+((((-p.L4_iK_gK.*L4_iK_n(n-1,:).^4.*(L4_v(n-1,:)-p.L4_iK_EK))))))+p.L4_noise*randn(1,p.L4_Npop);
  L4_iNa_m_k1 = (((2.5-.1*(L4_v(n-1,:)+65))./(exp(2.5-.1*(L4_v(n-1,:)+65))-1))).*(1-L4_iNa_m(n-1,:))-((4*exp(-(L4_v(n-1,:)+65)/18))).*L4_iNa_m(n-1,:);
  L4_iNa_h_k1 = ((.07*exp(-(L4_v(n-1,:)+65)/20))).*(1-L4_iNa_h(n-1,:))-((1./(exp(3-.1*(L4_v(n-1,:)+65))+1))).*L4_iNa_h(n-1,:);
  L4_iK_n_k1 = (((.1-.01*(L4_v(n-1,:)+65))./(exp(1-.1*(L4_v(n-1,:)+65))-1))).*(1-L4_iK_n(n-1,:))-((.125*exp(-(L4_v(n-1,:)+65)/80))).*L4_iK_n(n-1,:);
  L5_v_k1 =0.5*p.L5_Iapp+0.5*((((-p.L5_iNa_gNa.*L5_iNa_m(n-1,:).^3.*L5_iNa_h(n-1,:).*(L5_v(n-1,:)-p.L5_iNa_ENa))))+((((-p.L5_iK_gK.*L5_iK_n(n-1,:).^4.*(L5_v(n-1,:)-p.L5_iK_EK))))))+p.L5_noise*randn(1,p.L5_Npop);
  L5_iNa_m_k1 = (((2.5-.1*(L5_v(n-1,:)+65))./(exp(2.5-.1*(L5_v(n-1,:)+65))-1))).*(1-L5_iNa_m(n-1,:))-((4*exp(-(L5_v(n-1,:)+65)/18))).*L5_iNa_m(n-1,:);
  L5_iNa_h_k1 = ((.07*exp(-(L5_v(n-1,:)+65)/20))).*(1-L5_iNa_h(n-1,:))-((1./(exp(3-.1*(L5_v(n-1,:)+65))+1))).*L5_iNa_h(n-1,:);
  L5_iK_n_k1 = (((.1-.01*(L5_v(n-1,:)+65))./(exp(1-.1*(L5_v(n-1,:)+65))-1))).*(1-L5_iK_n(n-1,:))-((.125*exp(-(L5_v(n-1,:)+65)/80))).*L5_iK_n(n-1,:);
  L2_L1_iGABAa_s_k1 = -L2_L1_iGABAa_s(n-1,:)./p.L2_L1_iGABAa_tauD + 1/2*(1+tanh(L1_v(n-1,:)/10)).*((1-L2_L1_iGABAa_s(n-1,:))/p.L2_L1_iGABAa_tauR);
  L2_L5_iAMPA_s_k1 = -L2_L5_iAMPA_s(n-1,:)./p.L2_L5_iAMPA_tauD + 1/2*(1+tanh(L5_v(n-1,:)/10)).*((1-L2_L5_iAMPA_s(n-1,:))/p.L2_L5_iAMPA_tauR);
  L3_L2_iAMPA_s_k1 = -L3_L2_iAMPA_s(n-1,:)./p.L3_L2_iAMPA_tauD + 1/2*(1+tanh(L2_v(n-1,:)/10)).*((1-L3_L2_iAMPA_s(n-1,:))/p.L3_L2_iAMPA_tauR);
  L2_L3_iAMPA_s_k1 = -L2_L3_iAMPA_s(n-1,:)./p.L2_L3_iAMPA_tauD + 1/2*(1+tanh(L3_v(n-1,:)/10)).*((1-L2_L3_iAMPA_s(n-1,:))/p.L2_L3_iAMPA_tauR);
  L1_L4_iGABA_s_k1 = -L1_L4_iGABA_s(n-1,:)./p.L1_L4_iGABA_tauGABA + ((1-L1_L4_iGABA_s(n-1,:))/p.L1_L4_iGABA_tauGABAr).*(1+tanh(L4_v(n-1,:)/10));
  L1_L3_iAMPA_s_k1 = -L1_L3_iAMPA_s(n-1,:)./p.L1_L3_iAMPA_tauD + 1/2*(1+tanh(L3_v(n-1,:)/10)).*((1-L1_L3_iAMPA_s(n-1,:))/p.L1_L3_iAMPA_tauR);

  t = t + .5*dt;
  L1_v_k2 =p.L1_Iapp+((((-p.L1_iNa_gNa.*((L1_iNa_m(n-1,:) + .5*dt*L1_iNa_m_k1)).^3.*((L1_iNa_h(n-1,:) + .5*dt*L1_iNa_h_k1)).*(((L1_v(n-1,:) + .5*dt*L1_v_k1))-p.L1_iNa_ENa))))+((((-p.L1_iK_gK.*((L1_iK_n(n-1,:) + .5*dt*L1_iK_n_k1)).^4.*(((L1_v(n-1,:) + .5*dt*L1_v_k1))-p.L1_iK_EK))))+((-(((p.L1_L4_iGABA_gGABA.*(((L1_L4_iGABA_s(n-1,:) + .5*dt*L1_L4_iGABA_s_k1))*L1_L4_iGABA_netcon).*(((L1_v(n-1,:) + .5*dt*L1_v_k1))-p.L1_L4_iGABA_EGABA)))))+((((-p.L1_L3_iAMPA_gAMPA.*(((L1_L3_iAMPA_s(n-1,:) + .5*dt*L1_L3_iAMPA_s_k1))*L1_L3_iAMPA_netcon).*(((L1_v(n-1,:) + .5*dt*L1_v_k1))-p.L1_L3_iAMPA_EAMPA))))))))+p.L1_noise*randn(1,p.L1_Npop);
  L1_iNa_m_k2 = (((2.5-.1*(((L1_v(n-1,:) + .5*dt*L1_v_k1))+65))./(exp(2.5-.1*(((L1_v(n-1,:) + .5*dt*L1_v_k1))+65))-1))).*(1-((L1_iNa_m(n-1,:) + .5*dt*L1_iNa_m_k1)))-((4*exp(-(((L1_v(n-1,:) + .5*dt*L1_v_k1))+65)/18))).*((L1_iNa_m(n-1,:) + .5*dt*L1_iNa_m_k1));
  L1_iNa_h_k2 = ((.07*exp(-(((L1_v(n-1,:) + .5*dt*L1_v_k1))+65)/20))).*(1-((L1_iNa_h(n-1,:) + .5*dt*L1_iNa_h_k1)))-((1./(exp(3-.1*(((L1_v(n-1,:) + .5*dt*L1_v_k1))+65))+1))).*((L1_iNa_h(n-1,:) + .5*dt*L1_iNa_h_k1));
  L1_iK_n_k2 = (((.1-.01*(((L1_v(n-1,:) + .5*dt*L1_v_k1))+65))./(exp(1-.1*(((L1_v(n-1,:) + .5*dt*L1_v_k1))+65))-1))).*(1-((L1_iK_n(n-1,:) + .5*dt*L1_iK_n_k1)))-((.125*exp(-(((L1_v(n-1,:) + .5*dt*L1_v_k1))+65)/80))).*((L1_iK_n(n-1,:) + .5*dt*L1_iK_n_k1));
  L2_v_k2 =p.L2_Iapp+((((-p.L2_iNa_gNa.*((L2_iNa_m(n-1,:) + .5*dt*L2_iNa_m_k1)).^3.*((L2_iNa_h(n-1,:) + .5*dt*L2_iNa_h_k1)).*(((L2_v(n-1,:) + .5*dt*L2_v_k1))-p.L2_iNa_ENa))))+((((-p.L2_iK_gK.*((L2_iK_n(n-1,:) + .5*dt*L2_iK_n_k1)).^4.*(((L2_v(n-1,:) + .5*dt*L2_v_k1))-p.L2_iK_EK))))+((((-p.L2_L1_iGABAa_gGABAa.*(((L2_L1_iGABAa_s(n-1,:) + .5*dt*L2_L1_iGABAa_s_k1))*L2_L1_iGABAa_netcon).*(((L2_v(n-1,:) + .5*dt*L2_v_k1))-p.L2_L1_iGABAa_EGABAa))))+((((-p.L2_L5_iAMPA_gAMPA.*(((L2_L5_iAMPA_s(n-1,:) + .5*dt*L2_L5_iAMPA_s_k1))*L2_L5_iAMPA_netcon).*(((L2_v(n-1,:) + .5*dt*L2_v_k1))-p.L2_L5_iAMPA_EAMPA))))+((((-p.L2_L3_iAMPA_gAMPA.*(((L2_L3_iAMPA_s(n-1,:) + .5*dt*L2_L3_iAMPA_s_k1))*L2_L3_iAMPA_netcon).*(((L2_v(n-1,:) + .5*dt*L2_v_k1))-p.L2_L3_iAMPA_EAMPA)))))))))+p.L2_noise*randn(1,p.L2_Npop);
  L2_iNa_m_k2 = (((2.5-.1*(((L2_v(n-1,:) + .5*dt*L2_v_k1))+65))./(exp(2.5-.1*(((L2_v(n-1,:) + .5*dt*L2_v_k1))+65))-1))).*(1-((L2_iNa_m(n-1,:) + .5*dt*L2_iNa_m_k1)))-((4*exp(-(((L2_v(n-1,:) + .5*dt*L2_v_k1))+65)/18))).*((L2_iNa_m(n-1,:) + .5*dt*L2_iNa_m_k1));
  L2_iNa_h_k2 = ((.07*exp(-(((L2_v(n-1,:) + .5*dt*L2_v_k1))+65)/20))).*(1-((L2_iNa_h(n-1,:) + .5*dt*L2_iNa_h_k1)))-((1./(exp(3-.1*(((L2_v(n-1,:) + .5*dt*L2_v_k1))+65))+1))).*((L2_iNa_h(n-1,:) + .5*dt*L2_iNa_h_k1));
  L2_iK_n_k2 = (((.1-.01*(((L2_v(n-1,:) + .5*dt*L2_v_k1))+65))./(exp(1-.1*(((L2_v(n-1,:) + .5*dt*L2_v_k1))+65))-1))).*(1-((L2_iK_n(n-1,:) + .5*dt*L2_iK_n_k1)))-((.125*exp(-(((L2_v(n-1,:) + .5*dt*L2_v_k1))+65)/80))).*((L2_iK_n(n-1,:) + .5*dt*L2_iK_n_k1));
  L3_v_k2 =p.L3_Iapp+((((-p.L3_iNa_gNa.*((L3_iNa_m(n-1,:) + .5*dt*L3_iNa_m_k1)).^3.*((L3_iNa_h(n-1,:) + .5*dt*L3_iNa_h_k1)).*(((L3_v(n-1,:) + .5*dt*L3_v_k1))-p.L3_iNa_ENa))))+((((-p.L3_iK_gK.*((L3_iK_n(n-1,:) + .5*dt*L3_iK_n_k1)).^4.*(((L3_v(n-1,:) + .5*dt*L3_v_k1))-p.L3_iK_EK))))+((((-p.L3_L2_iAMPA_gAMPA.*(((L3_L2_iAMPA_s(n-1,:) + .5*dt*L3_L2_iAMPA_s_k1))*L3_L2_iAMPA_netcon).*(((L3_v(n-1,:) + .5*dt*L3_v_k1))-p.L3_L2_iAMPA_EAMPA)))))))+p.L3_noise*randn(1,p.L3_Npop);
  L3_iNa_m_k2 = (((2.5-.1*(((L3_v(n-1,:) + .5*dt*L3_v_k1))+65))./(exp(2.5-.1*(((L3_v(n-1,:) + .5*dt*L3_v_k1))+65))-1))).*(1-((L3_iNa_m(n-1,:) + .5*dt*L3_iNa_m_k1)))-((4*exp(-(((L3_v(n-1,:) + .5*dt*L3_v_k1))+65)/18))).*((L3_iNa_m(n-1,:) + .5*dt*L3_iNa_m_k1));
  L3_iNa_h_k2 = ((.07*exp(-(((L3_v(n-1,:) + .5*dt*L3_v_k1))+65)/20))).*(1-((L3_iNa_h(n-1,:) + .5*dt*L3_iNa_h_k1)))-((1./(exp(3-.1*(((L3_v(n-1,:) + .5*dt*L3_v_k1))+65))+1))).*((L3_iNa_h(n-1,:) + .5*dt*L3_iNa_h_k1));
  L3_iK_n_k2 = (((.1-.01*(((L3_v(n-1,:) + .5*dt*L3_v_k1))+65))./(exp(1-.1*(((L3_v(n-1,:) + .5*dt*L3_v_k1))+65))-1))).*(1-((L3_iK_n(n-1,:) + .5*dt*L3_iK_n_k1)))-((.125*exp(-(((L3_v(n-1,:) + .5*dt*L3_v_k1))+65)/80))).*((L3_iK_n(n-1,:) + .5*dt*L3_iK_n_k1));
  L4_v_k2 =0.5*p.L4_Iapp+0.5*((((-p.L4_iNa_gNa.*((L4_iNa_m(n-1,:) + .5*dt*L4_iNa_m_k1)).^3.*((L4_iNa_h(n-1,:) + .5*dt*L4_iNa_h_k1)).*(((L4_v(n-1,:) + .5*dt*L4_v_k1))-p.L4_iNa_ENa))))+((((-p.L4_iK_gK.*((L4_iK_n(n-1,:) + .5*dt*L4_iK_n_k1)).^4.*(((L4_v(n-1,:) + .5*dt*L4_v_k1))-p.L4_iK_EK))))))+p.L4_noise*randn(1,p.L4_Npop);
  L4_iNa_m_k2 = (((2.5-.1*(((L4_v(n-1,:) + .5*dt*L4_v_k1))+65))./(exp(2.5-.1*(((L4_v(n-1,:) + .5*dt*L4_v_k1))+65))-1))).*(1-((L4_iNa_m(n-1,:) + .5*dt*L4_iNa_m_k1)))-((4*exp(-(((L4_v(n-1,:) + .5*dt*L4_v_k1))+65)/18))).*((L4_iNa_m(n-1,:) + .5*dt*L4_iNa_m_k1));
  L4_iNa_h_k2 = ((.07*exp(-(((L4_v(n-1,:) + .5*dt*L4_v_k1))+65)/20))).*(1-((L4_iNa_h(n-1,:) + .5*dt*L4_iNa_h_k1)))-((1./(exp(3-.1*(((L4_v(n-1,:) + .5*dt*L4_v_k1))+65))+1))).*((L4_iNa_h(n-1,:) + .5*dt*L4_iNa_h_k1));
  L4_iK_n_k2 = (((.1-.01*(((L4_v(n-1,:) + .5*dt*L4_v_k1))+65))./(exp(1-.1*(((L4_v(n-1,:) + .5*dt*L4_v_k1))+65))-1))).*(1-((L4_iK_n(n-1,:) + .5*dt*L4_iK_n_k1)))-((.125*exp(-(((L4_v(n-1,:) + .5*dt*L4_v_k1))+65)/80))).*((L4_iK_n(n-1,:) + .5*dt*L4_iK_n_k1));
  L5_v_k2 =0.5*p.L5_Iapp+0.5*((((-p.L5_iNa_gNa.*((L5_iNa_m(n-1,:) + .5*dt*L5_iNa_m_k1)).^3.*((L5_iNa_h(n-1,:) + .5*dt*L5_iNa_h_k1)).*(((L5_v(n-1,:) + .5*dt*L5_v_k1))-p.L5_iNa_ENa))))+((((-p.L5_iK_gK.*((L5_iK_n(n-1,:) + .5*dt*L5_iK_n_k1)).^4.*(((L5_v(n-1,:) + .5*dt*L5_v_k1))-p.L5_iK_EK))))))+p.L5_noise*randn(1,p.L5_Npop);
  L5_iNa_m_k2 = (((2.5-.1*(((L5_v(n-1,:) + .5*dt*L5_v_k1))+65))./(exp(2.5-.1*(((L5_v(n-1,:) + .5*dt*L5_v_k1))+65))-1))).*(1-((L5_iNa_m(n-1,:) + .5*dt*L5_iNa_m_k1)))-((4*exp(-(((L5_v(n-1,:) + .5*dt*L5_v_k1))+65)/18))).*((L5_iNa_m(n-1,:) + .5*dt*L5_iNa_m_k1));
  L5_iNa_h_k2 = ((.07*exp(-(((L5_v(n-1,:) + .5*dt*L5_v_k1))+65)/20))).*(1-((L5_iNa_h(n-1,:) + .5*dt*L5_iNa_h_k1)))-((1./(exp(3-.1*(((L5_v(n-1,:) + .5*dt*L5_v_k1))+65))+1))).*((L5_iNa_h(n-1,:) + .5*dt*L5_iNa_h_k1));
  L5_iK_n_k2 = (((.1-.01*(((L5_v(n-1,:) + .5*dt*L5_v_k1))+65))./(exp(1-.1*(((L5_v(n-1,:) + .5*dt*L5_v_k1))+65))-1))).*(1-((L5_iK_n(n-1,:) + .5*dt*L5_iK_n_k1)))-((.125*exp(-(((L5_v(n-1,:) + .5*dt*L5_v_k1))+65)/80))).*((L5_iK_n(n-1,:) + .5*dt*L5_iK_n_k1));
  L2_L1_iGABAa_s_k2 = -((L2_L1_iGABAa_s(n-1,:) + .5*dt*L2_L1_iGABAa_s_k1))./p.L2_L1_iGABAa_tauD + 1/2*(1+tanh(((L1_v(n-1,:) + .5*dt*L1_v_k1))/10)).*((1-((L2_L1_iGABAa_s(n-1,:) + .5*dt*L2_L1_iGABAa_s_k1)))/p.L2_L1_iGABAa_tauR);
  L2_L5_iAMPA_s_k2 = -((L2_L5_iAMPA_s(n-1,:) + .5*dt*L2_L5_iAMPA_s_k1))./p.L2_L5_iAMPA_tauD + 1/2*(1+tanh(((L5_v(n-1,:) + .5*dt*L5_v_k1))/10)).*((1-((L2_L5_iAMPA_s(n-1,:) + .5*dt*L2_L5_iAMPA_s_k1)))/p.L2_L5_iAMPA_tauR);
  L3_L2_iAMPA_s_k2 = -((L3_L2_iAMPA_s(n-1,:) + .5*dt*L3_L2_iAMPA_s_k1))./p.L3_L2_iAMPA_tauD + 1/2*(1+tanh(((L2_v(n-1,:) + .5*dt*L2_v_k1))/10)).*((1-((L3_L2_iAMPA_s(n-1,:) + .5*dt*L3_L2_iAMPA_s_k1)))/p.L3_L2_iAMPA_tauR);
  L2_L3_iAMPA_s_k2 = -((L2_L3_iAMPA_s(n-1,:) + .5*dt*L2_L3_iAMPA_s_k1))./p.L2_L3_iAMPA_tauD + 1/2*(1+tanh(((L3_v(n-1,:) + .5*dt*L3_v_k1))/10)).*((1-((L2_L3_iAMPA_s(n-1,:) + .5*dt*L2_L3_iAMPA_s_k1)))/p.L2_L3_iAMPA_tauR);
  L1_L4_iGABA_s_k2 = -((L1_L4_iGABA_s(n-1,:) + .5*dt*L1_L4_iGABA_s_k1))./p.L1_L4_iGABA_tauGABA + ((1-((L1_L4_iGABA_s(n-1,:) + .5*dt*L1_L4_iGABA_s_k1)))/p.L1_L4_iGABA_tauGABAr).*(1+tanh(((L4_v(n-1,:) + .5*dt*L4_v_k1))/10));
  L1_L3_iAMPA_s_k2 = -((L1_L3_iAMPA_s(n-1,:) + .5*dt*L1_L3_iAMPA_s_k1))./p.L1_L3_iAMPA_tauD + 1/2*(1+tanh(((L3_v(n-1,:) + .5*dt*L3_v_k1))/10)).*((1-((L1_L3_iAMPA_s(n-1,:) + .5*dt*L1_L3_iAMPA_s_k1)))/p.L1_L3_iAMPA_tauR);

  L1_v_k3 =p.L1_Iapp+((((-p.L1_iNa_gNa.*((L1_iNa_m(n-1,:) + .5*dt*L1_iNa_m_k2)).^3.*((L1_iNa_h(n-1,:) + .5*dt*L1_iNa_h_k2)).*(((L1_v(n-1,:) + .5*dt*L1_v_k2))-p.L1_iNa_ENa))))+((((-p.L1_iK_gK.*((L1_iK_n(n-1,:) + .5*dt*L1_iK_n_k2)).^4.*(((L1_v(n-1,:) + .5*dt*L1_v_k2))-p.L1_iK_EK))))+((-(((p.L1_L4_iGABA_gGABA.*(((L1_L4_iGABA_s(n-1,:) + .5*dt*L1_L4_iGABA_s_k2))*L1_L4_iGABA_netcon).*(((L1_v(n-1,:) + .5*dt*L1_v_k2))-p.L1_L4_iGABA_EGABA)))))+((((-p.L1_L3_iAMPA_gAMPA.*(((L1_L3_iAMPA_s(n-1,:) + .5*dt*L1_L3_iAMPA_s_k2))*L1_L3_iAMPA_netcon).*(((L1_v(n-1,:) + .5*dt*L1_v_k2))-p.L1_L3_iAMPA_EAMPA))))))))+p.L1_noise*randn(1,p.L1_Npop);
  L1_iNa_m_k3 = (((2.5-.1*(((L1_v(n-1,:) + .5*dt*L1_v_k2))+65))./(exp(2.5-.1*(((L1_v(n-1,:) + .5*dt*L1_v_k2))+65))-1))).*(1-((L1_iNa_m(n-1,:) + .5*dt*L1_iNa_m_k2)))-((4*exp(-(((L1_v(n-1,:) + .5*dt*L1_v_k2))+65)/18))).*((L1_iNa_m(n-1,:) + .5*dt*L1_iNa_m_k2));
  L1_iNa_h_k3 = ((.07*exp(-(((L1_v(n-1,:) + .5*dt*L1_v_k2))+65)/20))).*(1-((L1_iNa_h(n-1,:) + .5*dt*L1_iNa_h_k2)))-((1./(exp(3-.1*(((L1_v(n-1,:) + .5*dt*L1_v_k2))+65))+1))).*((L1_iNa_h(n-1,:) + .5*dt*L1_iNa_h_k2));
  L1_iK_n_k3 = (((.1-.01*(((L1_v(n-1,:) + .5*dt*L1_v_k2))+65))./(exp(1-.1*(((L1_v(n-1,:) + .5*dt*L1_v_k2))+65))-1))).*(1-((L1_iK_n(n-1,:) + .5*dt*L1_iK_n_k2)))-((.125*exp(-(((L1_v(n-1,:) + .5*dt*L1_v_k2))+65)/80))).*((L1_iK_n(n-1,:) + .5*dt*L1_iK_n_k2));
  L2_v_k3 =p.L2_Iapp+((((-p.L2_iNa_gNa.*((L2_iNa_m(n-1,:) + .5*dt*L2_iNa_m_k2)).^3.*((L2_iNa_h(n-1,:) + .5*dt*L2_iNa_h_k2)).*(((L2_v(n-1,:) + .5*dt*L2_v_k2))-p.L2_iNa_ENa))))+((((-p.L2_iK_gK.*((L2_iK_n(n-1,:) + .5*dt*L2_iK_n_k2)).^4.*(((L2_v(n-1,:) + .5*dt*L2_v_k2))-p.L2_iK_EK))))+((((-p.L2_L1_iGABAa_gGABAa.*(((L2_L1_iGABAa_s(n-1,:) + .5*dt*L2_L1_iGABAa_s_k2))*L2_L1_iGABAa_netcon).*(((L2_v(n-1,:) + .5*dt*L2_v_k2))-p.L2_L1_iGABAa_EGABAa))))+((((-p.L2_L5_iAMPA_gAMPA.*(((L2_L5_iAMPA_s(n-1,:) + .5*dt*L2_L5_iAMPA_s_k2))*L2_L5_iAMPA_netcon).*(((L2_v(n-1,:) + .5*dt*L2_v_k2))-p.L2_L5_iAMPA_EAMPA))))+((((-p.L2_L3_iAMPA_gAMPA.*(((L2_L3_iAMPA_s(n-1,:) + .5*dt*L2_L3_iAMPA_s_k2))*L2_L3_iAMPA_netcon).*(((L2_v(n-1,:) + .5*dt*L2_v_k2))-p.L2_L3_iAMPA_EAMPA)))))))))+p.L2_noise*randn(1,p.L2_Npop);
  L2_iNa_m_k3 = (((2.5-.1*(((L2_v(n-1,:) + .5*dt*L2_v_k2))+65))./(exp(2.5-.1*(((L2_v(n-1,:) + .5*dt*L2_v_k2))+65))-1))).*(1-((L2_iNa_m(n-1,:) + .5*dt*L2_iNa_m_k2)))-((4*exp(-(((L2_v(n-1,:) + .5*dt*L2_v_k2))+65)/18))).*((L2_iNa_m(n-1,:) + .5*dt*L2_iNa_m_k2));
  L2_iNa_h_k3 = ((.07*exp(-(((L2_v(n-1,:) + .5*dt*L2_v_k2))+65)/20))).*(1-((L2_iNa_h(n-1,:) + .5*dt*L2_iNa_h_k2)))-((1./(exp(3-.1*(((L2_v(n-1,:) + .5*dt*L2_v_k2))+65))+1))).*((L2_iNa_h(n-1,:) + .5*dt*L2_iNa_h_k2));
  L2_iK_n_k3 = (((.1-.01*(((L2_v(n-1,:) + .5*dt*L2_v_k2))+65))./(exp(1-.1*(((L2_v(n-1,:) + .5*dt*L2_v_k2))+65))-1))).*(1-((L2_iK_n(n-1,:) + .5*dt*L2_iK_n_k2)))-((.125*exp(-(((L2_v(n-1,:) + .5*dt*L2_v_k2))+65)/80))).*((L2_iK_n(n-1,:) + .5*dt*L2_iK_n_k2));
  L3_v_k3 =p.L3_Iapp+((((-p.L3_iNa_gNa.*((L3_iNa_m(n-1,:) + .5*dt*L3_iNa_m_k2)).^3.*((L3_iNa_h(n-1,:) + .5*dt*L3_iNa_h_k2)).*(((L3_v(n-1,:) + .5*dt*L3_v_k2))-p.L3_iNa_ENa))))+((((-p.L3_iK_gK.*((L3_iK_n(n-1,:) + .5*dt*L3_iK_n_k2)).^4.*(((L3_v(n-1,:) + .5*dt*L3_v_k2))-p.L3_iK_EK))))+((((-p.L3_L2_iAMPA_gAMPA.*(((L3_L2_iAMPA_s(n-1,:) + .5*dt*L3_L2_iAMPA_s_k2))*L3_L2_iAMPA_netcon).*(((L3_v(n-1,:) + .5*dt*L3_v_k2))-p.L3_L2_iAMPA_EAMPA)))))))+p.L3_noise*randn(1,p.L3_Npop);
  L3_iNa_m_k3 = (((2.5-.1*(((L3_v(n-1,:) + .5*dt*L3_v_k2))+65))./(exp(2.5-.1*(((L3_v(n-1,:) + .5*dt*L3_v_k2))+65))-1))).*(1-((L3_iNa_m(n-1,:) + .5*dt*L3_iNa_m_k2)))-((4*exp(-(((L3_v(n-1,:) + .5*dt*L3_v_k2))+65)/18))).*((L3_iNa_m(n-1,:) + .5*dt*L3_iNa_m_k2));
  L3_iNa_h_k3 = ((.07*exp(-(((L3_v(n-1,:) + .5*dt*L3_v_k2))+65)/20))).*(1-((L3_iNa_h(n-1,:) + .5*dt*L3_iNa_h_k2)))-((1./(exp(3-.1*(((L3_v(n-1,:) + .5*dt*L3_v_k2))+65))+1))).*((L3_iNa_h(n-1,:) + .5*dt*L3_iNa_h_k2));
  L3_iK_n_k3 = (((.1-.01*(((L3_v(n-1,:) + .5*dt*L3_v_k2))+65))./(exp(1-.1*(((L3_v(n-1,:) + .5*dt*L3_v_k2))+65))-1))).*(1-((L3_iK_n(n-1,:) + .5*dt*L3_iK_n_k2)))-((.125*exp(-(((L3_v(n-1,:) + .5*dt*L3_v_k2))+65)/80))).*((L3_iK_n(n-1,:) + .5*dt*L3_iK_n_k2));
  L4_v_k3 =0.5*p.L4_Iapp+0.5*((((-p.L4_iNa_gNa.*((L4_iNa_m(n-1,:) + .5*dt*L4_iNa_m_k2)).^3.*((L4_iNa_h(n-1,:) + .5*dt*L4_iNa_h_k2)).*(((L4_v(n-1,:) + .5*dt*L4_v_k2))-p.L4_iNa_ENa))))+((((-p.L4_iK_gK.*((L4_iK_n(n-1,:) + .5*dt*L4_iK_n_k2)).^4.*(((L4_v(n-1,:) + .5*dt*L4_v_k2))-p.L4_iK_EK))))))+p.L4_noise*randn(1,p.L4_Npop);
  L4_iNa_m_k3 = (((2.5-.1*(((L4_v(n-1,:) + .5*dt*L4_v_k2))+65))./(exp(2.5-.1*(((L4_v(n-1,:) + .5*dt*L4_v_k2))+65))-1))).*(1-((L4_iNa_m(n-1,:) + .5*dt*L4_iNa_m_k2)))-((4*exp(-(((L4_v(n-1,:) + .5*dt*L4_v_k2))+65)/18))).*((L4_iNa_m(n-1,:) + .5*dt*L4_iNa_m_k2));
  L4_iNa_h_k3 = ((.07*exp(-(((L4_v(n-1,:) + .5*dt*L4_v_k2))+65)/20))).*(1-((L4_iNa_h(n-1,:) + .5*dt*L4_iNa_h_k2)))-((1./(exp(3-.1*(((L4_v(n-1,:) + .5*dt*L4_v_k2))+65))+1))).*((L4_iNa_h(n-1,:) + .5*dt*L4_iNa_h_k2));
  L4_iK_n_k3 = (((.1-.01*(((L4_v(n-1,:) + .5*dt*L4_v_k2))+65))./(exp(1-.1*(((L4_v(n-1,:) + .5*dt*L4_v_k2))+65))-1))).*(1-((L4_iK_n(n-1,:) + .5*dt*L4_iK_n_k2)))-((.125*exp(-(((L4_v(n-1,:) + .5*dt*L4_v_k2))+65)/80))).*((L4_iK_n(n-1,:) + .5*dt*L4_iK_n_k2));
  L5_v_k3 =0.5*p.L5_Iapp+0.5*((((-p.L5_iNa_gNa.*((L5_iNa_m(n-1,:) + .5*dt*L5_iNa_m_k2)).^3.*((L5_iNa_h(n-1,:) + .5*dt*L5_iNa_h_k2)).*(((L5_v(n-1,:) + .5*dt*L5_v_k2))-p.L5_iNa_ENa))))+((((-p.L5_iK_gK.*((L5_iK_n(n-1,:) + .5*dt*L5_iK_n_k2)).^4.*(((L5_v(n-1,:) + .5*dt*L5_v_k2))-p.L5_iK_EK))))))+p.L5_noise*randn(1,p.L5_Npop);
  L5_iNa_m_k3 = (((2.5-.1*(((L5_v(n-1,:) + .5*dt*L5_v_k2))+65))./(exp(2.5-.1*(((L5_v(n-1,:) + .5*dt*L5_v_k2))+65))-1))).*(1-((L5_iNa_m(n-1,:) + .5*dt*L5_iNa_m_k2)))-((4*exp(-(((L5_v(n-1,:) + .5*dt*L5_v_k2))+65)/18))).*((L5_iNa_m(n-1,:) + .5*dt*L5_iNa_m_k2));
  L5_iNa_h_k3 = ((.07*exp(-(((L5_v(n-1,:) + .5*dt*L5_v_k2))+65)/20))).*(1-((L5_iNa_h(n-1,:) + .5*dt*L5_iNa_h_k2)))-((1./(exp(3-.1*(((L5_v(n-1,:) + .5*dt*L5_v_k2))+65))+1))).*((L5_iNa_h(n-1,:) + .5*dt*L5_iNa_h_k2));
  L5_iK_n_k3 = (((.1-.01*(((L5_v(n-1,:) + .5*dt*L5_v_k2))+65))./(exp(1-.1*(((L5_v(n-1,:) + .5*dt*L5_v_k2))+65))-1))).*(1-((L5_iK_n(n-1,:) + .5*dt*L5_iK_n_k2)))-((.125*exp(-(((L5_v(n-1,:) + .5*dt*L5_v_k2))+65)/80))).*((L5_iK_n(n-1,:) + .5*dt*L5_iK_n_k2));
  L2_L1_iGABAa_s_k3 = -((L2_L1_iGABAa_s(n-1,:) + .5*dt*L2_L1_iGABAa_s_k2))./p.L2_L1_iGABAa_tauD + 1/2*(1+tanh(((L1_v(n-1,:) + .5*dt*L1_v_k2))/10)).*((1-((L2_L1_iGABAa_s(n-1,:) + .5*dt*L2_L1_iGABAa_s_k2)))/p.L2_L1_iGABAa_tauR);
  L2_L5_iAMPA_s_k3 = -((L2_L5_iAMPA_s(n-1,:) + .5*dt*L2_L5_iAMPA_s_k2))./p.L2_L5_iAMPA_tauD + 1/2*(1+tanh(((L5_v(n-1,:) + .5*dt*L5_v_k2))/10)).*((1-((L2_L5_iAMPA_s(n-1,:) + .5*dt*L2_L5_iAMPA_s_k2)))/p.L2_L5_iAMPA_tauR);
  L3_L2_iAMPA_s_k3 = -((L3_L2_iAMPA_s(n-1,:) + .5*dt*L3_L2_iAMPA_s_k2))./p.L3_L2_iAMPA_tauD + 1/2*(1+tanh(((L2_v(n-1,:) + .5*dt*L2_v_k2))/10)).*((1-((L3_L2_iAMPA_s(n-1,:) + .5*dt*L3_L2_iAMPA_s_k2)))/p.L3_L2_iAMPA_tauR);
  L2_L3_iAMPA_s_k3 = -((L2_L3_iAMPA_s(n-1,:) + .5*dt*L2_L3_iAMPA_s_k2))./p.L2_L3_iAMPA_tauD + 1/2*(1+tanh(((L3_v(n-1,:) + .5*dt*L3_v_k2))/10)).*((1-((L2_L3_iAMPA_s(n-1,:) + .5*dt*L2_L3_iAMPA_s_k2)))/p.L2_L3_iAMPA_tauR);
  L1_L4_iGABA_s_k3 = -((L1_L4_iGABA_s(n-1,:) + .5*dt*L1_L4_iGABA_s_k2))./p.L1_L4_iGABA_tauGABA + ((1-((L1_L4_iGABA_s(n-1,:) + .5*dt*L1_L4_iGABA_s_k2)))/p.L1_L4_iGABA_tauGABAr).*(1+tanh(((L4_v(n-1,:) + .5*dt*L4_v_k2))/10));
  L1_L3_iAMPA_s_k3 = -((L1_L3_iAMPA_s(n-1,:) + .5*dt*L1_L3_iAMPA_s_k2))./p.L1_L3_iAMPA_tauD + 1/2*(1+tanh(((L3_v(n-1,:) + .5*dt*L3_v_k2))/10)).*((1-((L1_L3_iAMPA_s(n-1,:) + .5*dt*L1_L3_iAMPA_s_k2)))/p.L1_L3_iAMPA_tauR);

  t = t + .5*dt;
  L1_v_k4 =p.L1_Iapp+((((-p.L1_iNa_gNa.*((L1_iNa_m(n-1,:) + dt*L1_iNa_m_k3)).^3.*((L1_iNa_h(n-1,:) + dt*L1_iNa_h_k3)).*(((L1_v(n-1,:) + dt*L1_v_k3))-p.L1_iNa_ENa))))+((((-p.L1_iK_gK.*((L1_iK_n(n-1,:) + dt*L1_iK_n_k3)).^4.*(((L1_v(n-1,:) + dt*L1_v_k3))-p.L1_iK_EK))))+((-(((p.L1_L4_iGABA_gGABA.*(((L1_L4_iGABA_s(n-1,:) + dt*L1_L4_iGABA_s_k3))*L1_L4_iGABA_netcon).*(((L1_v(n-1,:) + dt*L1_v_k3))-p.L1_L4_iGABA_EGABA)))))+((((-p.L1_L3_iAMPA_gAMPA.*(((L1_L3_iAMPA_s(n-1,:) + dt*L1_L3_iAMPA_s_k3))*L1_L3_iAMPA_netcon).*(((L1_v(n-1,:) + dt*L1_v_k3))-p.L1_L3_iAMPA_EAMPA))))))))+p.L1_noise*randn(1,p.L1_Npop);
  L1_iNa_m_k4 = (((2.5-.1*(((L1_v(n-1,:) + dt*L1_v_k3))+65))./(exp(2.5-.1*(((L1_v(n-1,:) + dt*L1_v_k3))+65))-1))).*(1-((L1_iNa_m(n-1,:) + dt*L1_iNa_m_k3)))-((4*exp(-(((L1_v(n-1,:) + dt*L1_v_k3))+65)/18))).*((L1_iNa_m(n-1,:) + dt*L1_iNa_m_k3));
  L1_iNa_h_k4 = ((.07*exp(-(((L1_v(n-1,:) + dt*L1_v_k3))+65)/20))).*(1-((L1_iNa_h(n-1,:) + dt*L1_iNa_h_k3)))-((1./(exp(3-.1*(((L1_v(n-1,:) + dt*L1_v_k3))+65))+1))).*((L1_iNa_h(n-1,:) + dt*L1_iNa_h_k3));
  L1_iK_n_k4 = (((.1-.01*(((L1_v(n-1,:) + dt*L1_v_k3))+65))./(exp(1-.1*(((L1_v(n-1,:) + dt*L1_v_k3))+65))-1))).*(1-((L1_iK_n(n-1,:) + dt*L1_iK_n_k3)))-((.125*exp(-(((L1_v(n-1,:) + dt*L1_v_k3))+65)/80))).*((L1_iK_n(n-1,:) + dt*L1_iK_n_k3));
  L2_v_k4 =p.L2_Iapp+((((-p.L2_iNa_gNa.*((L2_iNa_m(n-1,:) + dt*L2_iNa_m_k3)).^3.*((L2_iNa_h(n-1,:) + dt*L2_iNa_h_k3)).*(((L2_v(n-1,:) + dt*L2_v_k3))-p.L2_iNa_ENa))))+((((-p.L2_iK_gK.*((L2_iK_n(n-1,:) + dt*L2_iK_n_k3)).^4.*(((L2_v(n-1,:) + dt*L2_v_k3))-p.L2_iK_EK))))+((((-p.L2_L1_iGABAa_gGABAa.*(((L2_L1_iGABAa_s(n-1,:) + dt*L2_L1_iGABAa_s_k3))*L2_L1_iGABAa_netcon).*(((L2_v(n-1,:) + dt*L2_v_k3))-p.L2_L1_iGABAa_EGABAa))))+((((-p.L2_L5_iAMPA_gAMPA.*(((L2_L5_iAMPA_s(n-1,:) + dt*L2_L5_iAMPA_s_k3))*L2_L5_iAMPA_netcon).*(((L2_v(n-1,:) + dt*L2_v_k3))-p.L2_L5_iAMPA_EAMPA))))+((((-p.L2_L3_iAMPA_gAMPA.*(((L2_L3_iAMPA_s(n-1,:) + dt*L2_L3_iAMPA_s_k3))*L2_L3_iAMPA_netcon).*(((L2_v(n-1,:) + dt*L2_v_k3))-p.L2_L3_iAMPA_EAMPA)))))))))+p.L2_noise*randn(1,p.L2_Npop);
  L2_iNa_m_k4 = (((2.5-.1*(((L2_v(n-1,:) + dt*L2_v_k3))+65))./(exp(2.5-.1*(((L2_v(n-1,:) + dt*L2_v_k3))+65))-1))).*(1-((L2_iNa_m(n-1,:) + dt*L2_iNa_m_k3)))-((4*exp(-(((L2_v(n-1,:) + dt*L2_v_k3))+65)/18))).*((L2_iNa_m(n-1,:) + dt*L2_iNa_m_k3));
  L2_iNa_h_k4 = ((.07*exp(-(((L2_v(n-1,:) + dt*L2_v_k3))+65)/20))).*(1-((L2_iNa_h(n-1,:) + dt*L2_iNa_h_k3)))-((1./(exp(3-.1*(((L2_v(n-1,:) + dt*L2_v_k3))+65))+1))).*((L2_iNa_h(n-1,:) + dt*L2_iNa_h_k3));
  L2_iK_n_k4 = (((.1-.01*(((L2_v(n-1,:) + dt*L2_v_k3))+65))./(exp(1-.1*(((L2_v(n-1,:) + dt*L2_v_k3))+65))-1))).*(1-((L2_iK_n(n-1,:) + dt*L2_iK_n_k3)))-((.125*exp(-(((L2_v(n-1,:) + dt*L2_v_k3))+65)/80))).*((L2_iK_n(n-1,:) + dt*L2_iK_n_k3));
  L3_v_k4 =p.L3_Iapp+((((-p.L3_iNa_gNa.*((L3_iNa_m(n-1,:) + dt*L3_iNa_m_k3)).^3.*((L3_iNa_h(n-1,:) + dt*L3_iNa_h_k3)).*(((L3_v(n-1,:) + dt*L3_v_k3))-p.L3_iNa_ENa))))+((((-p.L3_iK_gK.*((L3_iK_n(n-1,:) + dt*L3_iK_n_k3)).^4.*(((L3_v(n-1,:) + dt*L3_v_k3))-p.L3_iK_EK))))+((((-p.L3_L2_iAMPA_gAMPA.*(((L3_L2_iAMPA_s(n-1,:) + dt*L3_L2_iAMPA_s_k3))*L3_L2_iAMPA_netcon).*(((L3_v(n-1,:) + dt*L3_v_k3))-p.L3_L2_iAMPA_EAMPA)))))))+p.L3_noise*randn(1,p.L3_Npop);
  L3_iNa_m_k4 = (((2.5-.1*(((L3_v(n-1,:) + dt*L3_v_k3))+65))./(exp(2.5-.1*(((L3_v(n-1,:) + dt*L3_v_k3))+65))-1))).*(1-((L3_iNa_m(n-1,:) + dt*L3_iNa_m_k3)))-((4*exp(-(((L3_v(n-1,:) + dt*L3_v_k3))+65)/18))).*((L3_iNa_m(n-1,:) + dt*L3_iNa_m_k3));
  L3_iNa_h_k4 = ((.07*exp(-(((L3_v(n-1,:) + dt*L3_v_k3))+65)/20))).*(1-((L3_iNa_h(n-1,:) + dt*L3_iNa_h_k3)))-((1./(exp(3-.1*(((L3_v(n-1,:) + dt*L3_v_k3))+65))+1))).*((L3_iNa_h(n-1,:) + dt*L3_iNa_h_k3));
  L3_iK_n_k4 = (((.1-.01*(((L3_v(n-1,:) + dt*L3_v_k3))+65))./(exp(1-.1*(((L3_v(n-1,:) + dt*L3_v_k3))+65))-1))).*(1-((L3_iK_n(n-1,:) + dt*L3_iK_n_k3)))-((.125*exp(-(((L3_v(n-1,:) + dt*L3_v_k3))+65)/80))).*((L3_iK_n(n-1,:) + dt*L3_iK_n_k3));
  L4_v_k4 =0.5*p.L4_Iapp+0.5*((((-p.L4_iNa_gNa.*((L4_iNa_m(n-1,:) + dt*L4_iNa_m_k3)).^3.*((L4_iNa_h(n-1,:) + dt*L4_iNa_h_k3)).*(((L4_v(n-1,:) + dt*L4_v_k3))-p.L4_iNa_ENa))))+((((-p.L4_iK_gK.*((L4_iK_n(n-1,:) + dt*L4_iK_n_k3)).^4.*(((L4_v(n-1,:) + dt*L4_v_k3))-p.L4_iK_EK))))))+p.L4_noise*randn(1,p.L4_Npop);
  L4_iNa_m_k4 = (((2.5-.1*(((L4_v(n-1,:) + dt*L4_v_k3))+65))./(exp(2.5-.1*(((L4_v(n-1,:) + dt*L4_v_k3))+65))-1))).*(1-((L4_iNa_m(n-1,:) + dt*L4_iNa_m_k3)))-((4*exp(-(((L4_v(n-1,:) + dt*L4_v_k3))+65)/18))).*((L4_iNa_m(n-1,:) + dt*L4_iNa_m_k3));
  L4_iNa_h_k4 = ((.07*exp(-(((L4_v(n-1,:) + dt*L4_v_k3))+65)/20))).*(1-((L4_iNa_h(n-1,:) + dt*L4_iNa_h_k3)))-((1./(exp(3-.1*(((L4_v(n-1,:) + dt*L4_v_k3))+65))+1))).*((L4_iNa_h(n-1,:) + dt*L4_iNa_h_k3));
  L4_iK_n_k4 = (((.1-.01*(((L4_v(n-1,:) + dt*L4_v_k3))+65))./(exp(1-.1*(((L4_v(n-1,:) + dt*L4_v_k3))+65))-1))).*(1-((L4_iK_n(n-1,:) + dt*L4_iK_n_k3)))-((.125*exp(-(((L4_v(n-1,:) + dt*L4_v_k3))+65)/80))).*((L4_iK_n(n-1,:) + dt*L4_iK_n_k3));
  L5_v_k4 =0.5*p.L5_Iapp+0.5*((((-p.L5_iNa_gNa.*((L5_iNa_m(n-1,:) + dt*L5_iNa_m_k3)).^3.*((L5_iNa_h(n-1,:) + dt*L5_iNa_h_k3)).*(((L5_v(n-1,:) + dt*L5_v_k3))-p.L5_iNa_ENa))))+((((-p.L5_iK_gK.*((L5_iK_n(n-1,:) + dt*L5_iK_n_k3)).^4.*(((L5_v(n-1,:) + dt*L5_v_k3))-p.L5_iK_EK))))))+p.L5_noise*randn(1,p.L5_Npop);
  L5_iNa_m_k4 = (((2.5-.1*(((L5_v(n-1,:) + dt*L5_v_k3))+65))./(exp(2.5-.1*(((L5_v(n-1,:) + dt*L5_v_k3))+65))-1))).*(1-((L5_iNa_m(n-1,:) + dt*L5_iNa_m_k3)))-((4*exp(-(((L5_v(n-1,:) + dt*L5_v_k3))+65)/18))).*((L5_iNa_m(n-1,:) + dt*L5_iNa_m_k3));
  L5_iNa_h_k4 = ((.07*exp(-(((L5_v(n-1,:) + dt*L5_v_k3))+65)/20))).*(1-((L5_iNa_h(n-1,:) + dt*L5_iNa_h_k3)))-((1./(exp(3-.1*(((L5_v(n-1,:) + dt*L5_v_k3))+65))+1))).*((L5_iNa_h(n-1,:) + dt*L5_iNa_h_k3));
  L5_iK_n_k4 = (((.1-.01*(((L5_v(n-1,:) + dt*L5_v_k3))+65))./(exp(1-.1*(((L5_v(n-1,:) + dt*L5_v_k3))+65))-1))).*(1-((L5_iK_n(n-1,:) + dt*L5_iK_n_k3)))-((.125*exp(-(((L5_v(n-1,:) + dt*L5_v_k3))+65)/80))).*((L5_iK_n(n-1,:) + dt*L5_iK_n_k3));
  L2_L1_iGABAa_s_k4 = -((L2_L1_iGABAa_s(n-1,:) + dt*L2_L1_iGABAa_s_k3))./p.L2_L1_iGABAa_tauD + 1/2*(1+tanh(((L1_v(n-1,:) + dt*L1_v_k3))/10)).*((1-((L2_L1_iGABAa_s(n-1,:) + dt*L2_L1_iGABAa_s_k3)))/p.L2_L1_iGABAa_tauR);
  L2_L5_iAMPA_s_k4 = -((L2_L5_iAMPA_s(n-1,:) + dt*L2_L5_iAMPA_s_k3))./p.L2_L5_iAMPA_tauD + 1/2*(1+tanh(((L5_v(n-1,:) + dt*L5_v_k3))/10)).*((1-((L2_L5_iAMPA_s(n-1,:) + dt*L2_L5_iAMPA_s_k3)))/p.L2_L5_iAMPA_tauR);
  L3_L2_iAMPA_s_k4 = -((L3_L2_iAMPA_s(n-1,:) + dt*L3_L2_iAMPA_s_k3))./p.L3_L2_iAMPA_tauD + 1/2*(1+tanh(((L2_v(n-1,:) + dt*L2_v_k3))/10)).*((1-((L3_L2_iAMPA_s(n-1,:) + dt*L3_L2_iAMPA_s_k3)))/p.L3_L2_iAMPA_tauR);
  L2_L3_iAMPA_s_k4 = -((L2_L3_iAMPA_s(n-1,:) + dt*L2_L3_iAMPA_s_k3))./p.L2_L3_iAMPA_tauD + 1/2*(1+tanh(((L3_v(n-1,:) + dt*L3_v_k3))/10)).*((1-((L2_L3_iAMPA_s(n-1,:) + dt*L2_L3_iAMPA_s_k3)))/p.L2_L3_iAMPA_tauR);
  L1_L4_iGABA_s_k4 = -((L1_L4_iGABA_s(n-1,:) + dt*L1_L4_iGABA_s_k3))./p.L1_L4_iGABA_tauGABA + ((1-((L1_L4_iGABA_s(n-1,:) + dt*L1_L4_iGABA_s_k3)))/p.L1_L4_iGABA_tauGABAr).*(1+tanh(((L4_v(n-1,:) + dt*L4_v_k3))/10));
  L1_L3_iAMPA_s_k4 = -((L1_L3_iAMPA_s(n-1,:) + dt*L1_L3_iAMPA_s_k3))./p.L1_L3_iAMPA_tauD + 1/2*(1+tanh(((L3_v(n-1,:) + dt*L3_v_k3))/10)).*((1-((L1_L3_iAMPA_s(n-1,:) + dt*L1_L3_iAMPA_s_k3)))/p.L1_L3_iAMPA_tauR);

  % ------------------------------------------------------------
  % Update state variables:
  % ------------------------------------------------------------
  L1_v(n,:) = L1_v(n-1,:)+(dt/6)*(L1_v_k1 + 2*(L1_v_k2 + L1_v_k3) + L1_v_k4);
  L1_iNa_m(n,:) = L1_iNa_m(n-1,:)+(dt/6)*(L1_iNa_m_k1 + 2*(L1_iNa_m_k2 + L1_iNa_m_k3) + L1_iNa_m_k4);
  L1_iNa_h(n,:) = L1_iNa_h(n-1,:)+(dt/6)*(L1_iNa_h_k1 + 2*(L1_iNa_h_k2 + L1_iNa_h_k3) + L1_iNa_h_k4);
  L1_iK_n(n,:) = L1_iK_n(n-1,:)+(dt/6)*(L1_iK_n_k1 + 2*(L1_iK_n_k2 + L1_iK_n_k3) + L1_iK_n_k4);
  L2_v(n,:) = L2_v(n-1,:)+(dt/6)*(L2_v_k1 + 2*(L2_v_k2 + L2_v_k3) + L2_v_k4);
  L2_iNa_m(n,:) = L2_iNa_m(n-1,:)+(dt/6)*(L2_iNa_m_k1 + 2*(L2_iNa_m_k2 + L2_iNa_m_k3) + L2_iNa_m_k4);
  L2_iNa_h(n,:) = L2_iNa_h(n-1,:)+(dt/6)*(L2_iNa_h_k1 + 2*(L2_iNa_h_k2 + L2_iNa_h_k3) + L2_iNa_h_k4);
  L2_iK_n(n,:) = L2_iK_n(n-1,:)+(dt/6)*(L2_iK_n_k1 + 2*(L2_iK_n_k2 + L2_iK_n_k3) + L2_iK_n_k4);
  L3_v(n,:) = L3_v(n-1,:)+(dt/6)*(L3_v_k1 + 2*(L3_v_k2 + L3_v_k3) + L3_v_k4);
  L3_iNa_m(n,:) = L3_iNa_m(n-1,:)+(dt/6)*(L3_iNa_m_k1 + 2*(L3_iNa_m_k2 + L3_iNa_m_k3) + L3_iNa_m_k4);
  L3_iNa_h(n,:) = L3_iNa_h(n-1,:)+(dt/6)*(L3_iNa_h_k1 + 2*(L3_iNa_h_k2 + L3_iNa_h_k3) + L3_iNa_h_k4);
  L3_iK_n(n,:) = L3_iK_n(n-1,:)+(dt/6)*(L3_iK_n_k1 + 2*(L3_iK_n_k2 + L3_iK_n_k3) + L3_iK_n_k4);
  L4_v(n,:) = L4_v(n-1,:)+(dt/6)*(L4_v_k1 + 2*(L4_v_k2 + L4_v_k3) + L4_v_k4);
  L4_iNa_m(n,:) = L4_iNa_m(n-1,:)+(dt/6)*(L4_iNa_m_k1 + 2*(L4_iNa_m_k2 + L4_iNa_m_k3) + L4_iNa_m_k4);
  L4_iNa_h(n,:) = L4_iNa_h(n-1,:)+(dt/6)*(L4_iNa_h_k1 + 2*(L4_iNa_h_k2 + L4_iNa_h_k3) + L4_iNa_h_k4);
  L4_iK_n(n,:) = L4_iK_n(n-1,:)+(dt/6)*(L4_iK_n_k1 + 2*(L4_iK_n_k2 + L4_iK_n_k3) + L4_iK_n_k4);
  L5_v(n,:) = L5_v(n-1,:)+(dt/6)*(L5_v_k1 + 2*(L5_v_k2 + L5_v_k3) + L5_v_k4);
  L5_iNa_m(n,:) = L5_iNa_m(n-1,:)+(dt/6)*(L5_iNa_m_k1 + 2*(L5_iNa_m_k2 + L5_iNa_m_k3) + L5_iNa_m_k4);
  L5_iNa_h(n,:) = L5_iNa_h(n-1,:)+(dt/6)*(L5_iNa_h_k1 + 2*(L5_iNa_h_k2 + L5_iNa_h_k3) + L5_iNa_h_k4);
  L5_iK_n(n,:) = L5_iK_n(n-1,:)+(dt/6)*(L5_iK_n_k1 + 2*(L5_iK_n_k2 + L5_iK_n_k3) + L5_iK_n_k4);
  L2_L1_iGABAa_s(n,:) = L2_L1_iGABAa_s(n-1,:)+(dt/6)*(L2_L1_iGABAa_s_k1 + 2*(L2_L1_iGABAa_s_k2 + L2_L1_iGABAa_s_k3) + L2_L1_iGABAa_s_k4);
  L2_L5_iAMPA_s(n,:) = L2_L5_iAMPA_s(n-1,:)+(dt/6)*(L2_L5_iAMPA_s_k1 + 2*(L2_L5_iAMPA_s_k2 + L2_L5_iAMPA_s_k3) + L2_L5_iAMPA_s_k4);
  L3_L2_iAMPA_s(n,:) = L3_L2_iAMPA_s(n-1,:)+(dt/6)*(L3_L2_iAMPA_s_k1 + 2*(L3_L2_iAMPA_s_k2 + L3_L2_iAMPA_s_k3) + L3_L2_iAMPA_s_k4);
  L2_L3_iAMPA_s(n,:) = L2_L3_iAMPA_s(n-1,:)+(dt/6)*(L2_L3_iAMPA_s_k1 + 2*(L2_L3_iAMPA_s_k2 + L2_L3_iAMPA_s_k3) + L2_L3_iAMPA_s_k4);
  L1_L4_iGABA_s(n,:) = L1_L4_iGABA_s(n-1,:)+(dt/6)*(L1_L4_iGABA_s_k1 + 2*(L1_L4_iGABA_s_k2 + L1_L4_iGABA_s_k3) + L1_L4_iGABA_s_k4);
  L1_L3_iAMPA_s(n,:) = L1_L3_iAMPA_s(n-1,:)+(dt/6)*(L1_L3_iAMPA_s_k1 + 2*(L1_L3_iAMPA_s_k2 + L1_L3_iAMPA_s_k3) + L1_L3_iAMPA_s_k4);

  % ------------------------------------------------------------
  % Update monitors:
  % ------------------------------------------------------------
  L1_L3_iAMPA_IAMPA(n,:)=-p.L1_L3_iAMPA_gAMPA.*(L1_L3_iAMPA_s(n,:)*L1_L3_iAMPA_netcon).*(L1_v(n,:)-p.L1_L3_iAMPA_EAMPA);
  L1_L4_iGABA_IGABA(n,:)=(p.L1_L4_iGABA_gGABA.*(L1_L4_iGABA_s(n,:)*L1_L4_iGABA_netcon).*(L1_v(n,:)-p.L1_L4_iGABA_EGABA));
  L2_L1_iGABAa_IGABAa(n,:)=-p.L2_L1_iGABAa_gGABAa.*(L2_L1_iGABAa_s(n,:)*L2_L1_iGABAa_netcon).*(L2_v(n,:)-p.L2_L1_iGABAa_EGABAa);
  L2_L3_iAMPA_IAMPA(n,:)=-p.L2_L3_iAMPA_gAMPA.*(L2_L3_iAMPA_s(n,:)*L2_L3_iAMPA_netcon).*(L2_v(n,:)-p.L2_L3_iAMPA_EAMPA);
  L2_L5_iAMPA_IAMPA(n,:)=-p.L2_L5_iAMPA_gAMPA.*(L2_L5_iAMPA_s(n,:)*L2_L5_iAMPA_netcon).*(L2_v(n,:)-p.L2_L5_iAMPA_EAMPA);
  L3_L2_iAMPA_IAMPA(n,:)=-p.L3_L2_iAMPA_gAMPA.*(L3_L2_iAMPA_s(n,:)*L3_L2_iAMPA_netcon).*(L3_v(n,:)-p.L3_L2_iAMPA_EAMPA);
  n=n+1;
end

T=T(1:downsample_factor:ntime);

end
