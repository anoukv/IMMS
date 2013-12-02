function color = pixelValue(image, x, y, method)
% pixel value at real coordinates

if inImage(size(image),x,y)
    % do the interpolation
    switch(method)
        case 'nearest'
            % Do nearest neighbour
            x = floor(x+1/2);
            y = floor(y+1/2);
            color = image(x,y);
        case 'linear'
            k = floor(x);
            l = floor(y);
            a = x - k;
            b = y - l;
            color = (1-a)*(1-b)*image(k,l) + (1-a)*b*image(k,l+1)+a*b*image(k+1,l+1) + a*(1-b)*image(k+1,l);
            % Do bilinear interpolation
    end
else
    color = 42;

end

