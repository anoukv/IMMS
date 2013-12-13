function [ bins, indices ] = quantize(vocabulary, image)

thisImage = imread(image);

if ndims(thisImage) == 3    % Not all images are coloured.
    thisImage = rgb2gray(thisImage);
end

[~, desc] = vl_sift(im2single(thisImage));

distances = vl_alldist2(vocabulary', double(desc));
[~, indices] = min(distances);

bins = hist(indices, size(vocabulary, 1));
bins = bins / size(desc, 2);

end
