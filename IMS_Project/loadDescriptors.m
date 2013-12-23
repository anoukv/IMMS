function [v ] = loadDescriptors( class, number )

name = strcat('../../IMS_data/Descriptors/', class, '/image', int2str(number));

v = load(name, 'desc');
v = single(v.desc);

end

