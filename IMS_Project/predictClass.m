function [truthValue, probability ] = predictClass( classifier1, classifier2, classifier3, classifier4, hist, trueClass )

truth = zeros(4, 1);
truth(trueClass) = 1;

[pred1, ~, prob1] = svmpredict(truth(1), hist, classifier1);
[pred2, ~, prob2] = svmpredict(truth(2), hist, classifier2);
[pred3, ~, prob3] = svmpredict(truth(3), hist, classifier3);
[pred4, ~, prob4] = svmpredict(truth(4), hist, classifier4);

predictions = [pred1, pred2, pred3, pred4];
probabilities = [prob1, prob2, prob3, prob4];

if max(predictions) == 1
    indices = find(predicitons);
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

