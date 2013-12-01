function [ bestTransformationParameters ] = ransac(n, coordinates1, coordinates2, p)
% INPUT
% n - number of iterations
% coordinates1 / coordinates2 = 2xMatches coordinates
% p - number of matches from total set of matches (t)

mostInliers = 0;
bestTransformationParameters = [];

for i = 1:n
    % Pick P matches at random from the total set of matches
    
    indices = randperm(size(coordinates1, 2), p);
    data1 = coordinates1(:, indices);
    data2 = coordinates2(:, indices);
    T = getAffineTrasformation(data1, data2);
    
    % draw something somewhere (see assignment)
    
    % transform coordinates2 with [m1, m2, ...]. 
    coordinates_ = performAffineTransformation(T, coordinates2);
    
    % compare this to actual coordinates1
    % every transformed pixel in 10 pixel radius of original point in data2
    % is inlier, all other outliers. If numberOfInliers > mostInliers, save
  
    inliers = 9;
    if mostInliers < inliers
        mostInliers = inliers;
        bestTransformationParameters = T;
    end
end

end


function [coordinates_] = performAffineTransformation(T, coordinates)

coordinates_ = zeros(size(coordinates));
for i=size(coordinates,1)
    coordinates_(i) = coordinates(i) * T;
end

end