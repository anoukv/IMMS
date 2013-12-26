function [] = buildBins(startNumber, numberOfImagesPerClass, Vocabulary, trainOrTest, dens, colorspace )
start = clock;

if strcmp(trainOrTest, 'train')
    classNames = {'motorbikes_train', 'cars_train', 'faces_train', 'airplanes_train'};
else
    classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};
end

suffix = strcat('_', int2str(dens), '_', colorspace);
for i = 1:size(classNames, 2)
    folder = strcat('../../IMS_data/Descriptors/', classNames{i});
    
    descNames = dir(fullfile(folder, '*.mat'));
    descNames = {descNames.name}';
    
    n = numberOfImagesPerClass;
    if n > size(descNames, 1)
        n = size(descNames, 1);
    end
    
    for im = startNumber:n
        if size(strfind(descNames{im}, suffix),1) ~= 0
            desc = load(strcat('../../IMS_data/Descriptors/', classNames{i}, '/', descNames{im}), 'desc');
            desc = desc.desc;
            bins = quantize(Vocabulary,desc);
            save(strcat('../../IMS_data/Binned/', classNames{i}, '/image', int2str(im), suffix), 'bins');
        end
    end
end

stop = clock;

end

