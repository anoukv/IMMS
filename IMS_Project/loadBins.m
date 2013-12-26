function [ allBins ] = loadBins( class, dens, colorspace)

folder = strcat('../../IMS_data/Binned/', class);
suffix = strcat('_', int2str(dens), '_', colorspace);


<<<<<<< HEAD
suffix = strcat('_', int2str(dens), '_', colorspace);

binNames = dir(fullfile(folder, strcat('*', suffix, '.mat'));
=======
binNames = dir(fullfile(folder, strcat('*', suffix, '.mat')));
>>>>>>> 769747920bb7bc053d02aaa0f693acedaa164cf5
binNames = {binNames.name}';

allBins = zeros(0,0);

for im = 1:size(binNames,1)
    bin = load(strcat('../../IMS_data/Binned/', class, '/', binNames{im}), 'bins');
    allBins(im, :) = bin.bins;
end

end

