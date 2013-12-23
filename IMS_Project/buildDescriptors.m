function [] = buildDescriptors( first, last )
start = clock;
disp('Compiling descriptors...');

folderNames = {'data/motorbikes_train', 'data/cars_train', 'data/faces_train', 'data/airplanes_train'};
classNames = {'motorbikes_train', 'cars_train', 'faces_train', 'airplanes_train'};

extension = '*.jpg';

for i = 1:size(folderNames, 2)
    folder = folderNames{i};
    disp(strcat('Started on folder: ', 32, folder));
    imageNames = dir(fullfile(folder,extension));
    imageNames = {imageNames.name}';

    imageStrings = regexp([imageNames{:}],'(\d*)','match');
    imageNumbers = str2double(imageStrings);
    [~,sortedIndices] = sort(imageNumbers);
    sortedImageNames = imageNames(sortedIndices);
    
    if size(sortedImageNames,1) > last
        images = sortedImageNames(first:last);
    else
        images = sortedImageNames;
    end
    
    for im = 1:size(images, 1)
        desc = getFeaturesForImage( fullfile(folder, images{im}) );
        if ~ isequal(desc,0)
            save(strcat('../../IMS_data/Descriptors/', classNames{i}, '/image', int2str(im)), 'desc');
        end
    end
end

disp('Finished extracting and saving descriptors');

stop = clock;
disp(strcat('Seconds passed:', int2str(round(etime(stop, start)))));

end
