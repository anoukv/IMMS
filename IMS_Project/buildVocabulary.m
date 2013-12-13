function [ ] = buildVocabulary(clusterSizes, numberOfTrainingImages, MaxIter)

start = clock;
% vocabularySize - this is the number of words in the vocabulary, also it
% is the number of clusters that we are looking for with k-means.
% numberOfTrainingImages - number of images used to build the vocabulary

folderNames = {'data/motorbikes_train', 'data/cars_train', 'data/faces_train', 'data/airplanes_train'};
extension = '*.jpg';

allDescriptors = zeros(0, 0);
for i = 1:size(folderNames, 2)
    folder = folderNames{i}
    imageNames = dir(fullfile(folder,extension));
    imageNames = {imageNames.name}';

    imageStrings = regexp([imageNames{:}],'(\d*)','match');
    imageNumbers = str2double(imageStrings);
    [~,sortedIndices] = sort(imageNumbers);
    sortedImageNames = imageNames(sortedIndices);
    
    if size(sortedImageNames,1) > numberOfTrainingImages
        images = sortedImageNames(1:numberOfTrainingImages);
    else
        images = sortedImageNames;
    end
    
    for im = 1:size(images, 1)
        desc = getFeaturesForImage( (fullfile(folder, images{im})) );

        allDescriptors = [ allDescriptors ; desc'];
    end
end

disp('Finished extracting descriptors');
disp(strcat('Found ', int2str(size(allDescriptors, 1)), ' descriptors'));
disp('Now clustering by kmeans');

allDescriptors = single(allDescriptors');

for i = 1:size(clusterSizes)
    disp(strcat('Clustering:  ', int2str(clusterSizes(i))));
    warning('off','all');
    clusters = vl_kmeans(allDescriptors, clusterSizes(i));
    warning('on','all');
    save(strcat('Vocabulary', int2str(clusterSizes(i))), 'clusters');
end

stop = clock;
disp(strcat('Seconds passed:', round(etime(stop, start))));


end

