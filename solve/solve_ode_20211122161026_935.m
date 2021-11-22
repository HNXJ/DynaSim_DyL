function [T,E_v,E_iNa_m,E_iNa_h,E_iK_n,I_v,I_iNa_m,I_iNa_h,I_iK_n,E_I_iGABAa_s,I_E_iAMPA_s,E_I_iGABAa_IGABAa,I_E_iAMPA_IAMPA,E_I_iGABAa_netcon,I_E_iAMPA_netcon]=solve_ode

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
E_I_iGABAa_netcon = ones(p.I_Npop,p.E_Npop);
I_E_iAMPA_netcon = [+1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00];

% ------------------------------------------------------------
% Initial conditions:
% ------------------------------------------------------------
t=0; k=1;

% STATE_VARIABLES:
E_v = zeros(nsamp,p.E_Npop);
  E_v(1,:) = zeros(1,p.E_Npop);
E_iNa_m = zeros(nsamp,p.E_Npop);
  E_iNa_m(1,:) = p.E_iNa_m_IC+p.E_iNa_IC_noise*rand(1,p.E_Npop);
E_iNa_h = zeros(nsamp,p.E_Npop);
  E_iNa_h(1,:) = p.E_iNa_h_IC+p.E_iNa_IC_noise*rand(1,p.E_Npop);
E_iK_n = zeros(nsamp,p.E_Npop);
  E_iK_n(1,:) = p.E_iK_n_IC+p.E_iK_IC_noise*rand(1,p.E_Npop);
I_v = zeros(nsamp,p.I_Npop);
  I_v(1,:) = zeros(1,p.I_Npop);
I_iNa_m = zeros(nsamp,p.I_Npop);
  I_iNa_m(1,:) = p.I_iNa_m_IC+p.I_iNa_IC_noise*rand(1,p.I_Npop);
I_iNa_h = zeros(nsamp,p.I_Npop);
  I_iNa_h(1,:) = p.I_iNa_h_IC+p.I_iNa_IC_noise*rand(1,p.I_Npop);
I_iK_n = zeros(nsamp,p.I_Npop);
  I_iK_n(1,:) = p.I_iK_n_IC+p.I_iK_IC_noise*rand(1,p.I_Npop);
E_I_iGABAa_s = zeros(nsamp,p.I_Npop);
  E_I_iGABAa_s(1,:) =  p.E_I_iGABAa_IC+p.E_I_iGABAa_IC_noise.*rand(1,p.I_Npop);
I_E_iAMPA_s = zeros(nsamp,p.E_Npop);
  I_E_iAMPA_s(1,:) =  p.I_E_iAMPA_IC+p.I_E_iAMPA_IC_noise.*rand(1,p.E_Npop);

% MONITORS:
E_I_iGABAa_IGABAa = zeros(nsamp,p.E_Npop);
  E_I_iGABAa_IGABAa(1,:)=-p.E_I_iGABAa_gGABAa.*(E_I_iGABAa_s(1,:)*E_I_iGABAa_netcon).*(E_v(1,:)-p.E_I_iGABAa_EGABAa);
I_E_iAMPA_IAMPA = zeros(nsamp,p.I_Npop);
  I_E_iAMPA_IAMPA(1,:)=-p.I_E_iAMPA_gAMPA.*(I_E_iAMPA_s(1,:)*I_E_iAMPA_netcon).*(I_v(1,:)-p.I_E_iAMPA_EAMPA);

% ###########################################################
% Numerical integration:
% ###########################################################
n=2;
for k=2:ntime
  t=T(k-1);
  E_v_k1 =p.E_Iapp+((((-p.E_iNa_gNa.*E_iNa_m(n-1,:).^3.*E_iNa_h(n-1,:).*(E_v(n-1,:)-p.E_iNa_ENa))))+((((-p.E_iK_gK.*E_iK_n(n-1,:).^4.*(E_v(n-1,:)-p.E_iK_EK))))+((((-p.E_I_iGABAa_gGABAa.*(E_I_iGABAa_s(n-1,:)*E_I_iGABAa_netcon).*(E_v(n-1,:)-p.E_I_iGABAa_EGABAa)))))))+p.E_noise*randn(1,p.E_Npop);
  E_iNa_m_k1 = (((2.5-.1*(E_v(n-1,:)+65))./(exp(2.5-.1*(E_v(n-1,:)+65))-1))).*(1-E_iNa_m(n-1,:))-((4*exp(-(E_v(n-1,:)+65)/18))).*E_iNa_m(n-1,:);
  E_iNa_h_k1 = ((.07*exp(-(E_v(n-1,:)+65)/20))).*(1-E_iNa_h(n-1,:))-((1./(exp(3-.1*(E_v(n-1,:)+65))+1))).*E_iNa_h(n-1,:);
  E_iK_n_k1 = (((.1-.01*(E_v(n-1,:)+65))./(exp(1-.1*(E_v(n-1,:)+65))-1))).*(1-E_iK_n(n-1,:))-((.125*exp(-(E_v(n-1,:)+65)/80))).*E_iK_n(n-1,:);
  I_v_k1 =p.I_Iapp+((((-p.I_iNa_gNa.*I_iNa_m(n-1,:).^3.*I_iNa_h(n-1,:).*(I_v(n-1,:)-p.I_iNa_ENa))))+((((-p.I_iK_gK.*I_iK_n(n-1,:).^4.*(I_v(n-1,:)-p.I_iK_EK))))+((((-p.I_E_iAMPA_gAMPA.*(I_E_iAMPA_s(n-1,:)*I_E_iAMPA_netcon).*(I_v(n-1,:)-p.I_E_iAMPA_EAMPA)))))))+p.I_noise*randn(1,p.I_Npop);
  I_iNa_m_k1 = (((2.5-.1*(I_v(n-1,:)+65))./(exp(2.5-.1*(I_v(n-1,:)+65))-1))).*(1-I_iNa_m(n-1,:))-((4*exp(-(I_v(n-1,:)+65)/18))).*I_iNa_m(n-1,:);
  I_iNa_h_k1 = ((.07*exp(-(I_v(n-1,:)+65)/20))).*(1-I_iNa_h(n-1,:))-((1./(exp(3-.1*(I_v(n-1,:)+65))+1))).*I_iNa_h(n-1,:);
  I_iK_n_k1 = (((.1-.01*(I_v(n-1,:)+65))./(exp(1-.1*(I_v(n-1,:)+65))-1))).*(1-I_iK_n(n-1,:))-((.125*exp(-(I_v(n-1,:)+65)/80))).*I_iK_n(n-1,:);
  E_I_iGABAa_s_k1 = -E_I_iGABAa_s(n-1,:)./p.E_I_iGABAa_tauD + 1/2*(1+tanh(I_v(n-1,:)/10)).*((1-E_I_iGABAa_s(n-1,:))/p.E_I_iGABAa_tauR);
  I_E_iAMPA_s_k1 = -I_E_iAMPA_s(n-1,:)./p.I_E_iAMPA_tauD + 1/2*(1+tanh(E_v(n-1,:)/10)).*((1-I_E_iAMPA_s(n-1,:))/p.I_E_iAMPA_tauR);

  t = t + .5*dt;
  E_v_k2 =p.E_Iapp+((((-p.E_iNa_gNa.*((E_iNa_m(n-1,:) + .5*dt*E_iNa_m_k1)).^3.*((E_iNa_h(n-1,:) + .5*dt*E_iNa_h_k1)).*(((E_v(n-1,:) + .5*dt*E_v_k1))-p.E_iNa_ENa))))+((((-p.E_iK_gK.*((E_iK_n(n-1,:) + .5*dt*E_iK_n_k1)).^4.*(((E_v(n-1,:) + .5*dt*E_v_k1))-p.E_iK_EK))))+((((-p.E_I_iGABAa_gGABAa.*(((E_I_iGABAa_s(n-1,:) + .5*dt*E_I_iGABAa_s_k1))*E_I_iGABAa_netcon).*(((E_v(n-1,:) + .5*dt*E_v_k1))-p.E_I_iGABAa_EGABAa)))))))+p.E_noise*randn(1,p.E_Npop);
  E_iNa_m_k2 = (((2.5-.1*(((E_v(n-1,:) + .5*dt*E_v_k1))+65))./(exp(2.5-.1*(((E_v(n-1,:) + .5*dt*E_v_k1))+65))-1))).*(1-((E_iNa_m(n-1,:) + .5*dt*E_iNa_m_k1)))-((4*exp(-(((E_v(n-1,:) + .5*dt*E_v_k1))+65)/18))).*((E_iNa_m(n-1,:) + .5*dt*E_iNa_m_k1));
  E_iNa_h_k2 = ((.07*exp(-(((E_v(n-1,:) + .5*dt*E_v_k1))+65)/20))).*(1-((E_iNa_h(n-1,:) + .5*dt*E_iNa_h_k1)))-((1./(exp(3-.1*(((E_v(n-1,:) + .5*dt*E_v_k1))+65))+1))).*((E_iNa_h(n-1,:) + .5*dt*E_iNa_h_k1));
  E_iK_n_k2 = (((.1-.01*(((E_v(n-1,:) + .5*dt*E_v_k1))+65))./(exp(1-.1*(((E_v(n-1,:) + .5*dt*E_v_k1))+65))-1))).*(1-((E_iK_n(n-1,:) + .5*dt*E_iK_n_k1)))-((.125*exp(-(((E_v(n-1,:) + .5*dt*E_v_k1))+65)/80))).*((E_iK_n(n-1,:) + .5*dt*E_iK_n_k1));
  I_v_k2 =p.I_Iapp+((((-p.I_iNa_gNa.*((I_iNa_m(n-1,:) + .5*dt*I_iNa_m_k1)).^3.*((I_iNa_h(n-1,:) + .5*dt*I_iNa_h_k1)).*(((I_v(n-1,:) + .5*dt*I_v_k1))-p.I_iNa_ENa))))+((((-p.I_iK_gK.*((I_iK_n(n-1,:) + .5*dt*I_iK_n_k1)).^4.*(((I_v(n-1,:) + .5*dt*I_v_k1))-p.I_iK_EK))))+((((-p.I_E_iAMPA_gAMPA.*(((I_E_iAMPA_s(n-1,:) + .5*dt*I_E_iAMPA_s_k1))*I_E_iAMPA_netcon).*(((I_v(n-1,:) + .5*dt*I_v_k1))-p.I_E_iAMPA_EAMPA)))))))+p.I_noise*randn(1,p.I_Npop);
  I_iNa_m_k2 = (((2.5-.1*(((I_v(n-1,:) + .5*dt*I_v_k1))+65))./(exp(2.5-.1*(((I_v(n-1,:) + .5*dt*I_v_k1))+65))-1))).*(1-((I_iNa_m(n-1,:) + .5*dt*I_iNa_m_k1)))-((4*exp(-(((I_v(n-1,:) + .5*dt*I_v_k1))+65)/18))).*((I_iNa_m(n-1,:) + .5*dt*I_iNa_m_k1));
  I_iNa_h_k2 = ((.07*exp(-(((I_v(n-1,:) + .5*dt*I_v_k1))+65)/20))).*(1-((I_iNa_h(n-1,:) + .5*dt*I_iNa_h_k1)))-((1./(exp(3-.1*(((I_v(n-1,:) + .5*dt*I_v_k1))+65))+1))).*((I_iNa_h(n-1,:) + .5*dt*I_iNa_h_k1));
  I_iK_n_k2 = (((.1-.01*(((I_v(n-1,:) + .5*dt*I_v_k1))+65))./(exp(1-.1*(((I_v(n-1,:) + .5*dt*I_v_k1))+65))-1))).*(1-((I_iK_n(n-1,:) + .5*dt*I_iK_n_k1)))-((.125*exp(-(((I_v(n-1,:) + .5*dt*I_v_k1))+65)/80))).*((I_iK_n(n-1,:) + .5*dt*I_iK_n_k1));
  E_I_iGABAa_s_k2 = -((E_I_iGABAa_s(n-1,:) + .5*dt*E_I_iGABAa_s_k1))./p.E_I_iGABAa_tauD + 1/2*(1+tanh(((I_v(n-1,:) + .5*dt*I_v_k1))/10)).*((1-((E_I_iGABAa_s(n-1,:) + .5*dt*E_I_iGABAa_s_k1)))/p.E_I_iGABAa_tauR);
  I_E_iAMPA_s_k2 = -((I_E_iAMPA_s(n-1,:) + .5*dt*I_E_iAMPA_s_k1))./p.I_E_iAMPA_tauD + 1/2*(1+tanh(((E_v(n-1,:) + .5*dt*E_v_k1))/10)).*((1-((I_E_iAMPA_s(n-1,:) + .5*dt*I_E_iAMPA_s_k1)))/p.I_E_iAMPA_tauR);

  E_v_k3 =p.E_Iapp+((((-p.E_iNa_gNa.*((E_iNa_m(n-1,:) + .5*dt*E_iNa_m_k2)).^3.*((E_iNa_h(n-1,:) + .5*dt*E_iNa_h_k2)).*(((E_v(n-1,:) + .5*dt*E_v_k2))-p.E_iNa_ENa))))+((((-p.E_iK_gK.*((E_iK_n(n-1,:) + .5*dt*E_iK_n_k2)).^4.*(((E_v(n-1,:) + .5*dt*E_v_k2))-p.E_iK_EK))))+((((-p.E_I_iGABAa_gGABAa.*(((E_I_iGABAa_s(n-1,:) + .5*dt*E_I_iGABAa_s_k2))*E_I_iGABAa_netcon).*(((E_v(n-1,:) + .5*dt*E_v_k2))-p.E_I_iGABAa_EGABAa)))))))+p.E_noise*randn(1,p.E_Npop);
  E_iNa_m_k3 = (((2.5-.1*(((E_v(n-1,:) + .5*dt*E_v_k2))+65))./(exp(2.5-.1*(((E_v(n-1,:) + .5*dt*E_v_k2))+65))-1))).*(1-((E_iNa_m(n-1,:) + .5*dt*E_iNa_m_k2)))-((4*exp(-(((E_v(n-1,:) + .5*dt*E_v_k2))+65)/18))).*((E_iNa_m(n-1,:) + .5*dt*E_iNa_m_k2));
  E_iNa_h_k3 = ((.07*exp(-(((E_v(n-1,:) + .5*dt*E_v_k2))+65)/20))).*(1-((E_iNa_h(n-1,:) + .5*dt*E_iNa_h_k2)))-((1./(exp(3-.1*(((E_v(n-1,:) + .5*dt*E_v_k2))+65))+1))).*((E_iNa_h(n-1,:) + .5*dt*E_iNa_h_k2));
  E_iK_n_k3 = (((.1-.01*(((E_v(n-1,:) + .5*dt*E_v_k2))+65))./(exp(1-.1*(((E_v(n-1,:) + .5*dt*E_v_k2))+65))-1))).*(1-((E_iK_n(n-1,:) + .5*dt*E_iK_n_k2)))-((.125*exp(-(((E_v(n-1,:) + .5*dt*E_v_k2))+65)/80))).*((E_iK_n(n-1,:) + .5*dt*E_iK_n_k2));
  I_v_k3 =p.I_Iapp+((((-p.I_iNa_gNa.*((I_iNa_m(n-1,:) + .5*dt*I_iNa_m_k2)).^3.*((I_iNa_h(n-1,:) + .5*dt*I_iNa_h_k2)).*(((I_v(n-1,:) + .5*dt*I_v_k2))-p.I_iNa_ENa))))+((((-p.I_iK_gK.*((I_iK_n(n-1,:) + .5*dt*I_iK_n_k2)).^4.*(((I_v(n-1,:) + .5*dt*I_v_k2))-p.I_iK_EK))))+((((-p.I_E_iAMPA_gAMPA.*(((I_E_iAMPA_s(n-1,:) + .5*dt*I_E_iAMPA_s_k2))*I_E_iAMPA_netcon).*(((I_v(n-1,:) + .5*dt*I_v_k2))-p.I_E_iAMPA_EAMPA)))))))+p.I_noise*randn(1,p.I_Npop);
  I_iNa_m_k3 = (((2.5-.1*(((I_v(n-1,:) + .5*dt*I_v_k2))+65))./(exp(2.5-.1*(((I_v(n-1,:) + .5*dt*I_v_k2))+65))-1))).*(1-((I_iNa_m(n-1,:) + .5*dt*I_iNa_m_k2)))-((4*exp(-(((I_v(n-1,:) + .5*dt*I_v_k2))+65)/18))).*((I_iNa_m(n-1,:) + .5*dt*I_iNa_m_k2));
  I_iNa_h_k3 = ((.07*exp(-(((I_v(n-1,:) + .5*dt*I_v_k2))+65)/20))).*(1-((I_iNa_h(n-1,:) + .5*dt*I_iNa_h_k2)))-((1./(exp(3-.1*(((I_v(n-1,:) + .5*dt*I_v_k2))+65))+1))).*((I_iNa_h(n-1,:) + .5*dt*I_iNa_h_k2));
  I_iK_n_k3 = (((.1-.01*(((I_v(n-1,:) + .5*dt*I_v_k2))+65))./(exp(1-.1*(((I_v(n-1,:) + .5*dt*I_v_k2))+65))-1))).*(1-((I_iK_n(n-1,:) + .5*dt*I_iK_n_k2)))-((.125*exp(-(((I_v(n-1,:) + .5*dt*I_v_k2))+65)/80))).*((I_iK_n(n-1,:) + .5*dt*I_iK_n_k2));
  E_I_iGABAa_s_k3 = -((E_I_iGABAa_s(n-1,:) + .5*dt*E_I_iGABAa_s_k2))./p.E_I_iGABAa_tauD + 1/2*(1+tanh(((I_v(n-1,:) + .5*dt*I_v_k2))/10)).*((1-((E_I_iGABAa_s(n-1,:) + .5*dt*E_I_iGABAa_s_k2)))/p.E_I_iGABAa_tauR);
  I_E_iAMPA_s_k3 = -((I_E_iAMPA_s(n-1,:) + .5*dt*I_E_iAMPA_s_k2))./p.I_E_iAMPA_tauD + 1/2*(1+tanh(((E_v(n-1,:) + .5*dt*E_v_k2))/10)).*((1-((I_E_iAMPA_s(n-1,:) + .5*dt*I_E_iAMPA_s_k2)))/p.I_E_iAMPA_tauR);

  t = t + .5*dt;
  E_v_k4 =p.E_Iapp+((((-p.E_iNa_gNa.*((E_iNa_m(n-1,:) + dt*E_iNa_m_k3)).^3.*((E_iNa_h(n-1,:) + dt*E_iNa_h_k3)).*(((E_v(n-1,:) + dt*E_v_k3))-p.E_iNa_ENa))))+((((-p.E_iK_gK.*((E_iK_n(n-1,:) + dt*E_iK_n_k3)).^4.*(((E_v(n-1,:) + dt*E_v_k3))-p.E_iK_EK))))+((((-p.E_I_iGABAa_gGABAa.*(((E_I_iGABAa_s(n-1,:) + dt*E_I_iGABAa_s_k3))*E_I_iGABAa_netcon).*(((E_v(n-1,:) + dt*E_v_k3))-p.E_I_iGABAa_EGABAa)))))))+p.E_noise*randn(1,p.E_Npop);
  E_iNa_m_k4 = (((2.5-.1*(((E_v(n-1,:) + dt*E_v_k3))+65))./(exp(2.5-.1*(((E_v(n-1,:) + dt*E_v_k3))+65))-1))).*(1-((E_iNa_m(n-1,:) + dt*E_iNa_m_k3)))-((4*exp(-(((E_v(n-1,:) + dt*E_v_k3))+65)/18))).*((E_iNa_m(n-1,:) + dt*E_iNa_m_k3));
  E_iNa_h_k4 = ((.07*exp(-(((E_v(n-1,:) + dt*E_v_k3))+65)/20))).*(1-((E_iNa_h(n-1,:) + dt*E_iNa_h_k3)))-((1./(exp(3-.1*(((E_v(n-1,:) + dt*E_v_k3))+65))+1))).*((E_iNa_h(n-1,:) + dt*E_iNa_h_k3));
  E_iK_n_k4 = (((.1-.01*(((E_v(n-1,:) + dt*E_v_k3))+65))./(exp(1-.1*(((E_v(n-1,:) + dt*E_v_k3))+65))-1))).*(1-((E_iK_n(n-1,:) + dt*E_iK_n_k3)))-((.125*exp(-(((E_v(n-1,:) + dt*E_v_k3))+65)/80))).*((E_iK_n(n-1,:) + dt*E_iK_n_k3));
  I_v_k4 =p.I_Iapp+((((-p.I_iNa_gNa.*((I_iNa_m(n-1,:) + dt*I_iNa_m_k3)).^3.*((I_iNa_h(n-1,:) + dt*I_iNa_h_k3)).*(((I_v(n-1,:) + dt*I_v_k3))-p.I_iNa_ENa))))+((((-p.I_iK_gK.*((I_iK_n(n-1,:) + dt*I_iK_n_k3)).^4.*(((I_v(n-1,:) + dt*I_v_k3))-p.I_iK_EK))))+((((-p.I_E_iAMPA_gAMPA.*(((I_E_iAMPA_s(n-1,:) + dt*I_E_iAMPA_s_k3))*I_E_iAMPA_netcon).*(((I_v(n-1,:) + dt*I_v_k3))-p.I_E_iAMPA_EAMPA)))))))+p.I_noise*randn(1,p.I_Npop);
  I_iNa_m_k4 = (((2.5-.1*(((I_v(n-1,:) + dt*I_v_k3))+65))./(exp(2.5-.1*(((I_v(n-1,:) + dt*I_v_k3))+65))-1))).*(1-((I_iNa_m(n-1,:) + dt*I_iNa_m_k3)))-((4*exp(-(((I_v(n-1,:) + dt*I_v_k3))+65)/18))).*((I_iNa_m(n-1,:) + dt*I_iNa_m_k3));
  I_iNa_h_k4 = ((.07*exp(-(((I_v(n-1,:) + dt*I_v_k3))+65)/20))).*(1-((I_iNa_h(n-1,:) + dt*I_iNa_h_k3)))-((1./(exp(3-.1*(((I_v(n-1,:) + dt*I_v_k3))+65))+1))).*((I_iNa_h(n-1,:) + dt*I_iNa_h_k3));
  I_iK_n_k4 = (((.1-.01*(((I_v(n-1,:) + dt*I_v_k3))+65))./(exp(1-.1*(((I_v(n-1,:) + dt*I_v_k3))+65))-1))).*(1-((I_iK_n(n-1,:) + dt*I_iK_n_k3)))-((.125*exp(-(((I_v(n-1,:) + dt*I_v_k3))+65)/80))).*((I_iK_n(n-1,:) + dt*I_iK_n_k3));
  E_I_iGABAa_s_k4 = -((E_I_iGABAa_s(n-1,:) + dt*E_I_iGABAa_s_k3))./p.E_I_iGABAa_tauD + 1/2*(1+tanh(((I_v(n-1,:) + dt*I_v_k3))/10)).*((1-((E_I_iGABAa_s(n-1,:) + dt*E_I_iGABAa_s_k3)))/p.E_I_iGABAa_tauR);
  I_E_iAMPA_s_k4 = -((I_E_iAMPA_s(n-1,:) + dt*I_E_iAMPA_s_k3))./p.I_E_iAMPA_tauD + 1/2*(1+tanh(((E_v(n-1,:) + dt*E_v_k3))/10)).*((1-((I_E_iAMPA_s(n-1,:) + dt*I_E_iAMPA_s_k3)))/p.I_E_iAMPA_tauR);

  % ------------------------------------------------------------
  % Update state variables:
  % ------------------------------------------------------------
  E_v(n,:) = E_v(n-1,:)+(dt/6)*(E_v_k1 + 2*(E_v_k2 + E_v_k3) + E_v_k4);
  E_iNa_m(n,:) = E_iNa_m(n-1,:)+(dt/6)*(E_iNa_m_k1 + 2*(E_iNa_m_k2 + E_iNa_m_k3) + E_iNa_m_k4);
  E_iNa_h(n,:) = E_iNa_h(n-1,:)+(dt/6)*(E_iNa_h_k1 + 2*(E_iNa_h_k2 + E_iNa_h_k3) + E_iNa_h_k4);
  E_iK_n(n,:) = E_iK_n(n-1,:)+(dt/6)*(E_iK_n_k1 + 2*(E_iK_n_k2 + E_iK_n_k3) + E_iK_n_k4);
  I_v(n,:) = I_v(n-1,:)+(dt/6)*(I_v_k1 + 2*(I_v_k2 + I_v_k3) + I_v_k4);
  I_iNa_m(n,:) = I_iNa_m(n-1,:)+(dt/6)*(I_iNa_m_k1 + 2*(I_iNa_m_k2 + I_iNa_m_k3) + I_iNa_m_k4);
  I_iNa_h(n,:) = I_iNa_h(n-1,:)+(dt/6)*(I_iNa_h_k1 + 2*(I_iNa_h_k2 + I_iNa_h_k3) + I_iNa_h_k4);
  I_iK_n(n,:) = I_iK_n(n-1,:)+(dt/6)*(I_iK_n_k1 + 2*(I_iK_n_k2 + I_iK_n_k3) + I_iK_n_k4);
  E_I_iGABAa_s(n,:) = E_I_iGABAa_s(n-1,:)+(dt/6)*(E_I_iGABAa_s_k1 + 2*(E_I_iGABAa_s_k2 + E_I_iGABAa_s_k3) + E_I_iGABAa_s_k4);
  I_E_iAMPA_s(n,:) = I_E_iAMPA_s(n-1,:)+(dt/6)*(I_E_iAMPA_s_k1 + 2*(I_E_iAMPA_s_k2 + I_E_iAMPA_s_k3) + I_E_iAMPA_s_k4);

  % ------------------------------------------------------------
  % Update monitors:
  % ------------------------------------------------------------
  E_I_iGABAa_IGABAa(n,:)=-p.E_I_iGABAa_gGABAa.*(E_I_iGABAa_s(n,:)*E_I_iGABAa_netcon).*(E_v(n,:)-p.E_I_iGABAa_EGABAa);
  I_E_iAMPA_IAMPA(n,:)=-p.I_E_iAMPA_gAMPA.*(I_E_iAMPA_s(n,:)*I_E_iAMPA_netcon).*(I_v(n,:)-p.I_E_iAMPA_EAMPA);
  n=n+1;
end

T=T(1:downsample_factor:ntime);

end
