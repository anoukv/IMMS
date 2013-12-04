function [ transformedImage ] = transformImage( im, M, t )
[height, width] = size(im);

c1=[1;1];
c2=[1;width];
c3=[height;1];
c4=[height; width];
    
c1 = M * c1;
c2 = M * c2;
c3 = M * c3;
c4 = M * c4;

% [c1,c2,c3,c4]
% 
% x = abs(c1(1)-c4(1));
% x = max(x, abs(c2(1)-c3(1)));
% y = abs(c1(2)-c4(2));
% y = max(y, abs(c2(2)-c3(2)));

newH = floor(max(abs(c1(1) - c4(1)), abs(c2(1) - c3(1))));
newW = floor(max(abs(c1(2) - c4(2)), abs(c2(2) - c3(2))));

transformedImage = zeros(newH,newW);

[height, width] = size(transformedImage);

size(transformedImage);
size(im);

M = inv(M);
t = -t;

for x = 1:height
    for y = 1:width
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

