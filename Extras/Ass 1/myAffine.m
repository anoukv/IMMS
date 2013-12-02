function r = myAffine(image, x1, y1, x2, y2, x3, y3, M, N, method)
r = zeros(N, M); %allocate new image of correct size)
%calculate X (insert code for this)
A = [x1, y1, 1; x2, y2, 1; x3, y3, 1]';
B = [0, 0, 1; 0, M, 1; N, 0, 1]';
X = B / A;
for xa = 1:M
    for ya = 1:N
        b = [xa;ya;1];
        b = inv(X) * b;
        %calculate x and y (insert code for this)
        r(ya, xa) = pixelValue(image, b(2), b(1), method);
    end
end