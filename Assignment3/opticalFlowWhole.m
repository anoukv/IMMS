function [ Vx, Vy ] = opticalFlowWhole(I1, I2, regionSize, sigma)
Gd = gaussianDer(sigma);

Ix = conv2(I1, Gd, 'same');
Iy = transpose(conv2(transpose(I1), Gd, 'same'));
It = I1 - I2;

x_max = size(I1,1);
y_max = size(I1,2);

Vx = zeros(x_max, y_max);
Vy = zeros(x_max, y_max);

% It is the difference between intensity in img1 and im2 I(im1) - I(im2)
v = getV(Ix, Iy, It);
size(v);
for x = 1:x_max
    for y = 1:y_max
        IxR = Ix(x_max, y_max);
        IyR = Iy(x_max, y_max);
        ItR = It(x_max, y_max);
        
        v = getV(IxR, IyR, ItR);
        
        Vx(x,y) = v(1);
        Vy(x,y) = v(2);
    end
end

figure,
quiver(Vx, Vy);

end

function v = getV(Ix, Iy, It)

Ixvec = reshape(Ix, size(Ix, 1) * size(Ix, 2), 1);
Iyvec = reshape(Iy, size(Iy, 1) * size(Iy, 2), 1);
b = reshape(It, size(It, 1) * size(It, 1), 1);

A = [Ixvec, Iyvec];

v = pinv(A' * A) * A' * b;

end


