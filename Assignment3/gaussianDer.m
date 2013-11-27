function Gd = gaussianDer(sigma)

%
%   Returns the gaussian derivative of G with sigma.
%

% prepare data
G = gaussian(sigma);
size = round(3 * sigma);
x = -size:size;

% Perform calculation
Gd = (- x / sigma.^2) .* G;

end

