function color = pixelValue_new(image, x, y, method)
% pixel value at real coordinates
id = size(image);
if inImage(id,x,y)
    % do the interpolation
    switch(method)
        case 'nearest'
            % Do nearest neighbour
            x = floor(x+1/2);
            y = floor(y+1/2);
            color = image(x,y);
        case 'linear'
            % Do bilinear interpolation
            k = floor(x);
            l = floor(y);
            a = x - k;
            b = y - l;
            color = (1-a)*(1-b)*image(k,l) + (1-a)*b*image(k,l+1)+a*b*image(k+1,l+1) + a*(1-b)*image(k+1,l);
    end
else
    if x >= id(1)
        x = id(1) - 2;
    end
    if x <= 1
        x = 2;
    end
    if y >= id(2)
        y = id(2) - 2;
    end
    if y <= 1
        y = 2;
    end
    switch(method)
        case 'nearest'
            % Do nearest neighbour
            x = floor(x+1/2);
            y = floor(y+1/2);
            color = image(x,y);
        case 'linear'
            % Do bilinear interpolation
            k = floor(x);
            l = floor(y);
            a = x - k;
            b = y - l;
            color = (1-a)*(1-b)*image(k,l) + (1-a)*b*image(k,l+1)+a*b*image(k+1,l+1) + a*(1-b)*image(k+1,l);
    end
end
end

