function [T,pop1_v]=solve_ode

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

% seed the random number generator
rng(p.random_seed);

% ------------------------------------------------------------
% Initial conditions:
% ------------------------------------------------------------
t=0; k=1;

% STATE_VARIABLES:
pop1_v = zeros(nsamp,p.pop1_Npop);
pop1_v(1,:) = zeros(1,p.pop1_Npop);

% ###########################################################
% Numerical integration:
% ###########################################################
n=2;
for k=2:ntime
  t=T(k-1);
  pop1_v_k1 =0;

  t = t + .5*dt;
  pop1_v_k2 =0;

  pop1_v_k3 =0;

  t = t + .5*dt;
  pop1_v_k4 =0;

  % ------------------------------------------------------------
  % Update state variables:
  % ------------------------------------------------------------
  pop1_v(n,:) = pop1_v(n-1,:)+(dt/6)*(pop1_v_k1 + 2*(pop1_v_k2 + pop1_v_k3) + pop1_v_k4);
  n=n+1;
end

T=T(1:downsample_factor:ntime);

end
