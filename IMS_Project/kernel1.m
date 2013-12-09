function [ dist ] = kernel1(data1, data2)

dist = sum(abs(data1-data2));

end

