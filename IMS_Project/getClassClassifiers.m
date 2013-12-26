function [ classifiers ] = getClassClassifiers()

motorbikes = trainSVM('motorbikes_train');
cars = trainSVM('cars_train');
faces = trainSVM('faces_train');
airplanes = trainSVM('airplanes_train');

classifiers = [motorbikes, cars, faces, airplanes];

end


function [ model ] = trainSVM( class )

[training, groundTruth] = generateTrainingData( class );

% -t kernel_type : set type of kernel function (default 2)
% 	0 -- linear: u'*v
% 	1 -- polynomial: (gamma*u'*v + coef0)^degree
% 	2 -- radial basis function: exp(-gamma*|u-v|^2)
% 	3 -- sigmoid: tanh(gamma*u'*v + coef0)

% from http://www.csie.ntu.edu.tw/~cjlin/libsvm/

svmopts = '-c 2 -g 1 -t 1';

model = svmtrain(groundTruth, training, svmopts);

end


