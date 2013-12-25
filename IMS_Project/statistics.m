function [] = statistics()

classifiers = getClassClassifiers();

classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};

means = zeros(size(classNames,2),2);
for i=1:size(classNames,2)
    disp(classNames{i})
    bins = loadBins(classNames{i});
    results = zeros(size(bins,1),2);
    for j=1:size(bins, 1)
        [t, p] = predictClass(classifiers, bins(j,:), i);
        results(j, 1) = t;
        results(j, 2) = p;
    end
    means(i, :) = sum(results)./size(bins, 1);
end

means

end

