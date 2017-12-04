function [ a ] = getvars( file , offset)
%getvars Fetches some descriptive data from file
%   returns vectors for year,month,and time of day
%   from file, based on offset

temp  = double(ncread(file,'mcdate'));
n     =length(temp)-offset;

mcdate    = zeros(1,n);
mcdate(:) = temp(1:end-offset);

mcsec     = zeros(1,n);
temp      = double(ncread(file,'mcsec'));
mcsec(:)  = 1+temp(1:end-offset);

year  = floor(mcdate/10000);
month = floor((mcdate-10000*year)/100);

assignin('caller','mcsec' ,mcsec);
assignin('caller','year'  ,year);
assignin('caller','month' ,month);

a = ncinfo(file);

end

