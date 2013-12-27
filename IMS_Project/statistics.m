function [results] = statistics(dense, colorspace, kernel, trainingSize)

classifiers = getClassClassifiers(dense, colorspace, kernel, trainingSize);

classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};

chaosMatrix = zeros(0, 0);
for i=1:size(classNames,2)
    bins = loadBins(classNames{i}, dense, colorspace);
    for j=1:size(bins, 1)
        [truthValue, prob, prediction] = predictClass(classifiers, bins(j,:), i);
        chaosMatrix(size(chaosMatrix,1) +1, :) = [truthValue, prob, prediction];   
    end
end
motorbikes = sortrows(chaosMatrix((chaosMatrix(:, 3) == 1) == 1, :), -2);
cars = sortrows(chaosMatrix((chaosMatrix(:, 3) == 2) == 1, :), -2);
faces = sortrows(chaosMatrix((chaosMatrix(:, 3) == 3) == 1, :), -2);
airplanes = sortrows(chaosMatrix((chaosMatrix(:, 3) == 4) == 1, :), -2);

[p1, ap1] = averagePrecision(motorbikes(:, 1));
[p2, ap2] = averagePrecision(cars(:, 1));
[p3, ap3] = averagePrecision(faces(:, 1));
[p4, ap4] = averagePrecision(airplanes(:, 1));

ap = [ap1;ap2;ap3;ap4];
precision = [p1;p2;p3;p4];
results = [ap, precision]
MAP = sum(ap) / 4

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

