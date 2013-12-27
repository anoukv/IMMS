
% Parameters to get statistics for:
numberOfImagesPerClass = [5]; % we'll choose this the largest
voc_size = [100]; % we'll choose this the largest
dense = [0, 1];
colorspace = {'gray', 'rgb', 'caps_rgb', 'opp'};
trainingSizes = 20:20:200; % we'll choose this the largest

buildScript( max(trainingSizes), voc_size, numberOfImagesPerClass, 1, 1, 0 );

% Results array
resultsForColorSpaces = zeros(2*size(colorspace, 2), 1);

for d=1:size(dense, 2)
    for c=1:size(colorspace, 2)
        for numIm=1:size(numberOfImagesPerClass, 2)
            for vsize=1:size(voc_size, 2)
                disp(strcat('Building bins for dense:', 32, int2str(dense(d)), 32, 'and color:', 32, colorspace{c}, 32, 'vocabulary: ', 32, int2str(voc_size(vsize)), 'x', int2str(numberOfImagesPerClass(numIm))));
                v = loadVocabulary(voc_size(vsize), numberOfImagesPerClass(numIm), dense(d), colorspace{c});
                buildBins(1, max(trainingSizes), v, 'train', dense(d), colorspace{c});
                buildBins(1, max(trainingSizes), v, 'test', dense(d), colorspace{c});
                for trainSize=1:size(trainingSizes, 2)
                   [AP, MAP] = newStatistics(dense(d), colorspace{c}, '-b 1 -q', trainingSizes(trainSize))
                end
            end
        end
        resultsForColorSpaces(c+4*dense(d), :) = MAP;
    end
end

resultsForColorSpaces




