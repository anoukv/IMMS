% stitch script 
left = im2single(rgb2gray(imread('left.jpg')));
right = im2single(rgb2gray(imread('right.jpg')));

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

M = inv(M);
t = -t;

T = maketform('affine', [M(1,1), M(1,2); M(2,1), M(2,2); -t']);

[x, y] = tformfwd(T,[1 size(left,2)], [1 size(right,1)]);

xdata = [min(1,x(1)) max(size(right,2),x(2))];
ydata = [min(1,y(1)) max(size(right,1),y(2))];

leftNew = imtransform(left,T,'Xdata',xdata,'YData',ydata);
rightNew = imtransform(right, maketform('affine', [1 0 0; 0 1 0; 0 0 1]),'Xdata',xdata,'YData',ydata); 
size(leftNew)
size(rightNew)
imshow(max(leftNew,rightNew));
