voc_size = [20];
numberOfImagesPerClass = [5];
dense = [0];
colorspace = {'gray', 'rgb', 'caps_rgb', 'opp'};
trainingSizes = [199];


for d=1:size(dense, 2)
    for c=1:size(colorspace, 2)
        for numIm=1:size(numberOfImagesPerClass, 2)
            for vsize=1:size(voc_size, 2)
                v = loadVocabulary(voc_size(vsize), numberOfImagesPerClass(numIm), dense(d), colorspace{c});
                buildBins(1, max(trainingSizes), v, 'train', dense(d), colorspace{c});
                buildBins(1, max(trainingSizes), v, 'test', dense(d), colorspace{c});
                for trainSize=1:size(trainingSizes, 2)
                   statistics(dense(d), colorspace{c}, '-t 3 -q 1', trainingSizes(trainSize));
                end
            end
        end
    end
end




