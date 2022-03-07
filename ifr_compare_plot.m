function ifr_compare_plot(data, pool1, pool2)

    clc;

%     pool1 = 1:10;
%     pool2 = 11:20;

    figure();
    patch([80 180 180 80], [-30 -30 +30 +30], [0.5 0.9 0.9]);hold("on");

    for i = 1:4
        
        t = data(i).time;
        x = data(i).deepE_V;
%         plot_rasters(data(i));
        raster = computeRaster(t, x);
        
        disp(size(raster));
        O1 = 5e2 * NWepanechnikovKernelRegrRaster(t, raster, pool1, 25, 1, 1);
        O2 = 5e2 * NWepanechnikovKernelRegrRaster(t, raster, pool2, 25, 1, 1);
        plot(t, O1 - O2, 'o');hold("on");

    end

    grid("on");title("iFR(O1) - iFR (O2)");xlabel("time (ms)");ylabel("iFR difference");
    legend("Target interval", "A&B", "only A", "only B", "No stimulus");
    fprintf("Done.\n");

end
