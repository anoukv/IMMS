function [ Result ] = buildVocabulary(vocabularySize, numberOfTrainingImages)

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
    images = sortedImageNames(1:numberOfTrainingImages);
    
    for im = 1:size(images, 1)
        I = im2single(rgb2gray(imread(fullfile(folder,images{im}))));
        [frames, desc] = vl_sift(I);
        desc = desc';
        for count = 1:size(desc, 1)
            allDescriptors(size(allDescriptors, 1)+1, :) = desc(count, :);
        end
    end
end
disp('Finished extracting descriptors');
size(allDescriptors, 1)
disp('Now clustering by kmeans');
Result = kmeans(allDescriptors, vocabularySize);



end

