function ifr_compare_plot(data)

    clc;

    pool1 = 1:10;
    pool2 = 11:20;

    figure();
    patch([300 600 600 300], [-30 -30 +30 +30], [0.5 0.9 0.9]);hold("on");

    for i = 1:4
        
        t = data(i).time;
        x = data(i).deepE_V;
        raster = computeRaster(t, x);
        
        O1 = 5e2 * NWepanechnikovKernelRegrRaster(t, raster, pool1, 51, 10, 10);
        O2 = 5e2 * NWepanechnikovKernelRegrRaster(t, raster, pool2, 51, 10, 10);
        plot(t, O1 - O2, 'o');hold("on");

    end

    grid("on");title("iFR(O1) - iFR (O2)");xlabel("time (ms)");ylabel("iFR difference");
    legend("Target interval", "A&B", "only A", "only B", "No stimulus");
    fprintf("Done.\n");

end
