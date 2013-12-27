function [] = buildBins(startNumber, numberOfImagesPerClass, Vocabulary, trainOrTest, dens, colorspace )
% Builds bins for specific parameters.
% 

start = clock;

if strcmp(trainOrTest, 'train')
    classNames = {'motorbikes_train', 'cars_train', 'faces_train', 'airplanes_train'};
else
    classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};
end

suffix = strcat('_', int2str(dens), '_', colorspace);
for i = 1:size(classNames, 2)
    folder = strcat('../../IMS_data/Descriptors/', classNames{i});
    
    descNames = dir(fullfile(folder, strcat('*',suffix,'.mat')));
    descNames = {descNames.name}';
    
    n = numberOfImagesPerClass;
    if n > size(descNames, 1)
        n = size(descNames, 1);
    end
    
    for im = startNumber:n
        desc = load(strcat('../../IMS_data/Descriptors/', classNames{i}, '/', descNames{im}), 'desc');
        desc = desc.desc;
        bins = quantize(Vocabulary,desc);
        save(strcat('../../IMS_data/Binned/', classNames{i}, '/image', int2str(im), suffix), 'bins');
    end
end

stop = clock;

end

