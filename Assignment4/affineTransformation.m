function [ affineMatrix ] = affineTransformation( im1, im2 )

% A tutorial with functions that actually exist:
% http://www.vlfeat.org/overview/sift.html

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


end

