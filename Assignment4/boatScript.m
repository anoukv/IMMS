im1 = im2single(imread('img1.pgm'));
im2 = im2single(imread('img4.pgm'));
n = 10;
p = 4;

% subplot(1, 2, 1);
% imshow(im1);
% title('Target');
% subplot(1, 2, 2);
% imshow(im2);
% title('Initial');

[ M, t ] = computeAffineTransformation(im1, im2, n, p);


T = maketform('affine', [M; t']);
[I, XDATA, YDATA] = imtransform(im2, T);

%subplot(1, 3, 3);
imshow(I);
title('Transformed');

% because we are going from 2 to 1
% M = inv(M);
% % t = -t;
% 
% figure,
% imshow(max(im1, I));

% I = transformImage(im2, M, t);
% figure, 
% imshow(I);


 
