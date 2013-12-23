function [ ] = buildVocabulary(clusterSizes, numberOfImagesPerClass)
start = clock;
disp('Building vocabulary.');

allDescriptors = loadAllDescriptors(numberOfImagesPerClass);
allDescriptors = single(allDescriptors);

disp(strcat(32,32, 'Found', 32, int2str(size(allDescriptors, 1)), ' descriptors'));

disp(strcat(32,32, 'Now clustering by kmeans'));

for i = 1:size(clusterSizes,1)
    disp(strcat(32,32,32,32,'Clustering for size',32, int2str(clusterSizes(i))));
    warning('off','all');
    % clusters = vl_kmeans(allDescriptors, clusterSizes(i));
    [~, clusters] = kmeans(allDescriptors, clusterSizes(i), 'start', 'cluster', 'options', statset('MaxIter', 20));
    warning('on','all');
    save(strcat('../../IMS_data/Vocabulary_', int2str(clusterSizes(i)), 'x', int2str(numberOfImagesPerClass)), 'clusters');
end

stop = clock;
disp(strcat('Vocabulaties build in', 32, int2str(round(etime(stop, start))), 32, ' seconds.'));


end

