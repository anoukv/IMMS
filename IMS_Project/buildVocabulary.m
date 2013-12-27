function [ ] = buildVocabulary(clusterSizes, numberOfImagesPerClass, dens, colorspace)
% Builds a vocabulary of words (clusters) for specific settings.
%

start = clock;

% load all descriptors and change them to singles
allDescriptors = loadAllDescriptors(numberOfImagesPerClass, dens, colorspace);
allDescriptors = single(allDescriptors);

suffix = strcat('_', int2str(dens), '_', colorspace);
clusterSizes = clusterSizes';

% for every specified clustersize try to run kmeans
% sometimes it will return an empty cluster error, we catch this error and
% call this method again, hoping for better luck next time...
for i = 1:size(clusterSizes,1)
    try
        warning('off','all');
        clusters = vl_kmeans(allDescriptors', clusterSizes(i), 'initialization', 'PLUSPLUS', 'algorithm', 'elkan');
        clusters = clusters';
        warning('on','all');
        save(strcat('../../IMS_data/Vocabulary_', int2str(clusterSizes(i)), 'x', int2str(numberOfImagesPerClass), suffix), 'clusters');
    catch
        disp('Catching empty cluster error...');
        buildVocabulary(clusterSizes(i), numberOfImagesPerClass, dens, colorspace)
end

stop = clock;

end

