function [] = buildBins(startNumber, numberOfImagesPerClass, Vocabulary, trainOrTest )
start = clock;
disp('Building bins...');

if strcmp(trainOrTest, 'train')
    classNames = {'motorbikes_train', 'cars_train', 'faces_train', 'airplanes_train'};
else
    classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};
end


for i = 1:size(classNames, 2)
    disp(strcat(32,32,32,32,'Started on class',32, classNames{i}));
    folder = strcat('../../IMS_data/Descriptors/', classNames{i});
    
    descNames = dir(fullfile(folder, '*.mat'));
    descNames = {descNames.name}';
    
    n = numberOfImagesPerClass;
    if n > size(descNames, 1)
        n = size(descNames, 1);
    end
    
    for im = startNumber:n
        desc = load(strcat('../../IMS_data/Descriptors/', classNames{i}, '/', descNames{im}), 'desc');
        desc = desc.desc;
        bins = quantize(Vocabulary,desc);
        save(strcat('../../IMS_data/Binned/', classNames{i}, '/image', int2str(im)), 'bins');
    end
end

disp('Finished building bins.');

stop = clock;
disp(strcat('Seconds passed:', int2str(round(etime(stop, start)))));

end

