function [ m1, m2, m3, m4, t1, t2 ] = getAffineTrasformation( points1, points2 )

x1 = points1(1, :);
y1 = points1(2, :);
x2 = points2(1, :)';
y2 = points2(2, :)';

o = ones(size(x1, 2), 1);
z = zeros(size(x1, 2), 1);

upper = [x1', y1', z, z, o, z];
lower = [z, z, x1', y1', z, o];

A = [upper;lower];
b = [x2; y2];

transformationVector = pinv(A) * b;
m1 = transformationVector(1);
m2 = transformationVector(2);
m3 = transformationVector(3);
m4 = transformationVector(4);
t1 = transformationVector(5);
t2 = transformationVector(6);

end

