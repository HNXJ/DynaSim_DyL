function [T,P1_u,P1_w,P1_v,P1_iNa_m,P1_iNa_h,P1_iK_n,P2_u,P2_w,P2_v,P2_iNa_m,P2_iNa_h,P2_iK_n,P3_u,P3_w,P3_v,P3_iNa_m,P3_iNa_h,P3_iK_n,P2_P1_iGABAa_s,P2_P3_iGABAa_s,P2_P1_iGABAa_IGABAa,P2_P3_iGABAa_IGABAa,P2_P1_iGABAa_netcon,P2_P3_iGABAa_netcon]=solve_ode

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
P2_P1_iGABAa_netcon = [+1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00];
P2_P3_iGABAa_netcon = [+1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00];

% ------------------------------------------------------------
% Initial conditions:
% ------------------------------------------------------------
t=0; k=1;

% STATE_VARIABLES:
P1_u = zeros(nsamp,p.P1_Npop);
  P1_u(1,:) = 1.0 * ones(1,p.P1_Npop);
P1_w = zeros(nsamp,p.P1_Npop);
  P1_w(1,:) = 0.0 * ones(1,p.P1_Npop);
P1_v = zeros(nsamp,p.P1_Npop);
  P1_v(1,:) = zeros(1,p.P1_Npop);
P1_iNa_m = zeros(nsamp,p.P1_Npop);
  P1_iNa_m(1,:) = p.P1_iNa_m_IC+p.P1_iNa_IC_noise*rand(1,p.P1_Npop);
P1_iNa_h = zeros(nsamp,p.P1_Npop);
  P1_iNa_h(1,:) = p.P1_iNa_h_IC+p.P1_iNa_IC_noise*rand(1,p.P1_Npop);
P1_iK_n = zeros(nsamp,p.P1_Npop);
  P1_iK_n(1,:) = p.P1_iK_n_IC+p.P1_iK_IC_noise*rand(1,p.P1_Npop);
P2_u = zeros(nsamp,p.P2_Npop);
  P2_u(1,:) = 1.0 * ones(1,p.P2_Npop);
P2_w = zeros(nsamp,p.P2_Npop);
  P2_w(1,:) = 0.0 * ones(1,p.P2_Npop);
P2_v = zeros(nsamp,p.P2_Npop);
  P2_v(1,:) = zeros(1,p.P2_Npop);
P2_iNa_m = zeros(nsamp,p.P2_Npop);
  P2_iNa_m(1,:) = p.P2_iNa_m_IC+p.P2_iNa_IC_noise*rand(1,p.P2_Npop);
P2_iNa_h = zeros(nsamp,p.P2_Npop);
  P2_iNa_h(1,:) = p.P2_iNa_h_IC+p.P2_iNa_IC_noise*rand(1,p.P2_Npop);
P2_iK_n = zeros(nsamp,p.P2_Npop);
  P2_iK_n(1,:) = p.P2_iK_n_IC+p.P2_iK_IC_noise*rand(1,p.P2_Npop);
P3_u = zeros(nsamp,p.P3_Npop);
  P3_u(1,:) = 1.0 * ones(1,p.P3_Npop);
P3_w = zeros(nsamp,p.P3_Npop);
  P3_w(1,:) = 0.0 * ones(1,p.P3_Npop);
P3_v = zeros(nsamp,p.P3_Npop);
  P3_v(1,:) = zeros(1,p.P3_Npop);
P3_iNa_m = zeros(nsamp,p.P3_Npop);
  P3_iNa_m(1,:) = p.P3_iNa_m_IC+p.P3_iNa_IC_noise*rand(1,p.P3_Npop);
P3_iNa_h = zeros(nsamp,p.P3_Npop);
  P3_iNa_h(1,:) = p.P3_iNa_h_IC+p.P3_iNa_IC_noise*rand(1,p.P3_Npop);
P3_iK_n = zeros(nsamp,p.P3_Npop);
  P3_iK_n(1,:) = p.P3_iK_n_IC+p.P3_iK_IC_noise*rand(1,p.P3_Npop);
P2_P1_iGABAa_s = zeros(nsamp,p.P1_Npop);
  P2_P1_iGABAa_s(1,:) =  p.P2_P1_iGABAa_IC+p.P2_P1_iGABAa_IC_noise.*rand(1,p.P1_Npop);
P2_P3_iGABAa_s = zeros(nsamp,p.P3_Npop);
  P2_P3_iGABAa_s(1,:) =  p.P2_P3_iGABAa_IC+p.P2_P3_iGABAa_IC_noise.*rand(1,p.P3_Npop);

% MONITORS:
P2_P1_iGABAa_IGABAa = zeros(nsamp,p.P2_Npop);
  P2_P1_iGABAa_IGABAa(1,:)=-p.P2_P1_iGABAa_gGABAa.*(P2_P1_iGABAa_s(1,:)*P2_P1_iGABAa_netcon).*(P2_u(1,:)-p.P2_P1_iGABAa_EGABAa);
P2_P3_iGABAa_IGABAa = zeros(nsamp,p.P2_Npop);
  P2_P3_iGABAa_IGABAa(1,:)=-p.P2_P3_iGABAa_gGABAa.*(P2_P3_iGABAa_s(1,:)*P2_P3_iGABAa_netcon).*(P2_u(1,:)-p.P2_P3_iGABAa_EGABAa);

% ###########################################################
% Numerical integration:
% ###########################################################
n=2;
for k=2:ntime
  t=T(k-1);
  P1_u_k1 =P1_w(n-1,:);
  P1_w_k1 =1;
  P1_v_k1 =P1_u(n-1,:)+((((-p.P1_iNa_gNa.*P1_iNa_m(n-1,:).^3.*P1_iNa_h(n-1,:).*(P1_u(n-1,:)-p.P1_iNa_ENa))))+((((-p.P1_iK_gK.*P1_iK_n(n-1,:).^4.*(P1_u(n-1,:)-p.P1_iK_EK))))))+p.P1_noise*randn(1,p.P1_Npop);
  P1_iNa_m_k1 = (((2.5-.1*(P1_u(n-1,:)+65))./(exp(2.5-.1*(P1_u(n-1,:)+65))-1))).*(1-P1_iNa_m(n-1,:))-((4*exp(-(P1_u(n-1,:)+65)/18))).*P1_iNa_m(n-1,:);
  P1_iNa_h_k1 = ((.07*exp(-(P1_u(n-1,:)+65)/20))).*(1-P1_iNa_h(n-1,:))-((1./(exp(3-.1*(P1_u(n-1,:)+65))+1))).*P1_iNa_h(n-1,:);
  P1_iK_n_k1 = (((.1-.01*(P1_u(n-1,:)+65))./(exp(1-.1*(P1_u(n-1,:)+65))-1))).*(1-P1_iK_n(n-1,:))-((.125*exp(-(P1_u(n-1,:)+65)/80))).*P1_iK_n(n-1,:);
  P2_u_k1 =P2_w(n-1,:);
  P2_w_k1 =1;
  P2_v_k1 =P2_u(n-1,:)+((((-p.P2_iNa_gNa.*P2_iNa_m(n-1,:).^3.*P2_iNa_h(n-1,:).*(P2_u(n-1,:)-p.P2_iNa_ENa))))+((((-p.P2_iK_gK.*P2_iK_n(n-1,:).^4.*(P2_u(n-1,:)-p.P2_iK_EK))))+((((-p.P2_P1_iGABAa_gGABAa.*(P2_P1_iGABAa_s(n-1,:)*P2_P1_iGABAa_netcon).*(P2_u(n-1,:)-p.P2_P1_iGABAa_EGABAa))))+((((-p.P2_P3_iGABAa_gGABAa.*(P2_P3_iGABAa_s(n-1,:)*P2_P3_iGABAa_netcon).*(P2_u(n-1,:)-p.P2_P3_iGABAa_EGABAa))))))))+p.P2_noise*randn(1,p.P2_Npop);
  P2_iNa_m_k1 = (((2.5-.1*(P2_u(n-1,:)+65))./(exp(2.5-.1*(P2_u(n-1,:)+65))-1))).*(1-P2_iNa_m(n-1,:))-((4*exp(-(P2_u(n-1,:)+65)/18))).*P2_iNa_m(n-1,:);
  P2_iNa_h_k1 = ((.07*exp(-(P2_u(n-1,:)+65)/20))).*(1-P2_iNa_h(n-1,:))-((1./(exp(3-.1*(P2_u(n-1,:)+65))+1))).*P2_iNa_h(n-1,:);
  P2_iK_n_k1 = (((.1-.01*(P2_u(n-1,:)+65))./(exp(1-.1*(P2_u(n-1,:)+65))-1))).*(1-P2_iK_n(n-1,:))-((.125*exp(-(P2_u(n-1,:)+65)/80))).*P2_iK_n(n-1,:);
  P3_u_k1 =P3_w(n-1,:);
  P3_w_k1 =1;
  P3_v_k1 =P3_u(n-1,:)+((((-p.P3_iNa_gNa.*P3_iNa_m(n-1,:).^3.*P3_iNa_h(n-1,:).*(P3_u(n-1,:)-p.P3_iNa_ENa))))+((((-p.P3_iK_gK.*P3_iK_n(n-1,:).^4.*(P3_u(n-1,:)-p.P3_iK_EK))))))+p.P3_noise*randn(1,p.P3_Npop);
  P3_iNa_m_k1 = (((2.5-.1*(P3_u(n-1,:)+65))./(exp(2.5-.1*(P3_u(n-1,:)+65))-1))).*(1-P3_iNa_m(n-1,:))-((4*exp(-(P3_u(n-1,:)+65)/18))).*P3_iNa_m(n-1,:);
  P3_iNa_h_k1 = ((.07*exp(-(P3_u(n-1,:)+65)/20))).*(1-P3_iNa_h(n-1,:))-((1./(exp(3-.1*(P3_u(n-1,:)+65))+1))).*P3_iNa_h(n-1,:);
  P3_iK_n_k1 = (((.1-.01*(P3_u(n-1,:)+65))./(exp(1-.1*(P3_u(n-1,:)+65))-1))).*(1-P3_iK_n(n-1,:))-((.125*exp(-(P3_u(n-1,:)+65)/80))).*P3_iK_n(n-1,:);
  P2_P1_iGABAa_s_k1 = -P2_P1_iGABAa_s(n-1,:)./p.P2_P1_iGABAa_tauD + 1/2*(1+tanh(P1_u(n-1,:)/10)).*((1-P2_P1_iGABAa_s(n-1,:))/p.P2_P1_iGABAa_tauR);
  P2_P3_iGABAa_s_k1 = -P2_P3_iGABAa_s(n-1,:)./p.P2_P3_iGABAa_tauD + 1/2*(1+tanh(P3_u(n-1,:)/10)).*((1-P2_P3_iGABAa_s(n-1,:))/p.P2_P3_iGABAa_tauR);

  t = t + .5*dt;
  P1_u_k2 =((P1_w(n-1,:) + .5*dt*P1_w_k1));
  P1_w_k2 =1;
  P1_v_k2 =((P1_u(n-1,:) + .5*dt*P1_u_k1))+((((-p.P1_iNa_gNa.*((P1_iNa_m(n-1,:) + .5*dt*P1_iNa_m_k1)).^3.*((P1_iNa_h(n-1,:) + .5*dt*P1_iNa_h_k1)).*(((P1_u(n-1,:) + .5*dt*P1_u_k1))-p.P1_iNa_ENa))))+((((-p.P1_iK_gK.*((P1_iK_n(n-1,:) + .5*dt*P1_iK_n_k1)).^4.*(((P1_u(n-1,:) + .5*dt*P1_u_k1))-p.P1_iK_EK))))))+p.P1_noise*randn(1,p.P1_Npop);
  P1_iNa_m_k2 = (((2.5-.1*(((P1_u(n-1,:) + .5*dt*P1_u_k1))+65))./(exp(2.5-.1*(((P1_u(n-1,:) + .5*dt*P1_u_k1))+65))-1))).*(1-((P1_iNa_m(n-1,:) + .5*dt*P1_iNa_m_k1)))-((4*exp(-(((P1_u(n-1,:) + .5*dt*P1_u_k1))+65)/18))).*((P1_iNa_m(n-1,:) + .5*dt*P1_iNa_m_k1));
  P1_iNa_h_k2 = ((.07*exp(-(((P1_u(n-1,:) + .5*dt*P1_u_k1))+65)/20))).*(1-((P1_iNa_h(n-1,:) + .5*dt*P1_iNa_h_k1)))-((1./(exp(3-.1*(((P1_u(n-1,:) + .5*dt*P1_u_k1))+65))+1))).*((P1_iNa_h(n-1,:) + .5*dt*P1_iNa_h_k1));
  P1_iK_n_k2 = (((.1-.01*(((P1_u(n-1,:) + .5*dt*P1_u_k1))+65))./(exp(1-.1*(((P1_u(n-1,:) + .5*dt*P1_u_k1))+65))-1))).*(1-((P1_iK_n(n-1,:) + .5*dt*P1_iK_n_k1)))-((.125*exp(-(((P1_u(n-1,:) + .5*dt*P1_u_k1))+65)/80))).*((P1_iK_n(n-1,:) + .5*dt*P1_iK_n_k1));
  P2_u_k2 =((P2_w(n-1,:) + .5*dt*P2_w_k1));
  P2_w_k2 =1;
  P2_v_k2 =((P2_u(n-1,:) + .5*dt*P2_u_k1))+((((-p.P2_iNa_gNa.*((P2_iNa_m(n-1,:) + .5*dt*P2_iNa_m_k1)).^3.*((P2_iNa_h(n-1,:) + .5*dt*P2_iNa_h_k1)).*(((P2_u(n-1,:) + .5*dt*P2_u_k1))-p.P2_iNa_ENa))))+((((-p.P2_iK_gK.*((P2_iK_n(n-1,:) + .5*dt*P2_iK_n_k1)).^4.*(((P2_u(n-1,:) + .5*dt*P2_u_k1))-p.P2_iK_EK))))+((((-p.P2_P1_iGABAa_gGABAa.*(((P2_P1_iGABAa_s(n-1,:) + .5*dt*P2_P1_iGABAa_s_k1))*P2_P1_iGABAa_netcon).*(((P2_u(n-1,:) + .5*dt*P2_u_k1))-p.P2_P1_iGABAa_EGABAa))))+((((-p.P2_P3_iGABAa_gGABAa.*(((P2_P3_iGABAa_s(n-1,:) + .5*dt*P2_P3_iGABAa_s_k1))*P2_P3_iGABAa_netcon).*(((P2_u(n-1,:) + .5*dt*P2_u_k1))-p.P2_P3_iGABAa_EGABAa))))))))+p.P2_noise*randn(1,p.P2_Npop);
  P2_iNa_m_k2 = (((2.5-.1*(((P2_u(n-1,:) + .5*dt*P2_u_k1))+65))./(exp(2.5-.1*(((P2_u(n-1,:) + .5*dt*P2_u_k1))+65))-1))).*(1-((P2_iNa_m(n-1,:) + .5*dt*P2_iNa_m_k1)))-((4*exp(-(((P2_u(n-1,:) + .5*dt*P2_u_k1))+65)/18))).*((P2_iNa_m(n-1,:) + .5*dt*P2_iNa_m_k1));
  P2_iNa_h_k2 = ((.07*exp(-(((P2_u(n-1,:) + .5*dt*P2_u_k1))+65)/20))).*(1-((P2_iNa_h(n-1,:) + .5*dt*P2_iNa_h_k1)))-((1./(exp(3-.1*(((P2_u(n-1,:) + .5*dt*P2_u_k1))+65))+1))).*((P2_iNa_h(n-1,:) + .5*dt*P2_iNa_h_k1));
  P2_iK_n_k2 = (((.1-.01*(((P2_u(n-1,:) + .5*dt*P2_u_k1))+65))./(exp(1-.1*(((P2_u(n-1,:) + .5*dt*P2_u_k1))+65))-1))).*(1-((P2_iK_n(n-1,:) + .5*dt*P2_iK_n_k1)))-((.125*exp(-(((P2_u(n-1,:) + .5*dt*P2_u_k1))+65)/80))).*((P2_iK_n(n-1,:) + .5*dt*P2_iK_n_k1));
  P3_u_k2 =((P3_w(n-1,:) + .5*dt*P3_w_k1));
  P3_w_k2 =1;
  P3_v_k2 =((P3_u(n-1,:) + .5*dt*P3_u_k1))+((((-p.P3_iNa_gNa.*((P3_iNa_m(n-1,:) + .5*dt*P3_iNa_m_k1)).^3.*((P3_iNa_h(n-1,:) + .5*dt*P3_iNa_h_k1)).*(((P3_u(n-1,:) + .5*dt*P3_u_k1))-p.P3_iNa_ENa))))+((((-p.P3_iK_gK.*((P3_iK_n(n-1,:) + .5*dt*P3_iK_n_k1)).^4.*(((P3_u(n-1,:) + .5*dt*P3_u_k1))-p.P3_iK_EK))))))+p.P3_noise*randn(1,p.P3_Npop);
  P3_iNa_m_k2 = (((2.5-.1*(((P3_u(n-1,:) + .5*dt*P3_u_k1))+65))./(exp(2.5-.1*(((P3_u(n-1,:) + .5*dt*P3_u_k1))+65))-1))).*(1-((P3_iNa_m(n-1,:) + .5*dt*P3_iNa_m_k1)))-((4*exp(-(((P3_u(n-1,:) + .5*dt*P3_u_k1))+65)/18))).*((P3_iNa_m(n-1,:) + .5*dt*P3_iNa_m_k1));
  P3_iNa_h_k2 = ((.07*exp(-(((P3_u(n-1,:) + .5*dt*P3_u_k1))+65)/20))).*(1-((P3_iNa_h(n-1,:) + .5*dt*P3_iNa_h_k1)))-((1./(exp(3-.1*(((P3_u(n-1,:) + .5*dt*P3_u_k1))+65))+1))).*((P3_iNa_h(n-1,:) + .5*dt*P3_iNa_h_k1));
  P3_iK_n_k2 = (((.1-.01*(((P3_u(n-1,:) + .5*dt*P3_u_k1))+65))./(exp(1-.1*(((P3_u(n-1,:) + .5*dt*P3_u_k1))+65))-1))).*(1-((P3_iK_n(n-1,:) + .5*dt*P3_iK_n_k1)))-((.125*exp(-(((P3_u(n-1,:) + .5*dt*P3_u_k1))+65)/80))).*((P3_iK_n(n-1,:) + .5*dt*P3_iK_n_k1));
  P2_P1_iGABAa_s_k2 = -((P2_P1_iGABAa_s(n-1,:) + .5*dt*P2_P1_iGABAa_s_k1))./p.P2_P1_iGABAa_tauD + 1/2*(1+tanh(((P1_u(n-1,:) + .5*dt*P1_u_k1))/10)).*((1-((P2_P1_iGABAa_s(n-1,:) + .5*dt*P2_P1_iGABAa_s_k1)))/p.P2_P1_iGABAa_tauR);
  P2_P3_iGABAa_s_k2 = -((P2_P3_iGABAa_s(n-1,:) + .5*dt*P2_P3_iGABAa_s_k1))./p.P2_P3_iGABAa_tauD + 1/2*(1+tanh(((P3_u(n-1,:) + .5*dt*P3_u_k1))/10)).*((1-((P2_P3_iGABAa_s(n-1,:) + .5*dt*P2_P3_iGABAa_s_k1)))/p.P2_P3_iGABAa_tauR);

  P1_u_k3 =((P1_w(n-1,:) + .5*dt*P1_w_k2));
  P1_w_k3 =1;
  P1_v_k3 =((P1_u(n-1,:) + .5*dt*P1_u_k2))+((((-p.P1_iNa_gNa.*((P1_iNa_m(n-1,:) + .5*dt*P1_iNa_m_k2)).^3.*((P1_iNa_h(n-1,:) + .5*dt*P1_iNa_h_k2)).*(((P1_u(n-1,:) + .5*dt*P1_u_k2))-p.P1_iNa_ENa))))+((((-p.P1_iK_gK.*((P1_iK_n(n-1,:) + .5*dt*P1_iK_n_k2)).^4.*(((P1_u(n-1,:) + .5*dt*P1_u_k2))-p.P1_iK_EK))))))+p.P1_noise*randn(1,p.P1_Npop);
  P1_iNa_m_k3 = (((2.5-.1*(((P1_u(n-1,:) + .5*dt*P1_u_k2))+65))./(exp(2.5-.1*(((P1_u(n-1,:) + .5*dt*P1_u_k2))+65))-1))).*(1-((P1_iNa_m(n-1,:) + .5*dt*P1_iNa_m_k2)))-((4*exp(-(((P1_u(n-1,:) + .5*dt*P1_u_k2))+65)/18))).*((P1_iNa_m(n-1,:) + .5*dt*P1_iNa_m_k2));
  P1_iNa_h_k3 = ((.07*exp(-(((P1_u(n-1,:) + .5*dt*P1_u_k2))+65)/20))).*(1-((P1_iNa_h(n-1,:) + .5*dt*P1_iNa_h_k2)))-((1./(exp(3-.1*(((P1_u(n-1,:) + .5*dt*P1_u_k2))+65))+1))).*((P1_iNa_h(n-1,:) + .5*dt*P1_iNa_h_k2));
  P1_iK_n_k3 = (((.1-.01*(((P1_u(n-1,:) + .5*dt*P1_u_k2))+65))./(exp(1-.1*(((P1_u(n-1,:) + .5*dt*P1_u_k2))+65))-1))).*(1-((P1_iK_n(n-1,:) + .5*dt*P1_iK_n_k2)))-((.125*exp(-(((P1_u(n-1,:) + .5*dt*P1_u_k2))+65)/80))).*((P1_iK_n(n-1,:) + .5*dt*P1_iK_n_k2));
  P2_u_k3 =((P2_w(n-1,:) + .5*dt*P2_w_k2));
  P2_w_k3 =1;
  P2_v_k3 =((P2_u(n-1,:) + .5*dt*P2_u_k2))+((((-p.P2_iNa_gNa.*((P2_iNa_m(n-1,:) + .5*dt*P2_iNa_m_k2)).^3.*((P2_iNa_h(n-1,:) + .5*dt*P2_iNa_h_k2)).*(((P2_u(n-1,:) + .5*dt*P2_u_k2))-p.P2_iNa_ENa))))+((((-p.P2_iK_gK.*((P2_iK_n(n-1,:) + .5*dt*P2_iK_n_k2)).^4.*(((P2_u(n-1,:) + .5*dt*P2_u_k2))-p.P2_iK_EK))))+((((-p.P2_P1_iGABAa_gGABAa.*(((P2_P1_iGABAa_s(n-1,:) + .5*dt*P2_P1_iGABAa_s_k2))*P2_P1_iGABAa_netcon).*(((P2_u(n-1,:) + .5*dt*P2_u_k2))-p.P2_P1_iGABAa_EGABAa))))+((((-p.P2_P3_iGABAa_gGABAa.*(((P2_P3_iGABAa_s(n-1,:) + .5*dt*P2_P3_iGABAa_s_k2))*P2_P3_iGABAa_netcon).*(((P2_u(n-1,:) + .5*dt*P2_u_k2))-p.P2_P3_iGABAa_EGABAa))))))))+p.P2_noise*randn(1,p.P2_Npop);
  P2_iNa_m_k3 = (((2.5-.1*(((P2_u(n-1,:) + .5*dt*P2_u_k2))+65))./(exp(2.5-.1*(((P2_u(n-1,:) + .5*dt*P2_u_k2))+65))-1))).*(1-((P2_iNa_m(n-1,:) + .5*dt*P2_iNa_m_k2)))-((4*exp(-(((P2_u(n-1,:) + .5*dt*P2_u_k2))+65)/18))).*((P2_iNa_m(n-1,:) + .5*dt*P2_iNa_m_k2));
  P2_iNa_h_k3 = ((.07*exp(-(((P2_u(n-1,:) + .5*dt*P2_u_k2))+65)/20))).*(1-((P2_iNa_h(n-1,:) + .5*dt*P2_iNa_h_k2)))-((1./(exp(3-.1*(((P2_u(n-1,:) + .5*dt*P2_u_k2))+65))+1))).*((P2_iNa_h(n-1,:) + .5*dt*P2_iNa_h_k2));
  P2_iK_n_k3 = (((.1-.01*(((P2_u(n-1,:) + .5*dt*P2_u_k2))+65))./(exp(1-.1*(((P2_u(n-1,:) + .5*dt*P2_u_k2))+65))-1))).*(1-((P2_iK_n(n-1,:) + .5*dt*P2_iK_n_k2)))-((.125*exp(-(((P2_u(n-1,:) + .5*dt*P2_u_k2))+65)/80))).*((P2_iK_n(n-1,:) + .5*dt*P2_iK_n_k2));
  P3_u_k3 =((P3_w(n-1,:) + .5*dt*P3_w_k2));
  P3_w_k3 =1;
  P3_v_k3 =((P3_u(n-1,:) + .5*dt*P3_u_k2))+((((-p.P3_iNa_gNa.*((P3_iNa_m(n-1,:) + .5*dt*P3_iNa_m_k2)).^3.*((P3_iNa_h(n-1,:) + .5*dt*P3_iNa_h_k2)).*(((P3_u(n-1,:) + .5*dt*P3_u_k2))-p.P3_iNa_ENa))))+((((-p.P3_iK_gK.*((P3_iK_n(n-1,:) + .5*dt*P3_iK_n_k2)).^4.*(((P3_u(n-1,:) + .5*dt*P3_u_k2))-p.P3_iK_EK))))))+p.P3_noise*randn(1,p.P3_Npop);
  P3_iNa_m_k3 = (((2.5-.1*(((P3_u(n-1,:) + .5*dt*P3_u_k2))+65))./(exp(2.5-.1*(((P3_u(n-1,:) + .5*dt*P3_u_k2))+65))-1))).*(1-((P3_iNa_m(n-1,:) + .5*dt*P3_iNa_m_k2)))-((4*exp(-(((P3_u(n-1,:) + .5*dt*P3_u_k2))+65)/18))).*((P3_iNa_m(n-1,:) + .5*dt*P3_iNa_m_k2));
  P3_iNa_h_k3 = ((.07*exp(-(((P3_u(n-1,:) + .5*dt*P3_u_k2))+65)/20))).*(1-((P3_iNa_h(n-1,:) + .5*dt*P3_iNa_h_k2)))-((1./(exp(3-.1*(((P3_u(n-1,:) + .5*dt*P3_u_k2))+65))+1))).*((P3_iNa_h(n-1,:) + .5*dt*P3_iNa_h_k2));
  P3_iK_n_k3 = (((.1-.01*(((P3_u(n-1,:) + .5*dt*P3_u_k2))+65))./(exp(1-.1*(((P3_u(n-1,:) + .5*dt*P3_u_k2))+65))-1))).*(1-((P3_iK_n(n-1,:) + .5*dt*P3_iK_n_k2)))-((.125*exp(-(((P3_u(n-1,:) + .5*dt*P3_u_k2))+65)/80))).*((P3_iK_n(n-1,:) + .5*dt*P3_iK_n_k2));
  P2_P1_iGABAa_s_k3 = -((P2_P1_iGABAa_s(n-1,:) + .5*dt*P2_P1_iGABAa_s_k2))./p.P2_P1_iGABAa_tauD + 1/2*(1+tanh(((P1_u(n-1,:) + .5*dt*P1_u_k2))/10)).*((1-((P2_P1_iGABAa_s(n-1,:) + .5*dt*P2_P1_iGABAa_s_k2)))/p.P2_P1_iGABAa_tauR);
  P2_P3_iGABAa_s_k3 = -((P2_P3_iGABAa_s(n-1,:) + .5*dt*P2_P3_iGABAa_s_k2))./p.P2_P3_iGABAa_tauD + 1/2*(1+tanh(((P3_u(n-1,:) + .5*dt*P3_u_k2))/10)).*((1-((P2_P3_iGABAa_s(n-1,:) + .5*dt*P2_P3_iGABAa_s_k2)))/p.P2_P3_iGABAa_tauR);

  t = t + .5*dt;
  P1_u_k4 =((P1_w(n-1,:) + dt*P1_w_k3));
  P1_w_k4 =1;
  P1_v_k4 =((P1_u(n-1,:) + dt*P1_u_k3))+((((-p.P1_iNa_gNa.*((P1_iNa_m(n-1,:) + dt*P1_iNa_m_k3)).^3.*((P1_iNa_h(n-1,:) + dt*P1_iNa_h_k3)).*(((P1_u(n-1,:) + dt*P1_u_k3))-p.P1_iNa_ENa))))+((((-p.P1_iK_gK.*((P1_iK_n(n-1,:) + dt*P1_iK_n_k3)).^4.*(((P1_u(n-1,:) + dt*P1_u_k3))-p.P1_iK_EK))))))+p.P1_noise*randn(1,p.P1_Npop);
  P1_iNa_m_k4 = (((2.5-.1*(((P1_u(n-1,:) + dt*P1_u_k3))+65))./(exp(2.5-.1*(((P1_u(n-1,:) + dt*P1_u_k3))+65))-1))).*(1-((P1_iNa_m(n-1,:) + dt*P1_iNa_m_k3)))-((4*exp(-(((P1_u(n-1,:) + dt*P1_u_k3))+65)/18))).*((P1_iNa_m(n-1,:) + dt*P1_iNa_m_k3));
  P1_iNa_h_k4 = ((.07*exp(-(((P1_u(n-1,:) + dt*P1_u_k3))+65)/20))).*(1-((P1_iNa_h(n-1,:) + dt*P1_iNa_h_k3)))-((1./(exp(3-.1*(((P1_u(n-1,:) + dt*P1_u_k3))+65))+1))).*((P1_iNa_h(n-1,:) + dt*P1_iNa_h_k3));
  P1_iK_n_k4 = (((.1-.01*(((P1_u(n-1,:) + dt*P1_u_k3))+65))./(exp(1-.1*(((P1_u(n-1,:) + dt*P1_u_k3))+65))-1))).*(1-((P1_iK_n(n-1,:) + dt*P1_iK_n_k3)))-((.125*exp(-(((P1_u(n-1,:) + dt*P1_u_k3))+65)/80))).*((P1_iK_n(n-1,:) + dt*P1_iK_n_k3));
  P2_u_k4 =((P2_w(n-1,:) + dt*P2_w_k3));
  P2_w_k4 =1;
  P2_v_k4 =((P2_u(n-1,:) + dt*P2_u_k3))+((((-p.P2_iNa_gNa.*((P2_iNa_m(n-1,:) + dt*P2_iNa_m_k3)).^3.*((P2_iNa_h(n-1,:) + dt*P2_iNa_h_k3)).*(((P2_u(n-1,:) + dt*P2_u_k3))-p.P2_iNa_ENa))))+((((-p.P2_iK_gK.*((P2_iK_n(n-1,:) + dt*P2_iK_n_k3)).^4.*(((P2_u(n-1,:) + dt*P2_u_k3))-p.P2_iK_EK))))+((((-p.P2_P1_iGABAa_gGABAa.*(((P2_P1_iGABAa_s(n-1,:) + dt*P2_P1_iGABAa_s_k3))*P2_P1_iGABAa_netcon).*(((P2_u(n-1,:) + dt*P2_u_k3))-p.P2_P1_iGABAa_EGABAa))))+((((-p.P2_P3_iGABAa_gGABAa.*(((P2_P3_iGABAa_s(n-1,:) + dt*P2_P3_iGABAa_s_k3))*P2_P3_iGABAa_netcon).*(((P2_u(n-1,:) + dt*P2_u_k3))-p.P2_P3_iGABAa_EGABAa))))))))+p.P2_noise*randn(1,p.P2_Npop);
  P2_iNa_m_k4 = (((2.5-.1*(((P2_u(n-1,:) + dt*P2_u_k3))+65))./(exp(2.5-.1*(((P2_u(n-1,:) + dt*P2_u_k3))+65))-1))).*(1-((P2_iNa_m(n-1,:) + dt*P2_iNa_m_k3)))-((4*exp(-(((P2_u(n-1,:) + dt*P2_u_k3))+65)/18))).*((P2_iNa_m(n-1,:) + dt*P2_iNa_m_k3));
  P2_iNa_h_k4 = ((.07*exp(-(((P2_u(n-1,:) + dt*P2_u_k3))+65)/20))).*(1-((P2_iNa_h(n-1,:) + dt*P2_iNa_h_k3)))-((1./(exp(3-.1*(((P2_u(n-1,:) + dt*P2_u_k3))+65))+1))).*((P2_iNa_h(n-1,:) + dt*P2_iNa_h_k3));
  P2_iK_n_k4 = (((.1-.01*(((P2_u(n-1,:) + dt*P2_u_k3))+65))./(exp(1-.1*(((P2_u(n-1,:) + dt*P2_u_k3))+65))-1))).*(1-((P2_iK_n(n-1,:) + dt*P2_iK_n_k3)))-((.125*exp(-(((P2_u(n-1,:) + dt*P2_u_k3))+65)/80))).*((P2_iK_n(n-1,:) + dt*P2_iK_n_k3));
  P3_u_k4 =((P3_w(n-1,:) + dt*P3_w_k3));
  P3_w_k4 =1;
  P3_v_k4 =((P3_u(n-1,:) + dt*P3_u_k3))+((((-p.P3_iNa_gNa.*((P3_iNa_m(n-1,:) + dt*P3_iNa_m_k3)).^3.*((P3_iNa_h(n-1,:) + dt*P3_iNa_h_k3)).*(((P3_u(n-1,:) + dt*P3_u_k3))-p.P3_iNa_ENa))))+((((-p.P3_iK_gK.*((P3_iK_n(n-1,:) + dt*P3_iK_n_k3)).^4.*(((P3_u(n-1,:) + dt*P3_u_k3))-p.P3_iK_EK))))))+p.P3_noise*randn(1,p.P3_Npop);
  P3_iNa_m_k4 = (((2.5-.1*(((P3_u(n-1,:) + dt*P3_u_k3))+65))./(exp(2.5-.1*(((P3_u(n-1,:) + dt*P3_u_k3))+65))-1))).*(1-((P3_iNa_m(n-1,:) + dt*P3_iNa_m_k3)))-((4*exp(-(((P3_u(n-1,:) + dt*P3_u_k3))+65)/18))).*((P3_iNa_m(n-1,:) + dt*P3_iNa_m_k3));
  P3_iNa_h_k4 = ((.07*exp(-(((P3_u(n-1,:) + dt*P3_u_k3))+65)/20))).*(1-((P3_iNa_h(n-1,:) + dt*P3_iNa_h_k3)))-((1./(exp(3-.1*(((P3_u(n-1,:) + dt*P3_u_k3))+65))+1))).*((P3_iNa_h(n-1,:) + dt*P3_iNa_h_k3));
  P3_iK_n_k4 = (((.1-.01*(((P3_u(n-1,:) + dt*P3_u_k3))+65))./(exp(1-.1*(((P3_u(n-1,:) + dt*P3_u_k3))+65))-1))).*(1-((P3_iK_n(n-1,:) + dt*P3_iK_n_k3)))-((.125*exp(-(((P3_u(n-1,:) + dt*P3_u_k3))+65)/80))).*((P3_iK_n(n-1,:) + dt*P3_iK_n_k3));
  P2_P1_iGABAa_s_k4 = -((P2_P1_iGABAa_s(n-1,:) + dt*P2_P1_iGABAa_s_k3))./p.P2_P1_iGABAa_tauD + 1/2*(1+tanh(((P1_u(n-1,:) + dt*P1_u_k3))/10)).*((1-((P2_P1_iGABAa_s(n-1,:) + dt*P2_P1_iGABAa_s_k3)))/p.P2_P1_iGABAa_tauR);
  P2_P3_iGABAa_s_k4 = -((P2_P3_iGABAa_s(n-1,:) + dt*P2_P3_iGABAa_s_k3))./p.P2_P3_iGABAa_tauD + 1/2*(1+tanh(((P3_u(n-1,:) + dt*P3_u_k3))/10)).*((1-((P2_P3_iGABAa_s(n-1,:) + dt*P2_P3_iGABAa_s_k3)))/p.P2_P3_iGABAa_tauR);

  % ------------------------------------------------------------
  % Update state variables:
  % ------------------------------------------------------------
  P1_u(n,:) = P1_u(n-1,:)+(dt/6)*(P1_u_k1 + 2*(P1_u_k2 + P1_u_k3) + P1_u_k4);
  P1_w(n,:) = P1_w(n-1,:)+(dt/6)*(P1_w_k1 + 2*(P1_w_k2 + P1_w_k3) + P1_w_k4);
  P1_v(n,:) = P1_v(n-1,:)+(dt/6)*(P1_v_k1 + 2*(P1_v_k2 + P1_v_k3) + P1_v_k4);
  P1_iNa_m(n,:) = P1_iNa_m(n-1,:)+(dt/6)*(P1_iNa_m_k1 + 2*(P1_iNa_m_k2 + P1_iNa_m_k3) + P1_iNa_m_k4);
  P1_iNa_h(n,:) = P1_iNa_h(n-1,:)+(dt/6)*(P1_iNa_h_k1 + 2*(P1_iNa_h_k2 + P1_iNa_h_k3) + P1_iNa_h_k4);
  P1_iK_n(n,:) = P1_iK_n(n-1,:)+(dt/6)*(P1_iK_n_k1 + 2*(P1_iK_n_k2 + P1_iK_n_k3) + P1_iK_n_k4);
  P2_u(n,:) = P2_u(n-1,:)+(dt/6)*(P2_u_k1 + 2*(P2_u_k2 + P2_u_k3) + P2_u_k4);
  P2_w(n,:) = P2_w(n-1,:)+(dt/6)*(P2_w_k1 + 2*(P2_w_k2 + P2_w_k3) + P2_w_k4);
  P2_v(n,:) = P2_v(n-1,:)+(dt/6)*(P2_v_k1 + 2*(P2_v_k2 + P2_v_k3) + P2_v_k4);
  P2_iNa_m(n,:) = P2_iNa_m(n-1,:)+(dt/6)*(P2_iNa_m_k1 + 2*(P2_iNa_m_k2 + P2_iNa_m_k3) + P2_iNa_m_k4);
  P2_iNa_h(n,:) = P2_iNa_h(n-1,:)+(dt/6)*(P2_iNa_h_k1 + 2*(P2_iNa_h_k2 + P2_iNa_h_k3) + P2_iNa_h_k4);
  P2_iK_n(n,:) = P2_iK_n(n-1,:)+(dt/6)*(P2_iK_n_k1 + 2*(P2_iK_n_k2 + P2_iK_n_k3) + P2_iK_n_k4);
  P3_u(n,:) = P3_u(n-1,:)+(dt/6)*(P3_u_k1 + 2*(P3_u_k2 + P3_u_k3) + P3_u_k4);
  P3_w(n,:) = P3_w(n-1,:)+(dt/6)*(P3_w_k1 + 2*(P3_w_k2 + P3_w_k3) + P3_w_k4);
  P3_v(n,:) = P3_v(n-1,:)+(dt/6)*(P3_v_k1 + 2*(P3_v_k2 + P3_v_k3) + P3_v_k4);
  P3_iNa_m(n,:) = P3_iNa_m(n-1,:)+(dt/6)*(P3_iNa_m_k1 + 2*(P3_iNa_m_k2 + P3_iNa_m_k3) + P3_iNa_m_k4);
  P3_iNa_h(n,:) = P3_iNa_h(n-1,:)+(dt/6)*(P3_iNa_h_k1 + 2*(P3_iNa_h_k2 + P3_iNa_h_k3) + P3_iNa_h_k4);
  P3_iK_n(n,:) = P3_iK_n(n-1,:)+(dt/6)*(P3_iK_n_k1 + 2*(P3_iK_n_k2 + P3_iK_n_k3) + P3_iK_n_k4);
  P2_P1_iGABAa_s(n,:) = P2_P1_iGABAa_s(n-1,:)+(dt/6)*(P2_P1_iGABAa_s_k1 + 2*(P2_P1_iGABAa_s_k2 + P2_P1_iGABAa_s_k3) + P2_P1_iGABAa_s_k4);
  P2_P3_iGABAa_s(n,:) = P2_P3_iGABAa_s(n-1,:)+(dt/6)*(P2_P3_iGABAa_s_k1 + 2*(P2_P3_iGABAa_s_k2 + P2_P3_iGABAa_s_k3) + P2_P3_iGABAa_s_k4);

  % ------------------------------------------------------------
  % Update monitors:
  % ------------------------------------------------------------
  P2_P1_iGABAa_IGABAa(n,:)=-p.P2_P1_iGABAa_gGABAa.*(P2_P1_iGABAa_s(n,:)*P2_P1_iGABAa_netcon).*(P2_u(n,:)-p.P2_P1_iGABAa_EGABAa);
  P2_P3_iGABAa_IGABAa(n,:)=-p.P2_P3_iGABAa_gGABAa.*(P2_P3_iGABAa_s(n,:)*P2_P3_iGABAa_netcon).*(P2_u(n,:)-p.P2_P3_iGABAa_EGABAa);
  n=n+1;
end

T=T(1:downsample_factor:ntime);

end
