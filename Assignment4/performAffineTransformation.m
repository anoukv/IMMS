function [ newCoordinates ] = performAffineTransformation( M, t, coordinates )

% this should be possible without a for loop...
newCoordinates = zeros(size(coordinates));

for i = 1:size(coordinates, 2)
    newCoordinates(:, i) = M * coordinates(:, i) + t;
end


end

