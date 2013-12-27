voc_size = [3];
numberOfImagesPerClass = [4];
dense = [0, 1];
colorspace = {'gray', 'rgb', 'caps_rgb', 'opp'};
trainingSizes = [10];


for d=1:size(dens, 2)
    for c=1:size(colorspace, 2)
        for numIm=1:size(numberOfImagesPerClass, 2)
            for vsize=1:size(voc_size, 2)
                v = loadVocabulary(voc_size(vsize), numberOfImagesPerClass(numIm), dense(d), colorspace{c});
                buildBins(1, 10, v, 'train', dense(d), colorspace{c});
                buildBins(1, 10, v, 'test', dense(d), colorspace{c});
                for trainSize=1:size(trainingSizes, 2)
                   statistics(dense(d), colorspace{c}, '-t 2', trainingSizes(trainSize));
                end
            end
        end
    end
end




