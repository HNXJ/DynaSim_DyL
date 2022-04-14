function [iFR,itime]=CalciFR(data,kwidth,Ts,roi,variable)
% [iFR,itime]=CalciFR(data,kwidth,Ts,roi,variable)
% purpose: calculate instantaneous firing rate
% inputs:
%   kwidth: [.006] sec, width of gaussian for kernel regression
%   Ts: [.003] sec, set to this effective time step for rate process before regression
%   roi: indices of cells over which to calculate iFR (default: all cells)
%   variable: name of field with voltage trace from which to extract spikes (default: first element of .labels)
if nargin<2, kwidth=.006; end % s, width of gaussian for kernel regression
if nargin<3, Ts=.003; end     % s, set to this effective time step for rate process before regression
if nargin<4, roi=[]; end
if nargin<5, variable=data(1).labels{1}; end
  
for j=1:length(data)
  dat=data(j);
  dat=dsCalcFR(dat,'variable',variable);
  spks=dat.([variable '_spike_times']);
  ncells=length(spks);
  raster=[];
  for i=1:ncells
    nspks=length(spks{i});
    spkmat=zeros(nspks,2);
    spkmat(:,1)=spks{i}/1000;
    spkmat(:,2)=i;
    raster=[raster;spkmat];
  end
  t=double(dat.time/1000);
  if isempty(roi), roi=1:ncells; end
  [ifr,itime]=NWgaussKernelRegr(t,raster,roi,kwidth,Ts);
  if j==1
    iFR=zeros(length(data),length(itime));
  end
  iFR(j,:)=ifr;
end
