function G = gaussian(sigma)

%
%   Return a local gaussian peak with sigma
%

% Define the size depending on sigma
size = round(3 * sigma);
x = -size:size;

% Find the gaussian
G = 1 /sigma * sqrt(2 * pi) * exp(-x.^2 / (2 * sigma.^2));

% Normalize (for fun).
G = G./ sum(G);

end

