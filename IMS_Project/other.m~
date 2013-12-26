function [  ] = other( )
classifiers = getClassClassifiers();
classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};

for i = 1:size(classNames, 2)
    [test, truth] = generateTestData(classNames{i});
    [prediction, acc, probability] = svmpredict(truth, test, classifiers(i));
    resultMatrix = [prediction, truth, probability];
    sortedOnProb = sortrows(resultMatrix, -3);
end

end



