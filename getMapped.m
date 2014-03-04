function [mapped] = getMapped(toMap,withThis)

if nargin<2
    error('Not enough arguments provided');
end

mapped = zeros(1,length(withThis));
m = 1;
for i = 1:length(toMap)
    for j = 1:fix(length(withThis)/length(toMap))
        mapped(m) = toMap(i);
        m = m+1;
    end
end