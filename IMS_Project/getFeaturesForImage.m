function [ descriptors ] = getFeaturesForImage( location )

thisImage = imread(location);
        
if ndims(thisImage) == 3    % Not all images are coloured.
    thisImage = rgb2gray(thisImage);
end

I = im2single(thisImage);

[~, desc] = vl_sift(I);

descriptors = desc;

end

