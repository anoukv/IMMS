% stitch script
left = im2single(rgb2gray(imread('left.jpg')));
right = im2single(rgb2gray(imread('right.jpg')));
n = 10;
p = 10;

[ bestM, bestT ] = computeAffineTransformation(im1, im2, n, p);

T = maketform('affine', [bestM(1,1), bestM(1,2); bestM(2,1), bestM(2,2); -bestT']);


subplot(1, 2, 1);
imshow(left, []);
title('left');
subplot(1, 2, 2);
imshow(right, []);
title('right');

figure, imshow(imtransform(right, T));
title('Transformed right')