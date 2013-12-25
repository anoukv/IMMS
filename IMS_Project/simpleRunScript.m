function [] = simpleRunScript(sizeOfRun)

if nargin == 0
    sizeOfRun = 100;
end

buildDescriptors(1,sizeOfRun,'train');
buildDescriptors(1,50,'test');

buildVocabulary([400],sizeOfRun);

v = loadVocabulary(400,sizeOfRun);

buildBins(1, sizeOfRun, v, 'train');
buildBins(1, sizeOfRun, v, 'test');


end