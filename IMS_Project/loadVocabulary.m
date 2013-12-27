function [ v ] = loadVocabulary(voc_size, numberOfImagesPerClass, dens, colorspace)

if nargin == 0
  voc_size = 400;
end

suffix = strcat('_', int2str(dens), '_', colorspace);
name = strcat('../../IMS_data/Vocabulary_', int2str(voc_size), 'x', int2str(numberOfImagesPerClass), suffix);
if class(name) == 'cell'
    name = name{1};
end
v = load(name, 'clusters');
v = v.clusters;

end