% plotter 

% Different sifts over different training sizes
dense = [0, 1];
colorspace = {'gray', 'rgb', 'caps_rgb', 'opp'};
trainingSizes = [20:20:200]; % we'll choose this the largest
vocabularySizes = [20,35,50];
vocTrainSizes = [10];
kernels = {'-b 1 -q -t 0', '-b 1 -q -t 1', '-b 1 -q -t 2', '-b 1 -q -t 3'};

MAPs = zeros(size(dense, 2) * size(colorspace, 2), size(trainingSizes, 2));

for d=1:size(dense, 2)
    for c=1:size(colorspace, 2)
        disp(strcat('Building bins for dense:', 32, int2str(dense(d)), 32, 'and color:', 32, colorspace{c}, 32, 'vocabulary: ', 32, int2str(max(vocabularySizes)), 'x', int2str(max(vocTrainSizes))));
        v = loadVocabulary(max(vocabularySizes), max(vocTrainSizes), dense(d), colorspace{c});
        buildBins(1, max(trainingSizes), v, 'train', dense(d), colorspace{c});
        buildBins(1, max(trainingSizes), v, 'test', dense(d), colorspace{c});
        disp('Bins build');
        for s=1:size(trainingSizes, 2)
            [AP, MAP] = newStatistics(dense(d), colorspace{c}, '-b 1 -q', trainingSizes(s));
            MAPs(c+4*dense(d), s) = MAP;
        end
    end
end

figure, 
plot(trainingSizes, MAPs);
legend('gray key', 'rgb key', 'RGB key', 'opp key', 'gray dense', 'rgb dense', 'RGB dense', 'opp dense')

MAPs = zeros(size(dense, 2) * size(colorspace, 2), size(vocabularySizes, 2));

for d=1:size(dense, 2)
    for c=1:size(colorspace, 2)
        for vs=1:size(vocabularySizes, 2)
            disp(strcat('Building bins for dense:', 32, int2str(dense(d)), 32, 'and color:', 32, colorspace{c}, 32, 'vocabulary: ', 32, int2str(vocabularySizes(vs)), 'x', int2str(max(vocTrainSizes))));
            v = loadVocabulary(vocabularySizes(vs), max(vocTrainSizes), dense(d), colorspace{c});
            buildBins(1, max(trainingSizes), v, 'train', dense(d), colorspace{c});
            buildBins(1, max(trainingSizes), v, 'test', dense(d), colorspace{c});
            [AP, MAP] = newStatistics(dense(d), colorspace{c}, '-b 1 -q', trainingSizes(s));
            MAPs(c+4*dense(d), vs) = MAP;
        end
    end
end

figure, 
plot(vocabularySizes, MAPs);
legend('gray key', 'rgb key', 'RGB key', 'opp key', 'gray dense', 'rgb dense', 'RGB dense', 'opp dense')


