function [T,pop1_u,pop1_w,pop1_v,]=solve_ode

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
% Initial conditions:
% ------------------------------------------------------------
t=0; k=1;

% STATE_VARIABLES:
pop1_u = zeros(nsamp,p.pop1_Npop);
  pop1_u(1,:) = 1.0 * ones(1,p.pop1_Npop);
pop1_w = zeros(nsamp,p.pop1_Npop);
  pop1_w(1,:) = 0.0 * ones(1,p.pop1_Npop);
pop1_v = zeros(nsamp,p.pop1_Npop);
  pop1_v(1,:) = zeros(1,p.pop1_Npop);

% MONITORS:

% ###########################################################
% Numerical integration:
% ###########################################################
n=2;
for k=2:ntime
  t=T(k-1);
  pop1_u_k1 =pop1_w(n-1);
  pop1_w_k1 =1;
  pop1_v_k1 =pop1_u(n-1)-0+p.pop1_noise*randn(1,p.pop1_Npop);

  t = t + .5*dt;
  pop1_u_k2 =((pop1_w(n-1) + .5*dt*pop1_w_k1));
  pop1_w_k2 =1;
  pop1_v_k2 =((pop1_u(n-1) + .5*dt*pop1_u_k1))-0+p.pop1_noise*randn(1,p.pop1_Npop);

  pop1_u_k3 =((pop1_w(n-1) + .5*dt*pop1_w_k2));
  pop1_w_k3 =1;
  pop1_v_k3 =((pop1_u(n-1) + .5*dt*pop1_u_k2))-0+p.pop1_noise*randn(1,p.pop1_Npop);

  t = t + .5*dt;
  pop1_u_k4 =((pop1_w(n-1) + dt*pop1_w_k3));
  pop1_w_k4 =1;
  pop1_v_k4 =((pop1_u(n-1) + dt*pop1_u_k3))-0+p.pop1_noise*randn(1,p.pop1_Npop);

  % ------------------------------------------------------------
  % Update state variables:
  % ------------------------------------------------------------
  pop1_u(n) = pop1_u(n-1)+(dt/6)*(pop1_u_k1 + 2*(pop1_u_k2 + pop1_u_k3) + pop1_u_k4);
  pop1_w(n) = pop1_w(n-1)+(dt/6)*(pop1_w_k1 + 2*(pop1_w_k2 + pop1_w_k3) + pop1_w_k4);
  pop1_v(n) = pop1_v(n-1)+(dt/6)*(pop1_v_k1 + 2*(pop1_v_k2 + pop1_v_k3) + pop1_v_k4);

  % ------------------------------------------------------------
  % Update monitors:
  % ------------------------------------------------------------
  n=n+1;
end

T=T(1:downsample_factor:ntime);

end
