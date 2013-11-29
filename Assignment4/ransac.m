function [ transformation ] = ransac(n, coordinates1, coordinates2, p)
% INPUT
% n - number of iterations
% coordinates1 / coordinates2 = 2xMatches coordinates
% p - number of matches from total set of matches (t)

mostInliers = 0;
%for i = 1:n
    % Pick P matches at random from the total set of matches
    
    indices = randperm(size(coordinates1, 2), p);
    data1 = coordinates1(:, indices)
    data2 = coordinates2(:, indices)
    [m1, m2, m3, m4, t1, t2] = getAffineTrasformation(data1, data2);
    
    % draw something somewhere (see assignment)
    
    % transform data1 with [m1, m2, ...]. 
    % compare this to actual data2
    % every transformed pixel in 10 pixel radius of original point in data2
    % is inlier, all other outliers. If numberOfInliers > mostInliers, save
    % the inliers (?) and [m1, m2, ...] as best model. Return [m1, m2, ..]
%end

end


