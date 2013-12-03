function [ bestM, bestT ] = ransac(im1, im2, n, coordinates1, coordinates2, p)
% INPUT
% n - number of iterations
% coordinates1 / coordinates2 = 2xMatches coordinates
% p - number of matches from total set of matches (t)

% WE STILL NEED TO DRAW SOME THINGS, SAVE THE INLIERS? WHY? HOW MANY
% MATHCES DO WE NEED, SOME QUESTION ABOUT P...

mostInliers = 0;

for i = 1:n
    % Pick P matches at random from the total set of matches
    
    indices = randperm(size(coordinates1, 2), p);
    data1 = coordinates1(:, indices);
    data2 = coordinates2(:, indices);
    [ M, t ]  = getAffineTrasformation(data1, data2);
        
    % transform coordinates2 with [m1, m2, ...]. 
    transformedCoordinates = performAffineTransformation(M, t, coordinates1);
    
    %figure, plotMatches(im1, im2, coordinates1, transformedCoordinates);
    
    % compare this to actual coordinates1
    % every transformed pixel in 10 pixel radius of original point in data2
    % is inlier, all other outliers. If numberOfInliers > mostInliers, save
    dist = euclideanDistance(transformedCoordinates, coordinates2) < 10;
    inliers = sum(sum(dist));
  
    % save the set of inliers? Do we really need to do this?
    if mostInliers < inliers
        mostInliers = inliers;
        bestM = M;
        bestT = t;
    end
end

end
