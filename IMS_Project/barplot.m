function [] = barplot()

% Different sifts over different training sizes
dense = [0, 1];
colorspace = {'gray', 'rgb', 'caps_rgb', 'opp'};
trainingSize = 200; % we'll choose this the largest
vocabularySize = 100;
vocTrainSize = 5;
kernels = {'-b 1 -q -t 0', '-b 1 -q -t 1', '-b 1 -q -t 2', '-b 1 -q -t 3'};

MAPs = zeros(size(dense, 2) * size(colorspace, 2), 1);

for d=1:size(dense, 2)
    disp(strcat('Dense:',32,int2str(dense(d))));
    for c=1:size(colorspace, 2)
        v = loadVocabulary(vocabularySize, vocTrainSize, dense(d), colorspace{c});
        buildBins(1, trainingSize, v, 'train', dense(d), colorspace{c});
        buildBins(1, trainingSize, v, 'test', dense(d), colorspace{c});
        [~, MAP] = newStatistics(dense(d), colorspace{c}, '-b 1 -q', trainingSize);
        MAPs(c+4*dense(d)) = MAP;
    end
end

bar(MAPs);

end

