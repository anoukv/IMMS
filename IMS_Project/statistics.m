function [] = statistics()

classifiers = getClassClassifiers();

classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};

means = zeros(size(classNames,2),2);
for i=1:size(classNames,2)
    bins = loadBins(classNames{i});
    results = zeros(size(bins,1),2);
    for j=1:size(bins,1)
        [t, p] = predictClass(classifiers, bins(j,:), i)
    end
    means(i,:) = [mean(results(:,1)), mean(results(:,2))];
end

means

end

