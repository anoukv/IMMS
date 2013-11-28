function [ Vx, Vy ] = opticalFlow(I1, I2, regionSize, sigma, plotter)
Gd = gaussianDer(sigma);

Ix = conv2(I1, Gd, 'same');
Iy = transpose(conv2(transpose(I1), Gd, 'same'));
It = I1 - I2;

if plotter == true
    figure,
    subplot(1,3,1);
    imshow(Ix,[]), title('Ix');
    subplot(1,3,2);
    imshow(Iy,[]), title('Iy');
    subplot(1,3,3);
    imshow(It,[]), title('It');
end

x_max = floor(size(I1,1)/ regionSize);
y_max = floor(size(I1,2)/ regionSize);

Vx = zeros(x_max, y_max);
Vy = zeros(x_max, y_max);

Vx_ = zeros(x_max, y_max);
Vy_ = zeros(x_max, y_max);


offSet = floor(2 + regionSize / 2);

% It is the difference between intensity in img1 and im2 I(im1) - I(im2)
for x = 1:x_max
    for y = 1:y_max
        IxR = Ix(1+(x-1)*regionSize:(x)*regionSize, 1+(y-1)*regionSize:(y)*regionSize);
        IyR = Iy(1+(x-1)*regionSize:(x)*regionSize, 1+(y-1)*regionSize:(y)*regionSize);
        ItR = It(1+(x-1)*regionSize:(x)*regionSize, 1+(y-1)*regionSize:(y)*regionSize);
        
        v = getV(IxR, IyR, ItR);
        
        Vx_(x,y) = v(1);
        Vy_(x,y) = v(2);
                
        Vx(x,y) = offSet +(x-1)*regionSize;
        Vy(x,y) = offSet +(y-1)*regionSize;
    end
end

if plotter == true 
    figure,
    imshow(I1), hold on, quiver(Vy,Vx, Vx_, Vy_), hold off;
end

end

function v = getV(Ix, Iy, It)

Ixvec = reshape(Ix, size(Ix, 1) * size(Ix, 2), 1);
Iyvec = reshape(Iy, size(Iy, 1) * size(Iy, 2), 1);
b = reshape(It, size(It, 1) * size(It, 1), 1);

A = [Ixvec, Iyvec];

v = pinv(A' * A) * A' * b;

end


