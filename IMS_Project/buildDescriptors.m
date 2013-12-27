function [] = buildDescriptors( last, trainOrTest, dens, colorspace )
start = clock;

if strcmp(trainOrTest, 'train')
    folderNames = {'data/motorbikes_train', 'data/cars_train', 'data/faces_train', 'data/airplanes_train'};
    classNames = {'motorbikes_train', 'cars_train', 'faces_train', 'airplanes_train'};
else
    folderNames = {'data/motorbikes_test', 'data/cars_test', 'data/faces_test', 'data/airplanes_test'};
    classNames = {'motorbikes_test', 'cars_test', 'faces_test', 'airplanes_test'};
end

extension = '*.jpg';

suffix = strcat('_', int2str(dens), '_', colorspace);
for i = 1:size(folderNames, 2)
    folder = folderNames{i};
    imageNames = dir(fullfile(folder,extension));
    imageNames = {imageNames.name}';

    imageStrings = regexp([imageNames{:}],'(\d*)','match');
    imageNumbers = str2double(imageStrings);
    [~,sortedIndices] = sort(imageNumbers);
    sortedImageNames = imageNames(sortedIndices);
    
    if size(sortedImageNames,1) > last
        images = sortedImageNames(1:last);
    else
        images = sortedImageNames;
    end
    
    for im = 50:size(images, 1)
        desc = getFeaturesForImage( fullfile(folder, images{im}), dens, colorspace);
        if ~ isequal(desc,0)
            save(strcat('../../IMS_data/Descriptors/', classNames{i}, '/image', int2str(im), suffix), 'desc');
        end
    end
end

stop = clock;

end

