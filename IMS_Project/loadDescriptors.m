function [v ] = loadDescriptors( class, number )

name = strcat('compiled/Descriptors/', class, '/image', int2str(number));

v = load(name, 'desc');
v = v.desc;

end

