function [  ] = other( )
classifiers = getClassClassifiers();
classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};

for i = 1:size(classNames, 2)
    [test, truth] = generateTestData(classNames{i});
    [prediction, acc, probability] = svmpredict(truth, test, classifiers(i));
    resultMatrix = [prediction, truth, probability];
    sortedOnProb = sortrows(resultMatrix, -3);
    [p, ap] = averagePrecision(sortedOnProb(:, 2))
end

end


function [precision, AP] = averagePrecision(data)
% data should be in format: [truthValue]

Mc = sum(data);
n = size(data, 1);
summationResult = 0;

for i = 1:n
    summationResult = summationResult + data(i) / i;
end

summationResult = summationResult / Mc;

precision = sum(data / size(data, 1));
AP = summationResult;

end


