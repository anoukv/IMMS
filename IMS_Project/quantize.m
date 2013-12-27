function [ bins, indices ] = quantize(vocabulary, desc)
% Gives the bins for a given vocabulary an descriptor set.
%

distances = vl_alldist2(vocabulary', single(desc));
[~, indices] = min(distances);

bins = hist(indices, size(vocabulary, 1));
bins = bins / size(desc, 2);

end
