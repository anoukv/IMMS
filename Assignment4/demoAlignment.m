im1 = im2single(imread('img1.pgm'));
im2 = im2single(imread('img2.pgm'));

% How many iterations in average are needed to find good transformation parameters?
% Mostly only three (we saw from experimenting), but we chose to do 10,
% because that's safe. Also the boat images resemble each other a lot, so
% most identified matches are already matches, so the first iteration
% already gives very reasonable results most of the time.
n = 10;
p = 4;

[ M, t ] = computeAffineTransformation(im1, im2, n, p, false);

T = maketform('affine', [M; t']);
[matlab, XDATA, YDATA] = imtransform(im2, T);

own = transformImage(im2, M, t);

subplot(2, 2, 1);
imshow(im1);
title('Target')

subplot(2, 2, 2);
imshow(im2);
title('Initial')

subplot(2, 2, 3);
imshow(own);
title('Own transformed')

subplot(2, 2, 4);
imshow(matlab);
title('Transformed by MATLAB')

% just one ransac iteration, to show the plot where all points are
% transformed and connected by lines. (IT MIGHT NOT BE THE BEST!!)
[ M, t ] = computeAffineTransformation(im1, im2, 1, p, true);
clear();


