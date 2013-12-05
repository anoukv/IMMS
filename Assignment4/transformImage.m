function [ transformedImage ] = transformImage( im, M, t )

% get height and width from the original image
[height, width] = size(im);

% compute 4 corner locations
c1=[1;1];
c2=[1;width];
c3=[height;1];
c4=[height; width];

% compute the transformed corner locations
c1 = M * c1;
c2 = M * c2;
c3 = M * c3;
c4 = M * c4;

% the new height and the new widht can be found by looking at the
% postitions of the new corners (the differneces between them)
newH = floor(max(abs(c1(1) - c4(1)), abs(c2(1) - c3(1))));
newW = floor(max(abs(c1(2) - c4(2)), abs(c2(2) - c3(2))));

% initiate new transformed image
transformedImage = zeros(newH,newW);

% this is an inverse transformation (from im2 -> im1), so we need to
% inverse the M and t.
M = inv(M);
t = -t;

% iterate over new image
% compute the transformed point
% find the nearest neighbor, look it up in the original image (if the new
% point is actually in the image)
% write the value into the new image
for x = 1:newH
    for y = 1:newW
        p = [x;y];
        p = M * p + t;
        
        if inImage(size(im), p(1), p(2))
            p(1) = round(p(1));
            p(2) = round(p(2));
            value = im(p(1), p(2));
        else
            value = 0;
        end
        
        transformedImage(x, y) = value;
    end
end

end
