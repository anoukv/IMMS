voc_size = [3]; % we'll choose this the largest
numberOfImagesPerClass = [4]; % we'll choose this the largest
dense = [0, 1];
colorspace = {'gray', 'rgb', 'caps_rgb', 'opp'};
trainingSizes = [10]; % we'll choose this the largest


for d=1:size(dense, 2)
    for c=1:size(colorspace, 2)
        for numIm=1:size(numberOfImagesPerClass, 2)
            for vsize=1:size(voc_size, 2)
                disp(strcat('Building bins for dense:', 32, int2str(dense(d)), 32, 'and color:', 32, colorspace{c}, 32, 'vocabulary: ', 32, int2str(voc_size(vsize)), 'x', int2str(numberOfImagesPerClass(numIm))));
                v = loadVocabulary(voc_size(vsize), numberOfImagesPerClass(numIm), dense(d), colorspace{c});
                buildBins(1, max(trainingSizes), v, 'train', dense(d), colorspace{c});
                buildBins(1, max(trainingSizes), v, 'test', dense(d), colorspace{c});
                for trainSize=1:size(trainingSizes, 2)
                   [results, MAP] = statistics(dense(d), colorspace{c}, '-t 2 -q 1', trainingSizes(trainSize))
                end
            end
        end
    end
end




