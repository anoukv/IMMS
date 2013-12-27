function [ ] = buildVocabulary(clusterSizes, numberOfImagesPerClass, dens, colorspace)
start = clock;

allDescriptors = loadAllDescriptors(numberOfImagesPerClass, dens, colorspace);
allDescriptors = single(allDescriptors);

suffix = strcat('_', int2str(dens), '_', colorspace);
clusterSizes = clusterSizes';
for i = 1:size(clusterSizes,1)
    
    % clusters = vl_kmeans(allDescriptors, clusterSizes(i));
    % [~, clusters] = kmeans(allDescriptors, clusterSizes(i), 'options', statset('MaxIter', 100));
    % [~, clusters] = kmeans(allDescriptors, clusterSizes(i), 'start', 'cluster', 'options', statset('MaxIter', 20));
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

