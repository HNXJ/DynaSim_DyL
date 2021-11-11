function [T,pop1_u,pop1_v]=solve_ode

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
  pop1_u(1,:) = .5 * ones(1,p.pop1_Npop);
pop1_v = zeros(nsamp,p.pop1_Npop);
  pop1_v(1,:) = zeros(1,p.pop1_Npop);

% ###########################################################
% Numerical integration:
% ###########################################################
n=2;
for k=2:ntime
  t=T(k-1);
  pop1_u_k1 =pop1_v(n-1);
  pop1_v_k1 =-p.pop1_w0^2*pop1_u(n-1)-2*p.pop1_l*p.pop1_w0*pop1_v(n-1)+(1/p.pop1_m)*p.pop1_F0*sin(2*pi*p.pop1_f*t);

  t = t + .5*dt;
  pop1_u_k2 =((pop1_v(n-1) + .5*dt*pop1_v_k1));
  pop1_v_k2 =-p.pop1_w0^2*((pop1_u(n-1) + .5*dt*pop1_u_k1))-2*p.pop1_l*p.pop1_w0*((pop1_v(n-1) + .5*dt*pop1_v_k1))+(1/p.pop1_m)*p.pop1_F0*sin(2*pi*p.pop1_f*t);

  pop1_u_k3 =((pop1_v(n-1) + .5*dt*pop1_v_k2));
  pop1_v_k3 =-p.pop1_w0^2*((pop1_u(n-1) + .5*dt*pop1_u_k2))-2*p.pop1_l*p.pop1_w0*((pop1_v(n-1) + .5*dt*pop1_v_k2))+(1/p.pop1_m)*p.pop1_F0*sin(2*pi*p.pop1_f*t);

  t = t + .5*dt;
  pop1_u_k4 =((pop1_v(n-1) + dt*pop1_v_k3));
  pop1_v_k4 =-p.pop1_w0^2*((pop1_u(n-1) + dt*pop1_u_k3))-2*p.pop1_l*p.pop1_w0*((pop1_v(n-1) + dt*pop1_v_k3))+(1/p.pop1_m)*p.pop1_F0*sin(2*pi*p.pop1_f*t);

  % ------------------------------------------------------------
  % Update state variables:
  % ------------------------------------------------------------
  pop1_u(n) = pop1_u(n-1)+(dt/6)*(pop1_u_k1 + 2*(pop1_u_k2 + pop1_u_k3) + pop1_u_k4);
  pop1_v(n) = pop1_v(n-1)+(dt/6)*(pop1_v_k1 + 2*(pop1_v_k2 + pop1_v_k3) + pop1_v_k4);
  n=n+1;
end

T=T(1:downsample_factor:ntime);

end
