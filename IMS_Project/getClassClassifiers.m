function [ classifiers ] = getClassClassifiers()

motorbikes = trainSVM('motorbikes_train');
cars = trainSVM('cars_train');
faces = trainSVM('faces_train');
airplanes = trainSVM('airplanes_train');

classifiers = [motorbikes, cars, faces, airplanes];

end


function [ model ] = trainSVM( class )

[training, groundTruth] = generateTrainingData( class );
svmopts = '-c 2 -g 1';
model = svmtrain(groundTruth, training, svmopts);

end


