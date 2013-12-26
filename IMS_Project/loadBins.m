function [ allBins ] = loadBins( class, dens, colorspace)

folder = strcat('../../IMS_data/Binned/', class);

binNames = dir(fullfile(folder, '*.mat'));
binNames = {binNames.name}';

allBins = zeros(0,0);

suffix = strcat('_', int2str(dens), '_', colorspace);
for im = 1:size(binNames,1)
    bin = load(strcat('../../IMS_data/Binned/', class, '/', binNames{im}, suffix), 'bins');
    allBins(im, :) = bin.bins;
end

end

