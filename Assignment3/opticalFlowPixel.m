function [ Vx, Vy ] = opticalFlowPixel(I1, I2, x, y, regionSize, sigma)
Gd = gaussianDer(sigma);

Ix = conv2(I1, Gd, 'same');
Iy = transpose(conv2(transpose(I1), Gd, 'same'));
It = I1 - I2;

IxR = Ix(x-regionSize:x+regionSize, y-regionSize:y+regionSize);
IyR = Iy(x-regionSize:x+regionSize, y-regionSize:y+regionSize);
ItR = It(x-regionSize:x+regionSize, y-regionSize:y+regionSize);

v = getV(IxR, IyR, ItR);

Vx = v(1);
Vy = v(2);

end

function v = getV(Ix, Iy, It)

Ixvec = reshape(Ix, size(Ix, 1) * size(Ix, 2), 1);
Iyvec = reshape(Iy, size(Iy, 1) * size(Iy, 2), 1);
b = reshape(It, size(It, 1) * size(It, 1), 1);

A = [Ixvec, Iyvec];

v = pinv(A' * A) * A' * b;

end


