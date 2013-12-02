function rotatedImage = rotateImage(image, angle, method)
% Create the necessary rotation matrix
r = [cos(angle) -sin(angle); sin(angle) cos(angle)];

ri = inv(r); 

[width, length] = size(image);
rotatedImage = zeros(width, length);
mid = size(image)'/2;
%Obtain indices needed for interpolation

for x=1:width
    for y=1:length
        p = [x;y];
        p = p - mid;
        p = ri*p;
        p = p + mid;
        rotatedImage(x,y) = pixelValue_new(image, p(1), p(2), method);
    end
end
        
%Obtain colours for the whole rotatedImage matrix
%using the specified interpolation method

end

