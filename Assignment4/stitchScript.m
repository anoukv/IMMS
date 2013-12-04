% stitch script 
left = im2single(imread('img1.pgm'));
right = im2single(imread('img2.pgm'));

% subplot(1, 2, 1);
% imshow(left, []);
% title('left');
% 
% subplot(1, 2, 2);
% imshow(right, []);
% title('right');

n = 18;
p = 4;

[ M, t ] = computeAffineTransformation(left, right, n, p);

% M = inv(M);
% t = -t;

T = maketform('affine', [M; t']);

[x, y] = tformfwd(T,[1 size(right,2)], [1 size(left,1)]);

xdata = [min(1,x(1)) max(size(right,2),x(2))];
ydata = [min(1,y(1)) max(size(right,1),y(2))];

leftNew = imtransform(right,T,'Xdata',xdata,'YData',ydata);
rightNew = imtransform(right, maketform('affine', [1 0 0; 0 1 0; 0 0 1]),'Xdata',xdata,'YData',ydata); 
size(leftNew)
size(rightNew)
imshow(max(leftNew,rightNew));