function [ classifiers ] = getClassClassifiers()
% -t kernel_type : set type of kernel function (default 2)
% 	0 -- linear: u'*v
% 	1 -- polynomial: (gamma*u'*v + coef0)^degree
% 	2 -- radial basis function: exp(-gamma*|u-v|^2)
% 	3 -- sigmoid: tanh(gamma*u'*v + coef0)

% from http://www.csie.ntu.edu.tw/~cjlin/libsvm/

svmopts = '-c 2 -g 1 -t 1';

classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};


for i = 1:size(classNames, 2)
    [training, groundTruth] = generateData( classNames{i}, 'train' );
    model = svmtrain(groundTruth, training, svmopts);
    classifiers(1, i) = model;
end


end



