function [] = simpleRunScript(sizeOfRun, vocSize)

if nargin == 0
    sizeOfRun = 100;
end
if nargin == 1
    vocSize = 10;
end

buildDescriptors(1,sizeOfRun,'train');
buildDescriptors(1,50,'test');

buildVocabulary([vocSize],sizeOfRun);

v = loadVocabulary(vocSize,sizeOfRun);

buildBins(1, sizeOfRun, v, 'train');
buildBins(1, sizeOfRun, v, 'test');

statistics();


end