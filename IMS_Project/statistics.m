function [] = statistics()

classifiers = getClassClassifiers();

classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};

means = zeros(size(classNames,2),2);
for i=1:size(classNames,2)
    disp(classNames{i})
    bins = loadBins(classNames{i});
    results = zeros(size(bins,1),2);
<<<<<<< HEAD
    for j=1:size(bins,1)
        [t, p] = predictClass(classifiers, bins(j,:), i);
=======
    disp(size(bins, 1));
    results = zeros(size(bins, 1), 2);
    % change iterator back to size(bins, 1)
    for j=1:size(bins, 1)
        [t, p] = predictClass(classifiers, bins(j,:), i);
        results(j, 1) = t;
        results(j, 2) = p;
>>>>>>> 30644709fa4d37420dc2cd9afa7daad2c287945f
    end
    means(i, :) = sum(results)./size(bins, 1);
end

means

end

