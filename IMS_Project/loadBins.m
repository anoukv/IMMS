function [ allBins ] = loadBins( class )

folder = strcat('../../IMS_data/Binned/', class);
binNames = dir(fullfile(folder, '*.mat'));
binNames = {binNames.name}';

n = size(binNames, 1);
len = 0;
for im = 1:n
    bin = load(strcat('../../IMS_data/Binned/', class, '/', binNames{im}), 'bins');
    len = len + size(bin.bins,2);
    allBins(im, :) = bin.bins;
end

end

