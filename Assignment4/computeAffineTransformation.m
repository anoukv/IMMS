function [ M, t ] = computeAffineTransformation( im1, im2, n, p )

% A tutorial with functions that actually exist:
% help 

% frames is a 4 x n matrix
% n is the number of keypoints found
% for every keypoint frames holds x, y, scale and orientation
[frames1, desc1] = vl_sift(im1);
[frames2, desc2] = vl_sift(im2);

% matches is a 2 x n matrix
% n is the number of matches
% the rows correspond to the different images
% the columns then point to the columns of the matching 
% descriptors / frames
[matches] = vl_ubcmatch(desc1, desc2);

% now we need to find the coordinates of the matches:
% coordinates = 2xnumberOfPoints
coordinates1 = ones(2, size(matches, 2));
coordinates2 = ones(2, size(matches, 2));

coordinates1 = frames1([1, 2], matches(1, :));
coordinates2 = frames2([1, 2], matches(2, :));

[M, t] = ransac(im1, im2, n, coordinates1, coordinates2, p)

%plotMatches(im1, im2, coordinates1, coordinates2);
end

