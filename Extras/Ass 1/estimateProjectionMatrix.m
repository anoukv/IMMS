function M = estimateProjectionMatrix(xy, XYZ)
A = createMatrixA(xy, XYZ);
[U, D, V] = svd(A);
m = V(:, end);
M = reshape(m, 4, 3)';
