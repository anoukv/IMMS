function [ bins ] = descriptors4vocabulary2bins( imageDescriptors, Vocabulary )

bins = zeros(size(Vocabulary,1),1);
for i=1:size(imageDescriptors,1)
    bestMatchIndex = 0;
    bestMatchValue = 99999999;
    
    for j=1:size(Vocabulary,1)
        distance = sum(abs(imageDescriptors(i) - Vocabulary(j)));
        if distance < bestMatchValue
            bestMatchValue = distance;
            bestMatchIndex = j;
        end
    end
    
    bins(bestMatchIndex) = bins(bestMatchIndex) + 1;
end

bins = bins ./ size(imageDescriptors,1);

end
