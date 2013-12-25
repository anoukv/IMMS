function [ training, groundTruth ] = generateTrainingData( class )
classNames = {'motorbikes_train', 'cars_train', 'faces_train', 'airplanes_train'};

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
training = [positiveExamples;negativeExamples];

end

