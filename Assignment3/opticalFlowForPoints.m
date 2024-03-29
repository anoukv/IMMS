function [v1, v2] = opticalFlowForPoints(x, y, im1, im2, regionSize, Gd)

% Compute Ix, Iy by convolving the image with Gd
Ix = conv2(im1, Gd, 'same');
Iy = transpose(conv2(transpose(im1), Gd, 'same'));

% It is the difference between Ix and Iy
It = im1 - im2;

% Extract regions from Ix, Iy and It
xR = round(x);
yR = round(y);
IxR = Ix(xR-regionSize:xR+regionSize, yR-regionSize:yR+regionSize);
IyR = Iy(xR-regionSize:xR+regionSize, yR-regionSize:yR+regionSize);
ItR = It(xR-regionSize:xR+regionSize, yR-regionSize:yR+regionSize);

% Compute v (see function below)
v = getV(IxR, IyR, ItR);
v1 = v(1);
v2 = v(2);
        
end

function v = getV(Ix, Iy, It)

% Reshape to vectors
Ixvec = reshape(Ix, size(Ix, 1) * size(Ix, 2), 1);
Iyvec = reshape(Iy, size(Iy, 1) * size(Iy, 2), 1);
b = reshape(It, size(It, 1) * size(It, 1), 1);

A = [Ixvec, Iyvec];

% Solve by least squares
v = pinv(A' * A) * A' * b;

end
