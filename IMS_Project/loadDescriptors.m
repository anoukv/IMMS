function [v ] = loadDescriptors( class, number, dens, colorspace )

suffix = strcat('_', dens, '_', colorspace);
name = strcat('../../IMS_data/Descriptors/', class, '/image', int2str(number), suffix);

v = load(name, 'desc');
v = single(v.desc);

end

