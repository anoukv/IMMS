function [ affineMatrix ] = affineTransformation( im1, im2 )

% A tutorial with functions that actually exist:
% http://www.vlfeat.org/overview/sift.html

[frames1, desc1] = vl_sift(im1);
[frames2, desc2] = vl_sift(im2);

[matches] = vl_ubcmatch(desc1, desc2);


end

