function [ ] = buildVocabulary(numberOfClusters, numberOfTrainingImages, MaxIter)

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
        thisImage = imread(fullfile(folder, images{im}));
        if ndims(thisImage) == 3    % Not all images are coloured.
            thisImage = rgb2gray(thisImage);
        end
        I = im2single(thisImage);
        
        [~, desc] = vl_sift(I);
        desc = desc';
        for count = 1:size(desc, 1)
            allDescriptors(size(allDescriptors, 1)+1, :) = desc(count, :);
        end
    end
end

disp('Finished extracting descriptors');
size(allDescriptors, 1)
disp('Now clustering by kmeans');

warning('off','all');
[~, clusters] = kmeans(allDescriptors, numberOfClusters, 'Options', statset('MaxIter', MaxIter));
warning('on','all');

save('Vocabulary', 'clusters');

stop = clock;

disp('Seconds passed:');
round(etime(stop, start))

end

