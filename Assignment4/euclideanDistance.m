function [ distance ] = euclideanDistance( vec1, vec2 )
% computes the euclidean distance between two points
distance = sqrt(sum((vec1 - vec2)).^2);

end

