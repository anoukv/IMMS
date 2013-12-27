function [ data, truth ] = generateData( class, trainOrTest, dense, colorspace, trainingSize )

% if we are not doing this for training data, we want to get all test
% images, not just 'trainingSize', so we will change this parameter here
if strcmp(trainOrTest, 'train')
    classNames = {'motorbikes_train', 'cars_train', 'faces_train', 'airplanes_train'};
else
    classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};
    trainingSize = min(50, trainingSize);
end

negativeExamples = zeros(0, 0);

% load all bins from the classes other than class to form the set of
% negative examples
for i = 1:size(classNames, 2)
    if strcmp(classNames{i},class) == 0
        bins = loadBins(classNames{i}, dense, colorspace);
        if size(bins,1) > trainingSize
            bins = bins(1:trainingSize, :);
        end
        startRow = size(negativeExamples, 1)+1;
        endRow = startRow + size(bins, 1)-1;
        negativeExamples(startRow:endRow, :) = bins;
    end
end

% load the positive bins
positiveExamples = loadBins(class, dense, colorspace);
if size(positiveExamples,1) > trainingSize
    positiveExamples = positiveExamples(1:trainingSize, :);
end

% construct the groundtruth vector and the data matrix
truth = [ones(size(positiveExamples, 1), 1); -1 * ones(size(negativeExamples, 1), 1)];
data = [positiveExamples;negativeExamples];

end

