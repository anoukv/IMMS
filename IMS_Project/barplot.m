function [] = barplot()

% Different sifts over different training sizes
dense = [0,1];
colorspace = {'gray'}; %, 'rgb', 'caps_rgb', 'opp'};
trainingSize = 200; % we'll choose this the largest
vocabularySize = 100;
vocTrainSize = 5;
kernels = {'-b 1 -q -t 0', '-b 1 -q -t 1', '-b 1 -q -t 2', '-b 1 -q -t 3'};
kernelsNames = {'linear', 'polyno', 'radial', 'sigmoi'};
colorNames = {'    grey', '     rgb', 'caps_rgb', '     opp'};
densNames = {' key','dens'};

labels = zeros(0,0);
MAPs = zeros(0,0);

for d=1:size(dense, 2)
    disp(strcat('Dense:',32,int2str(dense(d))));
    for c=1:size(colorspace, 2)
        disp(strcat(32,32,'Color:',32,colorspace{c}));
        v = loadVocabulary(vocabularySize, vocTrainSize, dense(d), colorspace{c});
        buildBins(1, trainingSize, v, 'train', dense(d), colorspace{c});
        buildBins(1, trainingSize, v, 'test', dense(d), colorspace{c});
        for i=1:size(kernels,2)
            [~, MAP] = newStatistics(dense(d), colorspace{c}, kernels{i}, trainingSize);
            MAPs = [MAPs; MAP];
            name = strcat(densNames{d},32,kernelsNames{i});
            labels = [labels; name];
        end
    end
end

bar(MAPs);
legend(labels);

end

