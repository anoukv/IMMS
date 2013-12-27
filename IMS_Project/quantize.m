function [ bins, indices ] = quantize(vocabulary, desc)
% Gives the bins for a given vocabulary an descriptor set.
%

% calculate the distances between all vocabulary words and the descriptors of the
% image, remember the indices of the minimum distances
distances = vl_alldist2(vocabulary', single(desc));
[~, indices] = min(distances);

% make a histogram where the number of bins is the number of words in the
% vocabulary, and the number of selected words are represented in the
% histogram
% normalize this histogram
bins = hist(indices, size(vocabulary, 1));
bins = bins / size(desc, 2);

end
