function [ bestM, bestT, setInliers ] = ransac(im1, im2, n, coordinates1, coordinates2, p, plot)
% INPUT
% n - number of iterations
% coordinates1 / coordinates2 = 2xMatches coordinates
% p - number of matches from total set of matches (t)

% p should be greater than 4. This is the minimum amount of points
% necessary to describe an affine transformation, thus four points are
% needed to compute one

% initialize the greatest number of inliers found
mostInliers = 0;

% perform n iterations
for i = 1:n
    
    % get p random indices for the points that are to be used
    indices = randperm(size(coordinates1, 2), p);
    
    % extract the two random sets of points
    data1 = coordinates1(:, indices);
    data2 = coordinates2(:, indices);
    
    % compute the affine transformation that transforms data1 into data2
    [ M, t ]  = getAffineTrasformation(data1, data2);
        
    % transform coordinates2 with the affine transformation found in the step above 
    transformedCoordinates = performAffineTransformation(M, t, coordinates1);
    
    if plot == true
        figure, plotMatches(im1, im2, coordinates1, transformedCoordinates);
    end
    
    % compute the euclidean distance between the original set of
    % coordinates (set 2) and the transformed coordinates (set 1)
    % if the euclidean distance < 10, we say it is an inlier (1) otherwise,
    % it is an outlier (0)
    dist = euclideanDistance(transformedCoordinates, coordinates2) < 10;
    
    % sum the ones from the distances matrix, giving the number of inliers
    inliers = sum(sum(dist));

    % if the number of inliers exceeds the largest number of inliers so far
    % we will save the transformation
    if mostInliers < inliers
        mostInliers = inliers;
        bestM = M;
        bestT = t;
        setInliers = dist;
    end
end

end
