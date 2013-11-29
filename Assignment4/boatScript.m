im1 = im2single(imread('img1.pgm'));
im2 = im2single(imread('img2.pgm'));

% subplot(1, 2, 1);
% imshow(im1, []);
% subplot(1, 2, 2);
% imshow(im2, []);

affineTransformation(im1, im2);