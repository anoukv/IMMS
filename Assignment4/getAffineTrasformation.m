function [ transformationMatrix ] = getAffineTrasformation( points1, points2 )
x1 = points1(1, :);
y1 = points1(2, :);


o = ones(size(x1, 2));
z = zeros(size(x1, 2));
upper = [x1', y1', z, z, o, z];
lower = [z, z, x1', y1', z, o];

A = [upper;lower];
b = points2;
size(A)
size(b)

transformationMatrix = 1;

end

