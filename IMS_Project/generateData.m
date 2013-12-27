function [ data, truth ] = generateData( class, trainOrTest, dense, colorspace, trainingSize )

if strcmp(trainOrTest, 'train')
    classNames = {'motorbikes_train', 'cars_train', 'faces_train', 'airplanes_train'};
else
    classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};
    trainingSize = min(50, trainingSize);
end

negativeExamples = zeros(0, 0);

for i = 1:size(classNames, 2)
    if strcmp(classNames{i},class) == 0
        bins = loadBins(classNames{i}, dense, colorspace);
        bins = bins(1:trainingSize, :);
        startRow = size(negativeExamples, 1)+1;
        endRow = startRow + size(bins, 1)-1;
        negativeExamples(startRow:endRow, :) = bins;
    end
end
positiveExamples = loadBins(class, dense, colorspace);
positiveExamples = positiveExamples(1:trainingSize, :);

truth = [ones(size(positiveExamples, 1), 1); -1 * ones(size(negativeExamples, 1), 1)];
data = [positiveExamples;negativeExamples];

end

