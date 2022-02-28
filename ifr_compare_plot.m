
function ifr_compare_plot(data)

clc;

pool1 = 1:10;
pool2 = 11:20;

figure();
patch([300 600 600 300], [-20 -20 +20 +20], [0.5 0.9 0.9]);hold("on");

% x = dataset(1).x;
% n = size(dataset, 2);
% for i = 2:n
%    
%     x = x + dataset(i).x;
%     
% end
% x = x / n;

for i = 1:4
    t = data(i).time;
    x = data(i).deepE_V;
    raster = computeRaster(t, x);
%     raster = computeRaster(t, squeeze(x(i, :, :)));

    O1 = 1e3 * NWepanechnikovKernelRegrRaster(t, raster, pool1, 51, 10, 10);
    O2 = 1e3 * NWepanechnikovKernelRegrRaster(t, raster, pool2, 51, 10, 10);
    
    plot(t, O1 - O2, 'o');hold("on");

end

grid("on");title("iFR(O1) - iFR (O2)");xlabel("time (ms)");ylabel("iFR difference");
legend("Target interval", "A&B", "only A", "only B", "No stimulus");
fprintf("Done.\n");

end