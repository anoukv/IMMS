function [] = buildScript( sizeOfRun, vocSizes, vocNimages, doDescriptors, doVocabulary, doBins )
% Calculates and stores a lot of stuff.
% First calculates and stores descriptors.
% Then calculates vocabularies for various sizes from a number of images.
% Finally calculates the bins for every image and vocabulary.

testSize = 50;
if sizeOfRun < testSize
    testSize = sizeOfRun;
end

colorspaces = {'rgb', 'caps_rgb', 'gray', 'opp'};
dens = [0,1];

if doDescriptors
    disp('Extracting descriptors');
    for i=1:size(colorspaces,2)
        disp(strcat('Started on color:',32, colorspaces{i}));
        for d=1:size(dens,2)
            buildDescriptors(sizeOfRun,'train', dens(d), colorspaces{i});
            buildDescriptors(testSize,'test', dens(d), colorspaces{i});
        end
    end
end

if doVocabulary
    disp('Building vocabularies');
    for d=1:size(dens,2)
        disp(strcat('Started on dens:',32, int2str(dens(d))));
        for i=1:size(colorspaces,2)
            buildVocabulary(vocSizes, vocNimages, dens(d), colorspaces{i});
        end
    end
end

if doBins
    disp('Building bins');
    for i=1:size(colorspaces,2)
        disp(strcat('Started on color:',32, colorspaces{i}));
        for d=1:size(dens,2)
            for j=1:size(vocSizes,1)
                v = loadVocabulary(vocSizes(j), vocNimages, dens(d), colorspaces{i});
                buildBins(1, sizeOfRun, v, 'train',  dens(d), colorspaces{i});
                buildBins(1, testSize, v, 'test',  dens(d), colorspaces{i});
            end
        end
    end
end

end

