function [truthValue, probability, prediction ] = predictClass( classifiers, hist, trueClass )

truth = zeros(4, 1);
truth(trueClass) = 1;

[pred1, ~, prob1] = svmpredict(truth(1), hist, classifiers(1), '-q');
[pred2, ~, prob2] = svmpredict(truth(2), hist, classifiers(2), '-q');
[pred3, ~, prob3] = svmpredict(truth(3), hist, classifiers(3), '-q');
[pred4, ~, prob4] = svmpredict(truth(4), hist, classifiers(4), '-q');

predictions = [pred1, pred2, pred3, pred4];
probabilities = [prob1, prob2, prob3, prob4];

if max(predictions) == 1
%     disp(':)')
    indices = find(predictions);
    probsForOnes = probabilities(indices);
    [probability, indexForMostProb] = max(probsForOnes);
    prediction = indices(indexForMostProb);
else
    [probability, prediction] = min(probabilities);
end

if prediction == trueClass
    truthValue = 1;
else
    truthValue = 0;
end


end

