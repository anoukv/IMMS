% stitch script 
left = im2single(rgb2gray(imread('left.jpg')));
right = im2single(rgb2gray(imread('right.jpg')));

% left = im2single(imread('img1.pgm'));
% right = im2single(imread('img2.pgm'));

% subplot(1, 2, 1);
% imshow(left, []);
% title('left');
% 
% subplot(1, 2, 2);
% imshow(right, []);
% title('right');

n = 10;
p = 4;

%[ M, t ] = computeAffineTransformation(left, right, n, p);

m = [0.9875, -0.0878 ; 0.0833, 0.9956];
t = [-204.9172 ; -54.7405];

T = maketform('affine', [M; t']);
[rightNew, XDATA, YDATA] = imtransform(right, T);

size(rightNew)
size(left)

imshow(rightNew);