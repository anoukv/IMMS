function [ bins, indices ] = quantize(vocabulary, image)

thisImage = imread(image);
if ndims(thisImage) == 3    % Not all images are coloured.
    thisImage = rgb2gray(thisImage);
end

[~, desc] = vl_sift(im2single(thisImage));

distances = vl_alldist2(vocabulary', double(desc));
[~, indices] = min(distances);

bins = zeros(size(vocabulary,1),1);
for i = 1:size(indices,1)
    bins(indices()) = bins(indices()) + 1;
end

end

