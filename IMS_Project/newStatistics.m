function [ results, MAP ] = newStatistics( dense, colorspace, kernel, trainingSize )
% Returns MAP for a specific configuration.
%

classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};
classifiers = getClassClassifiers(dense, colorspace, kernel, trainingSize);
results = zeros(size(classNames, 2), 1);
for i=1:size(classNames, 2)
    [data, truth] = generateData( classNames{i}, 'test', dense, colorspace, trainingSize );
    classifierForclass = classifiers(i);
    [pred, acc, probability] = svmpredict(truth, data, classifierForclass, '-b 1 -q 1');
    ranker = [truth, probability(:, 1)];
    ranker = sortrows(ranker, -2);
    AP = averagePrecision(ranker(:, 1));
    results(i) = AP;
end
MAP = sum(results) / size(classNames, 2);

end


function [ AP] = averagePrecision(data)
% data should be in format: [truthValue]

data = replaceByZero(data);
Mc = sum(data);
n = size(data, 1);
summationResult = 0;

for i = 1:n
    if data(i) ==  1
        numberOfRelevantImages = sum(data(1:i));
    else
        numberOfRelevantImages = 0;
    end
    
    summationResult = summationResult + numberOfRelevantImages / i;
end

summationResult = summationResult / Mc;

AP = summationResult;

end
