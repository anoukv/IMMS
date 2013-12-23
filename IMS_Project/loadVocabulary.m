function [ v ] = loadVocabulary(voc_size, numberOfImagesPerClass)

if nargin == 0
  voc_size = 400;
end

v = load(strcat('compiled/Vocabulary_', int2str(voc_size), 'x', int2str(numberOfImagesPerClass)), 'clusters');
v = v.clusters;

end