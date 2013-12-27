function [ classifiers ] = getClassClassifiers(dense, colorspace, kernel, trainingSize)
% -t kernel_type : set type of kernel function (default 2)
% 	0 -- linear: u'*v
% 	1 -- polynomial: (gamma*u'*v + coef0)^degree
% 	2 -- radial basis function: exp(-gamma*|u-v|^2)
% 	3 -- sigmoid: tanh(gamma*u'*v + coef0)

% from http://www.csie.ntu.edu.tw/~cjlin/libsvm/

classNames = {'motorbikes_train', 'cars_train', 'faces_train', 'airplanes_train'};

% use generateData(...) to generate data, then train the svm and save each
% classifier in the classifiers array
for i = 1:size(classNames, 2)
    [training, groundTruth] = generateData( classNames{i}, 'train', dense, colorspace, trainingSize );
    model = svmtrain(groundTruth, training, kernel);
    classifiers(1, i) = model;
end


end



