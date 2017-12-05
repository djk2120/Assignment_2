% Parameter ensemble setup script
%    Dec 4, 2017
%    Daniel Kennedy - djk2120@columbia.edu
%    ---------------------------------

% Summary:
%    Creates a parameter file for each ensemble member. By varying kmax,
%    psi50, and medlyn slope. Note that krmax is tethered to kmax.
%
%    6^3 = 216 ensemble members in total.
%    
%    Dependencies: getvars.m, rc_ens/*.nc
%
%    ---------------------------------



template = '/glade/u/home/djk2120/paramfiles/aug17/k4g7.nc';

psi50 = ncread(template,'psi50');
kmax  = ncread(template,'kmax');
krmax = ncread(template,'krmax');
g1    = ncread(template,'medlynslope');
xf = krmax(5,:)/kmax(5,1);

for pval = 13:4:33
for gval = 4:9
for kval = 10:15:85 
    newfile  = ['/glade/p/work/djk2120/clm4_5_16_r251/cime/scripts/rc_ens/paramfiles/',...
               'k',num2str(kval),...
               'g',num2str(gval),...
               'p',num2str(pval),'.nc'];
    disp(newfile)
    cmd = ['cp ',template,' ',newfile];
    system(cmd);

    psi50(:,:)=-pval*10^4;
    kmax(:,:) = kval*10^-9;
    krmax(:)  = kmax(5,1)*xf;
    g_i = g1;
    g_i(:) = gval;
    ncwrite(newfile,'medlynslope',g_i);
    ncwrite(newfile,'kmax',kmax);
    ncwrite(newfile,'krmax',krmax);
    ncwrite(newfile,'psi50',psi50);

end
end
end


