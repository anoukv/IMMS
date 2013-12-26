function [ test, groundTruth ] = generateTestData( class )
classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};

negativeExamples = zeros(0, 0);

for i = 1:size(classNames, 2)
    if strcmp(classNames{i},class) == 0
        bins = loadBins(classNames{i});
        startRow = size(negativeExamples, 1)+1;
        endRow = startRow + size(bins, 1)-1;
        negativeExamples(startRow:endRow, :) = bins;
    end
end

positiveExamples = loadBins(class);

groundTruth = [ones(size(positiveExamples, 1), 1);zeros(size(negativeExamples, 1), 1)];
test = [positiveExamples;negativeExamples];

end

