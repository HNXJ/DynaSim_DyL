function [] = savetrial(dsfname, dataset, n)

    clc;
    fprintf("Saving progress ...\n");
    x = zeros([4, size(data(1).deepE_V)]);
    
    for i = 1:4
        x(i, :, :) = data(i).deepE_V;
    end

    dataset(n+1).x = x;
    save(dsfname, 'dataset');
    fprintf("Done.\n");

end