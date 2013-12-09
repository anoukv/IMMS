function [ dist ] = kernel3(data1, data2)

dist = sum(abs(data1-data2).^0.5);

end

