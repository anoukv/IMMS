

v = loadVocabulary();
model = svmtrain([1;1;0], [quantize(v, 'data/cars_train/img009.jpg'); quantize(v, 'data/cars_train/img009.jpg'); quantize(v, 'data/cars_train/img009.jpg')]);
disp('\n');
svmpredict(1,quantize(v, 'data/cars_train/img009.jpg'),model)