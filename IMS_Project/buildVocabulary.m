function [ ] = buildVocabulary(clusterSizes, numberOfImagesPerClass, dens, colorspace)
start = clock;
disp(strcat(32,32,'Building vocabulary.'));

allDescriptors = loadAllDescriptors(numberOfImagesPerClass, dens, colorspace);
allDescriptors = single(allDescriptors);

disp(strcat(32,32,32,32, 'Found', 32, int2str(size(allDescriptors, 1)), ' descriptors'));

disp(strcat(32,32,32,32, 'Now clustering by kmeans'));

suffix = strcat('_', int2str(dens), '_', colorspace);
clusterSizes = clusterSizes';
for i = 1:size(clusterSizes,1)
    disp(strcat(32,32,32,32,32,32,'Clustering for size',32, int2str(clusterSizes(i))));
    warning('off','all');
    % clusters = vl_kmeans(allDescriptors, clusterSizes(i));
%     [~, clusters] = kmeans(allDescriptors, clusterSizes(i), 'start', 'cluster', 'options', statset('MaxIter', 20));
    [~, clusters] = kmeans(allDescriptors, clusterSizes(i), 'options', statset('MaxIter', 100));
    warning('on','all');
    save(strcat('../../IMS_data/Vocabulary_', int2str(clusterSizes(i)), 'x', int2str(numberOfImagesPerClass), suffix), 'clusters');
end

stop = clock;
disp(strcat(32,32,'Vocabulaties build in', 32, int2str(round(etime(stop, start))), 32, ' seconds.'));


end

