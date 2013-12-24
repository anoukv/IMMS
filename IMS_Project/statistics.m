function [] = statistics()

classifiers = getClassClassifiers();

classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};

for i=1:size(classNames,1)
    bins = loadBins(classNames{i});
    results = zeros(size(bins,1),2);
    for j=1:size(bins,1)
        results(j,:) = predictClass(classifiers, bins(j), i)
    end
end


end

