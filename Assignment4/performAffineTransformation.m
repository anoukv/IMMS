function [ newCoordinates ] = performAffineTransformation( M, t, coordinates )

% this should be possible without a for loop...

% create new coordinates
newCoordinates = zeros(size(coordinates));

% loop over the newCoordinates and compute them using the old coordinates,
% M and t.
for i = 1:size(coordinates, 2)
    newCoordinates(:, i) = M * coordinates(:, i) + t;
end


end

