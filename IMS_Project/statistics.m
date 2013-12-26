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

motorbikes = chaosMatrix(motorbikesRows == 1, :);
cars = chaosMatrix(carsRows == 1, :);
faces = chaosMatrix(facesRows == 1, :);
airplanes = chaosMatrix(airplanesRows == 1, :)



end

