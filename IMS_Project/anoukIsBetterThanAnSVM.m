function [ output_args ] = anoukIsBetterThanAnSVM( )

class = 'airplanes_train';

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

n = size(positiveExamples, 1);
pos = sum(positiveExamples)./n;

n = size(negativeExamples, 1);
neg = sum(negativeExamples)./n;



bins = loadBins('airplanes_test');
happy = 0;
sad = 0;
for j=1:size(bins, 1)
    distPos = pdist([bins(j, :);pos]);
    distNeg = pdist([bins(j, :);neg]);
    if distPos < distNeg 
        happy = happy + 1;
    else
        sad = sad + 1;
    end
end

happy 
sad
end

