function [ v ] = loadVocabulary()

v = load('Vocabulary', 'clusters');
v = v.clusters;

end