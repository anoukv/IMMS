
function [score] = getCorrect(dens, colorspace, kernel, trainingSize)

classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};

classifiers = getClassClassifiers(dens, colorspace, kernel, trainingSize);

correct = 0;
total = 0;
for i=1:size(classNames,2)
    bins = loadBins(classNames{i}, dens, colorspace);
    for j=1:size(bins,1)
        p = predictClass(classifiers, bins(j,:), i );
        correct = correct + p;
        total = total + 1;
    end
end

score = correct / total;

end



