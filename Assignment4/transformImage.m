function [ transformedImage ] = transformImage( im, M, t )
[width, height] = size(im);
transformedImage = zeros(size(im));


for x = 1:width
    for y = 1:height
        p = [x;y];
        p = M * p + t;
        transformedImage(x, y) = interPolationHelper(im, p(1), p(2));
    end
end

end

