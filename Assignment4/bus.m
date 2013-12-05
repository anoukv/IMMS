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

% [ M, t ] = computeAffineTransformation(left, right, n, p);

M = [0.9875, -0.0878 ; 0.0833, 0.9956];
t = [-204.9172; -54.7405];

T = maketform('affine', [M; t']);
[rightNew, XDATA, YDATA] = imtransform(right, T);

rightNew = rightNew';

t = abs(ceil(t));

A = zeros(t(1), t(2));
B = zeros(size(rightNew, 1), t(2));
C = zeros(t(1), size(rightNew, 2));
D = rightNew;

row1 = [A;B]';
row2 = [C;D]';

rightTranslated = [row1;row2;];

leftResampled = zeros(size(rightTranslated));
leftResampled(1:size(left,1), 1:size(left,2)) = left;


figure, imshow(max(leftResampled,rightTranslated));

clear();
