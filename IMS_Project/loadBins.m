function [ allBins ] = loadBins( class, dens, colorspace)

folder = strcat('../../IMS_data/Binned/', class);
suffix = strcat('_', int2str(dens), '_', colorspace);
binNames = dir(fullfile(folder, strcat('*', suffix, '.mat')));
binNames = {binNames.name}';

for im = 1:size(binNames,1)
    bin = load(strcat('../../IMS_data/Binned/', class, '/', binNames{im}), 'bins');
    allBins(im, :) = bin.bins;
end

end

