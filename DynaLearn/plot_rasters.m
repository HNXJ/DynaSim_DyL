function plot_rasters(data,pops,var,colors,marker)
% e.g.) plot_rasters(dsSimulate('HH'),'HH','V','b','o');

% if nargin<2, error('must specify populations to plot'); end
if nargin<2 || isempty(pops), pops={data(1).model.specification.populations.name}; end
if ~iscell(pops), pops={pops}; end
if nargin<3 || isempty(var), var='V'; end
if nargin<4 || isempty(colors), colors='brkgmcybrkgmcybrkgmcybrkgmcy'; end
if nargin<5 || isempty(marker), marker='o'; end % marker: 'line' or 'o'
% if ~isfield(data,[pops{1} '_' var '_spike_times'])
  data=dsCalcFR(data,'variable',var);
% end

if length(data)>1
  figure('position',[370 200 1140 680]);
end
for i=1:length(data)
  if length(data)>1, subplot(length(data),1,i); end
  pos=0;
  poss=[];
  for p=1:length(pops)
    poss=[poss pos];
    color=colors(p);
    allspks=data(i).([pops{p} '_' var '_spike_times']);
    for j=1:length(allspks)
      spks=allspks{j};
      for k=1:length(spks)
        if strcmp(marker,'line')
          line([spks(k) spks(k)],[pos pos+1],'linestyle','-','color',color,'linewidth',2);
        else
          plot(spks(k),pos,[color 'o']); hold on
        end
      end
      pos=pos+1;
    end
    pos=pos+1;
  end
  set(gca,'ytick',poss,'yticklabel',pops);
  %axis tight; %xlim(tlims);  
end
xlim([data(1).time(1) data(1).time(end)]);
