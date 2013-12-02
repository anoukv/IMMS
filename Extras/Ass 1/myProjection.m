function projection = myProjection(image, x1, y1, x2, y2, x3, y3, x4, y4, m, n, method)

projection = zeros(m, n); %allocate new image of correct size
%calculate projection matrix
xy = [x1, y1; x2, y2; x3, y3; x4, y4];
uv = [0, 0; 0, n; m, n; m, 0];
projMatrix = createProjectionMatrix(xy, uv);
projMatrix33 = [projMatrix(1),projMatrix(2),projMatrix(3);
                projMatrix(4),projMatrix(5),projMatrix(6);
                projMatrix(7),projMatrix(8),projMatrix(9)];
            
projMatrix33 = inv(projMatrix33);

for yIndex = 1:m
    for xIndex = 1:n
        %calculate x and y
        p = [yIndex; xIndex; 1];
        p = projMatrix33 * p;
        x = p(1) / p(3);
        y = p(2) / p(3);
        projection(yIndex, xIndex) = pixelValue(image, y, x, method);
    end
end
end