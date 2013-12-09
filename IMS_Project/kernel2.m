function [ dist ] = kernel2(data1, data2)

dist = sum(abs(data1-data2).^2);

end

