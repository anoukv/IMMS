im1 = im2single(imread('img1.pgm'));
im2 = im2single(imread('img2.pgm'));
n = 10;
p = 4;

subplot(1, 2, 1);
imshow(im1, []);
title('im1');
subplot(1, 2, 2);
imshow(im2, []);
title('im2');

[ M, t ] = computeAffineTransformation(im1, im2, n, p);

% because we are going from 2 to 1
M = inv(M);
t = -t;

I = transformImage(im2, M, t);
% T = maketform('affine', [M; t']);
% [I, XDATA, YDATA] = imtransform(im2, T);

figure, imshow(I);
title('Transformed im1');

 
