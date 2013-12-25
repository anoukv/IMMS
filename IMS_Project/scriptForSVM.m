trainClass = 'airplanes_train'
testClass = 'airplanes_test'
falseTestClass = 'faces_test'

[training, groundTruth] = generateTrainingData(trainClass);
test = loadBins(testClass);
falseTest = loadBins(falseTestClass);

svmopts = ['-c 2 -g 1'];
model = svmtrain(groundTruth, training, svmopts);

[p, acc, prob] = svmpredict(groundTruth, training, model);
[p2, acc2, prob2] = svmpredict(ones(size(test, 1), 1), test, model);
[p3, acc3, prob3] = svmpredict(zeros(size(falseTest, 1), 1), falseTest, model);
