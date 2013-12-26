function [] = statistics()

classifiers = getClassClassifiers();

classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};

chaosMatrix = zeros(0, 0);
means = zeros(size(classNames,2),2);
for i=1:size(classNames,2)
    disp(classNames{i})
    bins = loadBins(classNames{i});
    results = zeros(size(bins,1),2);
    %disp(strcat('Images in this class', 32, int2str(size(bins, 1))));
    for j=1:size(bins, 1)
        [truthValue, prob, prediction] = predictClass(classifiers, bins(j,:), i);
        results(j, 1) = truthValue;
        results(j, 2) = prob;
        chaosMatrix(size(chaosMatrix,1) +1, :) = [truthValue, prob, prediction];   
    end
    means(i, :) = sum(results)./size(bins, 1);
end

motorbikesRows = chaosMatrix(:, 3) == 1;
carsRows = chaosMatrix(:, 3) == 2;
facesRows = chaosMatrix(:, 3) == 3;
airplanesRows = chaosMatrix(:, 3) == 4;

motorbikes = sortrows(chaosMatrix(motorbikesRows == 1, [1 2]), -2);
cars = sortrows(chaosMatrix(carsRows == 1, [1 2]), -2);
faces = sortrows(chaosMatrix(facesRows == 1, [1 2]), -2);
airplanes = sortrows(chaosMatrix(airplanesRows == 1, [1 2]), -2);

[p1, ap1] = averagePrecision(motorbikes);
[p2, ap2] = averagePrecision(cars);
[p3, ap3] = averagePrecision(faces);
[p4, ap4] = averagePrecision(airplanes);
averagePrecision = [ap1;ap2;ap3;ap4];
precision = [p1;p2;p3;p4];
results = [averagePrecision, precision]

end


function [precision, AP] = averagePrecision(data)
% data should be in format: [truthValue, probability]

Mc = sum(data(:, 1));
n = size(data, 1);
summationResult = 0;
for i = 1:n
    summationResult = summationResult + data(i) / i;
end

summationResult = summationResult / Mc;


precision = sum(data(:, 1)) / size(data, 1);
AP = summationResult;

end

