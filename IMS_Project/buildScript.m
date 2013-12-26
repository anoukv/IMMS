function [ output_args ] = buildScript( sizeOfRun, vocSizes )

if nargin == 0
    sizeOfRun = 100;
end
if nargin == 1
    vocSizes = [10];
end

colorspaces = {'gray', 'rgb', 'RGB', 'opp'};
dens = [0,1];

for i=1:size(colorspaces,1)
    for d=1:size(dens,1)
        buildDescriptors(sizeOfRun,'train', dens(d), colorspaces{i});
        buildDescriptors(50,'test', dens(d), colorspaces{i});

        buildVocabulary(vocSizes,sizeOfRun, dens(d), colorspaces{i});

        for j=1:size(vocSizes,1)
            v = loadVocabulary(vocSizes(j), sizeOfRun, dens(d), colorspaces{i});
            buildBins(1, sizeOfRun, v, 'train',  dens(d), colorspaces{i});
            buildBins(1, sizeOfRun, v, 'test',  dens(d), colorspaces{i});
        end
    end
end

end

