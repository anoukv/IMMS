function [ value ] = interPolationHelper( im, x, y )
if inImage(size(im), x, y)
    x = floor(x+1/2);
    y = floor(y+1/2);
    value = im(x, y);
else
    value = 0;
end

end

