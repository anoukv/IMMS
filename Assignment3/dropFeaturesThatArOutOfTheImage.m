function [r, c] = dropFeaturesThatArOutOfTheImage(r, c, regionSize, imageDimensions)
%
%   filters r, c for points that fall off the image.
%   returns r, c that lay in the image.
%

% Allocate space for filtered r and c
r_ = zeros(size(r));
c_ = zeros(size(r));

% Fill r_, and c_ with valid points
counter = 1;
for i=1:size(r,1)
    if r(i) < imageDimensions(1)-regionSize-1 && r(i) > regionSize+1
        if c(i) < imageDimensions(1)-regionSize-1 && c(i) > regionSize+1
            r_(counter) = r(i);
            c_(counter) = c(i);
            counter = counter + 1;
        end
    end
end

% Set r and c to the valid points.
r = r_(1:counter-1);
c = c_(1:counter-1);

end