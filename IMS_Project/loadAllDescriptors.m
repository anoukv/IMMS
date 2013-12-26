function [ allDescriptors ] = loadAllDescriptors( numberOfImagesPerClass, dens, colorspace )
start = clock;
disp(strcat(32,32,'Loading all descriptors...'));

classNames = {'motorbikes_train', 'cars_train', 'faces_train', 'airplanes_train'};

disp(strcat(32,32,32,32,'Looping for exact number'));
len = 0;
sizeOfDescCollection = 0;
suffix = strcat('_', int2str(dens), '_', colorspace);
for i = 1:size(classNames, 2)
    folder = strcat('../../IMS_data/Descriptors/', classNames{i});
    
    descNames = dir(fullfile(folder, '*.mat'));
    descNames = {descNames.name}';
    
    n = numberOfImagesPerClass;
    if n > size(descNames, 1)
        n = size(descNames, 1);
    end
    for im = 1:n
        if size(strfind(descNames{im}, suffix),1) ~= 0
            desc = load(strcat('../../IMS_data/Descriptors/', classNames{i}, '/', descNames{im}), 'desc');
            len = len + size(desc.desc',1);
            sizeOfDescCollection = size(desc.desc, 1);
        end
    end
end

disp(strcat(32,32,32,32,'Looping to fill'));
allDescriptors = zeros(len,sizeOfDescCollection);
count = 1;
for i = 1:size(classNames, 2)
    folder = strcat('../../IMS_data/Descriptors/', classNames{i});
    
    descNames = dir(fullfile(folder, '*.mat'));
    descNames = {descNames.name}';
    
    n = numberOfImagesPerClass;
    if n > size(descNames, 1)
        n = size(descNames, 1);
    end
    
    for im = 1:n
        if size(strfind(suffix, descNames{im}),1) ~= 0
            desc = load(strcat('../../IMS_data/Descriptors/', classNames{i}, '/', descNames{im}), 'desc');
            desc = desc.desc';
            for d = 1:size(desc,1)
                allDescriptors(count,:) = desc(d,:);
                count = count + 1;
            end
        end
    end
end

stop = clock;
disp(strcat(32,32,'Descriptors loaded in:',32, int2str(round(etime(stop, start))), 32, 'seconds.'));

end