function [ results, MAP ] = newStatistics( dense, colorspace, kernel, trainingSize )
% Returns MAP for a specific configuration.

% get all the classifiers
classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};
classifiers = getClassClassifiers(dense, colorspace, kernel, trainingSize);

% loop over classes
% generate test data for this class
% select the classifier for the class from classifiers
% make a prediction based on that classifier
% the first column of probability holds the probability that the image is
% classified as '1' (i.e. belonging to the class). Combine this
% probality with the ground truth in ranker
% sort ranker based on the probabilities (descending), this will also
% change the order of the ground truth
% use the ground truth to calculate the average precision
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

% calculate MAP by averageing APs
MAP = sum(results) / size(classNames, 2);

end


function [ AP] = averagePrecision(data)
% data should be in format: [truthValue]

data = replaceByZero(data);
% the number of images belonging to class C
Mc = sum(data);
% total number of images
n = size(data, 1);

summationResult = 0;

% if the image is of class 'c' (i.e. data(i) == 1) then we add
% number of relevant images / i to the summation result, otherwise we don't
% add anything
for i = 1:n
    if data(i) ==  1
        numberOfRelevantImages = sum(data(1:i));
    else
        numberOfRelevantImages = 0;
    end
    
    summationResult = summationResult + numberOfRelevantImages / i;
end

% divide the result of the summation by the number of images belonging to
% clas C
summationResult = summationResult / Mc;

% return
AP = summationResult;

end
