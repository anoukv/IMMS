function [ motorbikes, cars, faces, airplanes ] = returnClassClassifiers(  )

motorbikes = trainSVM('motorbikes_train');
cars = trainSVM('cars_train');
faces = trainSVM('faces_train');
airplanes = trainSVM('airplanes_train');

end

