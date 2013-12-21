function [ v ] = loadVocabulary(voc_size)

if nargin == 0
  voc_size = 400;
end

v = load(strcat('Vocabulary', int2str(voc_size)), 'clusters');
v = v.clusters;

end