function [ M, t ] = getAffineTrasformation( points1, points2 )

% these are the x's and y's from both points
x1 = points1(1, :);
y1 = points1(2, :);
x2 = points2(1, :)';
y2 = points2(2, :)';

% create ones and zeros
o = ones(size(x1, 2), 1);
z = zeros(size(x1, 2), 1);

% create the odd and the even rows from A
upper = [x1', y1', z, z, o, z];
lower = [z, z, x1', y1', z, o];

% instead of even, odd, even, odd. We'll just put them on top of each
% other, this is perfectly fine if we also modify b to first give the x's
% and then the y's (so we do this).
A = [upper;lower];
b = [x2; y2];

% compute the vector containing the transformation parameters
transformationVector = pinv(A) * b;

% prepare them to be returned
m1 = transformationVector(1);
m2 = transformationVector(2);
m3 = transformationVector(3);
m4 = transformationVector(4);
t1 = transformationVector(5);
t2 = transformationVector(6);
M = [m1, m2; m3, m4];
t = [t1 ; t2];

end

