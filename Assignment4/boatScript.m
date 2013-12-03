im1 = im2single(imread('img1.pgm'));
im2 = im2single(imread('img2.pgm'));

% subplot(1, 2, 1);
% imshow(im1, []);
% subplot(1, 2, 2);
% imshow(im2, []);

[ bestM, bestT ] = computeAffineTransformation(im1, im2);
size([bestM(1,1), bestM(1,2); bestM(2,1), bestM(2,2); bestT'])
T = maketform('affine', [bestM(1,1), bestM(1,2); bestM(2,1), bestM(2,2); bestT']);
imshow(imtransform(im1, T));
figure, imshow(im2);