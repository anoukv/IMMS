function [ output_args ] = buildScript( sizeOfRun, vocSizes )


if nargin == 0
    sizeOfRun = 100;
end
if nargin == 1
    vocSizes = [10];
end

colorspaces = ['gray', 'rgb', 'RGB', 'opp'];

for 

buildDescriptors(1,sizeOfRun,'train');
buildDescriptors(1,50,'test');

buildVocabulary(vocSizes,sizeOfRun);

for j=1:size(vocSizes,1)
    v = loadVocabulary(vocSizes(j),sizeOfRun);
    buildBins(1, sizeOfRun, v, 'train');
    buildBins(1, sizeOfRun, v, 'test');
end

end

