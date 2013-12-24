function [ allBins ] = loadBins( class )

folder = strcat('../../IMS_data/Binned/', class);

binNames = dir(fullfile(folder, '*.mat'));
binNames = {binNames.name}';

allBins = zeros(0,0);
for im = 1:size(binNames,1)
    bin = load(strcat('../../IMS_data/Binned/', class, '/', binNames{im}), 'bins');
    allBins(im, :) = bin.bins;
end

end

