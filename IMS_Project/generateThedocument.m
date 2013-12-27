function [  ] = generateThedocument(dense, colorspace, kernel, trainingSize, vocSize, vocTrain   )
% this looks A LOT like newStatistics

v = loadVocabulary(vocSize, vocTrain, dense, colorspace);
buildBins(1, trainingSize, v, 'train', dense, colorspace);
buildBins(1, trainingSize, v, 'test', dense, colorspace);

classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};
classifiers = getClassClassifiers(dense, colorspace, kernel, trainingSize);

results = zeros(size(classNames, 2), 1);
allRankedLists = zeros(0, 0);
for i=1:size(classNames, 2)
    [data, truth] = generateData( classNames{i}, 'test', dense, colorspace, trainingSize );
    classifierForclass = classifiers(i);
    [pred, acc, probability] = svmpredict(truth, data, classifierForclass, '-b 1 -q 1');
    ranker = [truth, probability(:, 1)];
    ranker = sortrows(ranker, -2);
    AP = averagePrecision(ranker(:, 1));
    results(i) = AP;
    allRankedLists(:, [size(allRankedLists, 2)+1, size(allRankedLists, 2)+2]) = ranker;
end
MAP = sum(results) / size(classNames, 2);
allRankedLists
MAP
results

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
