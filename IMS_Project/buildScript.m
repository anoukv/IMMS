function [] = buildScript( sizeOfRun, vocSizes, vocNimages )

if nargin == 0
    sizeOfRun = 100;
end

if nargin == 1
    vocSizes = [3];
    vocNimages = 4;
end

testSize = 50;
if sizeOfRun < testSize
    testSize = sizeOfRun;
end

colorspaces = {'rgb', 'caps_rgb', 'gray', 'opp'};
dens = [1,0];

for i=1:size(colorspaces,2)
    disp(strcat(32,32));
    disp(strcat('Started on color:',32, colorspaces{i}));
    for d=1:size(dens,2)
        buildDescriptors(sizeOfRun,'train', dens(d), colorspaces{i});
        buildDescriptors(testSize,'test', dens(d), colorspaces{i});

        buildVocabulary(vocSizes, vocNimages, dens(d), colorspaces{i});

        for j=1:size(vocSizes,1)
            v = loadVocabulary(vocSizes(j), vocNimages, dens(d), colorspaces{i});
            buildBins(1, sizeOfRun, v, 'train',  dens(d), colorspaces{i});
            buildBins(1, testSize, v, 'test',  dens(d), colorspaces{i});
        end
    end
end

end

