function [ bool ] = inImage( s, x, y )
% Check wether x and y are in the image

% x and y have to be >= 1 and <= to the relevant dimensions
if s(1) >= x & x >= 1
    if s(2) >= y & y >= 1
        bool = true;
    else
        bool = false;
    end
else
    bool = false;
end

end

