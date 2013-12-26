function [ data, truth ] = generateData( class, trainOrTest, dense, colorspace )

if strcmp(trainOrTest, 'train')
    classNames = {'motorbikes_train', 'cars_train', 'faces_train', 'airplanes_train'};
else
    classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};
end

negativeExamples = zeros(0, 0);

for i = 1:size(classNames, 2)
    if strcmp(classNames{i},class) == 0
        bins = loadBins(classNames{i}, dense, colorspace);
        startRow = size(negativeExamples, 1)+1;
        endRow = startRow + size(bins, 1)-1;
        negativeExamples(startRow:endRow, :) = bins;
    end
end

positiveExamples = loadBins(class, dense, colorspace);

truth = [ones(size(positiveExamples, 1), 1);zeros(size(negativeExamples, 1), 1)];
data = [positiveExamples;negativeExamples];

end

