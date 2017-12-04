% Parameter ensemble analysis script
%    Dec 4, 2017
%    Daniel Kennedy - djk2120@columbia.edu
%    ---------------------------------

% Summary:
%    Reads in the .nc files one at a time and extracts the mean
%    transpiration/photosynthesis, and total hydraulic redistribution,
%    writing output with the associated parameter values to full.txt
%    
%    Also extracts SON 2001-2 diurnal cycle of photosynthesis and
%    transpiration outputting to fspn.txt and fctr.txt, respectively.
%
%    Dependencies: getvars.m, rc_ens/*.nc
%
%    The input data for this script is located at dropbox.com, 
%    contains 216 netcdf files
%    
%    To extract:
%    tar -xvzf rc_ens.tar.gz
%    ---------------------------------


% get a list of the files
base = './rc_ens/';
a = dir([base,'*.nc']);

% set up 
offset   = 10;                           % used to convert to local time
ns       = 20;                           % number of soil layers
nx       = length(a);                    % number of experiments
var_list = {'FCTR','FPSN','QROOTSINK'};  % variables of interest

% initialize output matrices
out  = zeros(nx,6);
outd_fctr = zeros(nx,51);
outd_fpsn = zeros(nx,51);

% loop through simulations one at a time
% avoid having multiple simulations in memory
for i = 1:nx

    disp(i)              % for sanity
    
    f=[base,a(i).name];  % file location

    %extract parameter info from file name
    k  = str2double(a(i).name(25:26));
    g1 = str2double(a(i).name(28));
    p  = str2double(a(i).name(30:31));

    if i==1
        % get descriptive data only on first iter
        %  because it's the same for all sims
        x = getvars( f , offset);
        ix = month>8&month<12&year<2003;
        g  = findgroups(mcsec(ix));
    end

    % loop through variables of interest extracting desired data
    for v = 1:3
        tmp = ncread(f,var_list{v});
        if v==3
            targ = zeros(length(tmp(1,:,1)),length(year));
            targ(:,:) = tmp(1,:,1+offset:end);
            out(i,3+v) = 1800*sum(sum(targ.*(targ<0)));
        else
            targ = tmp(1+offset:end);
            out(i,1:3) = [k,g1,p];
            out(i,3+v) = mean(targ);
            if v==1
                outd_fctr(i,1:3)   = [k,g1,p];
                outd_fctr(i,4:end) = splitapply(@mean,targ(ix),g);
            else
                outd_fpsn(i,1:3)   = [k,g1,p];
                outd_fpsn(i,4:end) = splitapply(@mean,targ(ix),g);
            end
        end
    end
    
end

% write the data to output files for plotting
dlmwrite('full.txt',out,'delimiter','\t')
dlmwrite('fpsn.txt',outd_fpsn,'delimiter','\t')
dlmwrite('fctr.txt',outd_fctr,'delimiter','\t')

