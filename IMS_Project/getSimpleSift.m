function [ desc ] = getSimpleSift( image )

thisImage = imread(location);

if ndims(thisImage) ~= 3
    rgb2gray(thisImage)
end

thisImage = im2single(thisImage);
desc = vl_sift(thisImage);

end
