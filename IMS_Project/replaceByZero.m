function [ vector ] = replaceByZero( vector )

% replaces non-ones in a vector by zeros. 
for i = 1:size(vector, 1)
   if vector(i) ~= 1
       vector(i) = 0;
   end
end

end

