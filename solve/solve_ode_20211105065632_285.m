function [T,P1_v,P1_iNa_m,P1_iNa_h,P1_iK_n,P1_P1_iGABAa_s,P1_P1_iGABAa_IGABAa,P1_P1_iGABAa_netcon]=solve_ode

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
P1_P1_iGABAa_netcon = [+1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00; +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00   +1.000000000000000e+00];

% ------------------------------------------------------------
% Initial conditions:
% ------------------------------------------------------------
t=0; k=1;

% STATE_VARIABLES:
P1_v = zeros(nsamp,p.P1_Npop);
  P1_v(1,:) = zeros(1,p.P1_Npop);
P1_iNa_m = zeros(nsamp,p.P1_Npop);
  P1_iNa_m(1,:) = p.P1_iNa_m_IC+p.P1_iNa_IC_noise*rand(1,p.P1_Npop);
P1_iNa_h = zeros(nsamp,p.P1_Npop);
  P1_iNa_h(1,:) = p.P1_iNa_h_IC+p.P1_iNa_IC_noise*rand(1,p.P1_Npop);
P1_iK_n = zeros(nsamp,p.P1_Npop);
  P1_iK_n(1,:) = p.P1_iK_n_IC+p.P1_iK_IC_noise*rand(1,p.P1_Npop);
P1_P1_iGABAa_s = zeros(nsamp,p.P1_Npop);
  P1_P1_iGABAa_s(1,:) =  p.P1_P1_iGABAa_IC+p.P1_P1_iGABAa_IC_noise.*rand(1,p.P1_Npop);

% MONITORS:
P1_P1_iGABAa_IGABAa = zeros(nsamp,p.P1_Npop);
  P1_P1_iGABAa_IGABAa(1,:)=-p.P1_P1_iGABAa_gGABAa.*(P1_P1_iGABAa_s(1,:)*P1_P1_iGABAa_netcon).*(P1_v(1,:)-p.P1_P1_iGABAa_EGABAa);

% ###########################################################
% Numerical integration:
% ###########################################################
n=2;
for k=2:ntime
  t=T(k-1);
  P1_v_k1 =p.P1_Iapp+((((-p.P1_iNa_gNa.*P1_iNa_m(n-1,:).^3.*P1_iNa_h(n-1,:).*(P1_v(n-1,:)-p.P1_iNa_ENa))))+((((-p.P1_iK_gK.*P1_iK_n(n-1,:).^4.*(P1_v(n-1,:)-p.P1_iK_EK))))+((((-p.P1_P1_iGABAa_gGABAa.*(P1_P1_iGABAa_s(n-1,:)*P1_P1_iGABAa_netcon).*(P1_v(n-1,:)-p.P1_P1_iGABAa_EGABAa)))))))+p.P1_noise*randn(1,p.P1_Npop);
  P1_iNa_m_k1 = (((2.5-.1*(P1_v(n-1,:)+65))./(exp(2.5-.1*(P1_v(n-1,:)+65))-1))).*(1-P1_iNa_m(n-1,:))-((4*exp(-(P1_v(n-1,:)+65)/18))).*P1_iNa_m(n-1,:);
  P1_iNa_h_k1 = ((.07*exp(-(P1_v(n-1,:)+65)/20))).*(1-P1_iNa_h(n-1,:))-((1./(exp(3-.1*(P1_v(n-1,:)+65))+1))).*P1_iNa_h(n-1,:);
  P1_iK_n_k1 = (((.1-.01*(P1_v(n-1,:)+65))./(exp(1-.1*(P1_v(n-1,:)+65))-1))).*(1-P1_iK_n(n-1,:))-((.125*exp(-(P1_v(n-1,:)+65)/80))).*P1_iK_n(n-1,:);
  P1_P1_iGABAa_s_k1 = -P1_P1_iGABAa_s(n-1,:)./p.P1_P1_iGABAa_tauD + 1/2*(1+tanh(P1_v(n-1,:)/10)).*((1-P1_P1_iGABAa_s(n-1,:))/p.P1_P1_iGABAa_tauR);

  t = t + .5*dt;
  P1_v_k2 =p.P1_Iapp+((((-p.P1_iNa_gNa.*((P1_iNa_m(n-1,:) + .5*dt*P1_iNa_m_k1)).^3.*((P1_iNa_h(n-1,:) + .5*dt*P1_iNa_h_k1)).*(((P1_v(n-1,:) + .5*dt*P1_v_k1))-p.P1_iNa_ENa))))+((((-p.P1_iK_gK.*((P1_iK_n(n-1,:) + .5*dt*P1_iK_n_k1)).^4.*(((P1_v(n-1,:) + .5*dt*P1_v_k1))-p.P1_iK_EK))))+((((-p.P1_P1_iGABAa_gGABAa.*(((P1_P1_iGABAa_s(n-1,:) + .5*dt*P1_P1_iGABAa_s_k1))*P1_P1_iGABAa_netcon).*(((P1_v(n-1,:) + .5*dt*P1_v_k1))-p.P1_P1_iGABAa_EGABAa)))))))+p.P1_noise*randn(1,p.P1_Npop);
  P1_iNa_m_k2 = (((2.5-.1*(((P1_v(n-1,:) + .5*dt*P1_v_k1))+65))./(exp(2.5-.1*(((P1_v(n-1,:) + .5*dt*P1_v_k1))+65))-1))).*(1-((P1_iNa_m(n-1,:) + .5*dt*P1_iNa_m_k1)))-((4*exp(-(((P1_v(n-1,:) + .5*dt*P1_v_k1))+65)/18))).*((P1_iNa_m(n-1,:) + .5*dt*P1_iNa_m_k1));
  P1_iNa_h_k2 = ((.07*exp(-(((P1_v(n-1,:) + .5*dt*P1_v_k1))+65)/20))).*(1-((P1_iNa_h(n-1,:) + .5*dt*P1_iNa_h_k1)))-((1./(exp(3-.1*(((P1_v(n-1,:) + .5*dt*P1_v_k1))+65))+1))).*((P1_iNa_h(n-1,:) + .5*dt*P1_iNa_h_k1));
  P1_iK_n_k2 = (((.1-.01*(((P1_v(n-1,:) + .5*dt*P1_v_k1))+65))./(exp(1-.1*(((P1_v(n-1,:) + .5*dt*P1_v_k1))+65))-1))).*(1-((P1_iK_n(n-1,:) + .5*dt*P1_iK_n_k1)))-((.125*exp(-(((P1_v(n-1,:) + .5*dt*P1_v_k1))+65)/80))).*((P1_iK_n(n-1,:) + .5*dt*P1_iK_n_k1));
  P1_P1_iGABAa_s_k2 = -((P1_P1_iGABAa_s(n-1,:) + .5*dt*P1_P1_iGABAa_s_k1))./p.P1_P1_iGABAa_tauD + 1/2*(1+tanh(((P1_v(n-1,:) + .5*dt*P1_v_k1))/10)).*((1-((P1_P1_iGABAa_s(n-1,:) + .5*dt*P1_P1_iGABAa_s_k1)))/p.P1_P1_iGABAa_tauR);

  P1_v_k3 =p.P1_Iapp+((((-p.P1_iNa_gNa.*((P1_iNa_m(n-1,:) + .5*dt*P1_iNa_m_k2)).^3.*((P1_iNa_h(n-1,:) + .5*dt*P1_iNa_h_k2)).*(((P1_v(n-1,:) + .5*dt*P1_v_k2))-p.P1_iNa_ENa))))+((((-p.P1_iK_gK.*((P1_iK_n(n-1,:) + .5*dt*P1_iK_n_k2)).^4.*(((P1_v(n-1,:) + .5*dt*P1_v_k2))-p.P1_iK_EK))))+((((-p.P1_P1_iGABAa_gGABAa.*(((P1_P1_iGABAa_s(n-1,:) + .5*dt*P1_P1_iGABAa_s_k2))*P1_P1_iGABAa_netcon).*(((P1_v(n-1,:) + .5*dt*P1_v_k2))-p.P1_P1_iGABAa_EGABAa)))))))+p.P1_noise*randn(1,p.P1_Npop);
  P1_iNa_m_k3 = (((2.5-.1*(((P1_v(n-1,:) + .5*dt*P1_v_k2))+65))./(exp(2.5-.1*(((P1_v(n-1,:) + .5*dt*P1_v_k2))+65))-1))).*(1-((P1_iNa_m(n-1,:) + .5*dt*P1_iNa_m_k2)))-((4*exp(-(((P1_v(n-1,:) + .5*dt*P1_v_k2))+65)/18))).*((P1_iNa_m(n-1,:) + .5*dt*P1_iNa_m_k2));
  P1_iNa_h_k3 = ((.07*exp(-(((P1_v(n-1,:) + .5*dt*P1_v_k2))+65)/20))).*(1-((P1_iNa_h(n-1,:) + .5*dt*P1_iNa_h_k2)))-((1./(exp(3-.1*(((P1_v(n-1,:) + .5*dt*P1_v_k2))+65))+1))).*((P1_iNa_h(n-1,:) + .5*dt*P1_iNa_h_k2));
  P1_iK_n_k3 = (((.1-.01*(((P1_v(n-1,:) + .5*dt*P1_v_k2))+65))./(exp(1-.1*(((P1_v(n-1,:) + .5*dt*P1_v_k2))+65))-1))).*(1-((P1_iK_n(n-1,:) + .5*dt*P1_iK_n_k2)))-((.125*exp(-(((P1_v(n-1,:) + .5*dt*P1_v_k2))+65)/80))).*((P1_iK_n(n-1,:) + .5*dt*P1_iK_n_k2));
  P1_P1_iGABAa_s_k3 = -((P1_P1_iGABAa_s(n-1,:) + .5*dt*P1_P1_iGABAa_s_k2))./p.P1_P1_iGABAa_tauD + 1/2*(1+tanh(((P1_v(n-1,:) + .5*dt*P1_v_k2))/10)).*((1-((P1_P1_iGABAa_s(n-1,:) + .5*dt*P1_P1_iGABAa_s_k2)))/p.P1_P1_iGABAa_tauR);

  t = t + .5*dt;
  P1_v_k4 =p.P1_Iapp+((((-p.P1_iNa_gNa.*((P1_iNa_m(n-1,:) + dt*P1_iNa_m_k3)).^3.*((P1_iNa_h(n-1,:) + dt*P1_iNa_h_k3)).*(((P1_v(n-1,:) + dt*P1_v_k3))-p.P1_iNa_ENa))))+((((-p.P1_iK_gK.*((P1_iK_n(n-1,:) + dt*P1_iK_n_k3)).^4.*(((P1_v(n-1,:) + dt*P1_v_k3))-p.P1_iK_EK))))+((((-p.P1_P1_iGABAa_gGABAa.*(((P1_P1_iGABAa_s(n-1,:) + dt*P1_P1_iGABAa_s_k3))*P1_P1_iGABAa_netcon).*(((P1_v(n-1,:) + dt*P1_v_k3))-p.P1_P1_iGABAa_EGABAa)))))))+p.P1_noise*randn(1,p.P1_Npop);
  P1_iNa_m_k4 = (((2.5-.1*(((P1_v(n-1,:) + dt*P1_v_k3))+65))./(exp(2.5-.1*(((P1_v(n-1,:) + dt*P1_v_k3))+65))-1))).*(1-((P1_iNa_m(n-1,:) + dt*P1_iNa_m_k3)))-((4*exp(-(((P1_v(n-1,:) + dt*P1_v_k3))+65)/18))).*((P1_iNa_m(n-1,:) + dt*P1_iNa_m_k3));
  P1_iNa_h_k4 = ((.07*exp(-(((P1_v(n-1,:) + dt*P1_v_k3))+65)/20))).*(1-((P1_iNa_h(n-1,:) + dt*P1_iNa_h_k3)))-((1./(exp(3-.1*(((P1_v(n-1,:) + dt*P1_v_k3))+65))+1))).*((P1_iNa_h(n-1,:) + dt*P1_iNa_h_k3));
  P1_iK_n_k4 = (((.1-.01*(((P1_v(n-1,:) + dt*P1_v_k3))+65))./(exp(1-.1*(((P1_v(n-1,:) + dt*P1_v_k3))+65))-1))).*(1-((P1_iK_n(n-1,:) + dt*P1_iK_n_k3)))-((.125*exp(-(((P1_v(n-1,:) + dt*P1_v_k3))+65)/80))).*((P1_iK_n(n-1,:) + dt*P1_iK_n_k3));
  P1_P1_iGABAa_s_k4 = -((P1_P1_iGABAa_s(n-1,:) + dt*P1_P1_iGABAa_s_k3))./p.P1_P1_iGABAa_tauD + 1/2*(1+tanh(((P1_v(n-1,:) + dt*P1_v_k3))/10)).*((1-((P1_P1_iGABAa_s(n-1,:) + dt*P1_P1_iGABAa_s_k3)))/p.P1_P1_iGABAa_tauR);

  % ------------------------------------------------------------
  % Update state variables:
  % ------------------------------------------------------------
  P1_v(n,:) = P1_v(n-1,:)+(dt/6)*(P1_v_k1 + 2*(P1_v_k2 + P1_v_k3) + P1_v_k4);
  P1_iNa_m(n,:) = P1_iNa_m(n-1,:)+(dt/6)*(P1_iNa_m_k1 + 2*(P1_iNa_m_k2 + P1_iNa_m_k3) + P1_iNa_m_k4);
  P1_iNa_h(n,:) = P1_iNa_h(n-1,:)+(dt/6)*(P1_iNa_h_k1 + 2*(P1_iNa_h_k2 + P1_iNa_h_k3) + P1_iNa_h_k4);
  P1_iK_n(n,:) = P1_iK_n(n-1,:)+(dt/6)*(P1_iK_n_k1 + 2*(P1_iK_n_k2 + P1_iK_n_k3) + P1_iK_n_k4);
  P1_P1_iGABAa_s(n,:) = P1_P1_iGABAa_s(n-1,:)+(dt/6)*(P1_P1_iGABAa_s_k1 + 2*(P1_P1_iGABAa_s_k2 + P1_P1_iGABAa_s_k3) + P1_P1_iGABAa_s_k4);

  % ------------------------------------------------------------
  % Update monitors:
  % ------------------------------------------------------------
  P1_P1_iGABAa_IGABAa(n,:)=-p.P1_P1_iGABAa_gGABAa.*(P1_P1_iGABAa_s(n,:)*P1_P1_iGABAa_netcon).*(P1_v(n,:)-p.P1_P1_iGABAa_EGABAa);
  n=n+1;
end

T=T(1:downsample_factor:ntime);

end
