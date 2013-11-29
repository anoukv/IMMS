function [ transformation ] = ransac(n, coordinates1, coordinates2, p)
% INPUT
% n - number of iterations
% coordinates1 / coordinates2 = 2xMatches coordinates
% p - number of matches from total set of matches (t)

%for i = 1:n
    % Pick P matches at random from the total set of matches
    indices = randperm(size(coordinates1, 2), p);
    data1 = coordinates1(:, indices);
    data2 = coordinates2(:, indices);
    getAffineTransformation(data1, data2);
    
    
    
end


