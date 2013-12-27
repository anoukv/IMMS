function [ ] = buildVocabulary(clusterSizes, numberOfImagesPerClass, dens, colorspace)
% Builds a vocabulary of words (clusters) for specific settings.
%

start = clock;

allDescriptors = loadAllDescriptors(numberOfImagesPerClass, dens, colorspace);
allDescriptors = single(allDescriptors);

suffix = strcat('_', int2str(dens), '_', colorspace);
clusterSizes = clusterSizes';
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

