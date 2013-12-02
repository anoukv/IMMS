function A = createMatrixA(xy, XYZ)
%calculation of projection matrix

X = XYZ(:, 1);
Y = XYZ(:, 2);
Z = XYZ(:, 3);

x = xy(:, 1);
y = xy(:, 2);

o = ones(size(x));
z = zeros(size(x));

Aoddrows = [X, Y, Z, o, z, z, z, z, -x.*X, -x.*Y, -x.*Z -x];
Aevenrows = [z, z, z, z, X, Y, Z, o, -y.*X, -y.*Y, -y.*Z, -y]; 

A = [Aoddrows; Aevenrows];

end
