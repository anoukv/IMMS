function [] = buildBins( numberOfImagesPerClass, Vocabulary )
start = clock;
disp('Building bins...');

classNames = {'motorbikes_train', 'cars_train', 'faces_train', 'airplanes_train'};

for i = 1:size(classNames, 2)
    disp(strcat(32,32,32,32,'Started on class',32, classNames{i}));
    folder = strcat('../../IMS_data/Descriptors/', classNames{i});
    
    descNames = dir(fullfile(folder, '*.mat'));
    descNames = {descNames.name}';
    
    n = numberOfImagesPerClass;
    if n > size(descNames, 1)
        n = size(descNames, 1)
    end
    
    for im = 1:n
        desc = load(strcat('../../IMS_data/Descriptors/', classNames{i}, '/', descNames{im}), 'desc');
        desc = desc.desc';
        bins = descriptors4vocabulary2bins(desc,Vocabulary);
        save(strcat('../../IMS_data/Binned/', classNames{i}, '/image', int2str(im)), 'bins');
    end
end

disp('Finished building bins.');

stop = clock;
disp(strcat('Seconds passed:', int2str(round(etime(stop, start)))));

end

