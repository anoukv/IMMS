function [r, c] = dropFeaturesThatArOutOfTheImage(r, c, regionSize, imageDimensions)

r_ = -ones(size(r));
c_ = -ones(size(r));

counter = 1;
for i=1:size(r,1)
    if r(i) < imageDimensions(1)-regionSize-1 && r(i) > regionSize+1
        if c(i) < imageDimensions(1)-regionSize-1 && c(i) > regionSize+1
            r_(counter) = r(i);
            c_(counter) = c(i);
            counter = counter + 1;
        end
    end
end

r = r_(1:counter-1);
c = c_(1:counter-1);

end