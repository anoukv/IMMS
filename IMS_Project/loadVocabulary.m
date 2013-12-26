function [ v ] = loadVocabulary(voc_size, numberOfImagesPerClass, dens, colorspace)

if nargin == 0
  voc_size = 400;
end

suffix = strcat('_', int2str(dens), '_', colorspace);
v = load(strcat('../../IMS_data/Vocabulary_', int2str(voc_size), 'x', int2str(numberOfImagesPerClass), suffix), 'clusters');
v = v.clusters;

end