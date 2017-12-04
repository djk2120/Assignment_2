
base = '/glade2/scratch2/djk2120/rc_ens/';
a = dir([base,'BR*']);

var_list = {'FCTR','FPSN','QROOTSINK'};

offset = 10;
ns     = 20;
nx     = length(a);

out  = zeros(nx,6);
outd_fctr = zeros(nx,51);
outd_fpsn = zeros(nx,51);
for i = 1:nx
    
    f=[base,a(i).name];


    disp(i)
    k  = str2double(a(i).name(25:26));
    g1 = str2double(a(i).name(28));
    p  = str2double(a(i).name(30:31));


    if 1==1
        x = getvars( f , offset, ns, 1);
        ix = month>8&month<12&year<2003;
        g  = findgroups(mcsec(ix));
    end

    if 1==1

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
end

dlmwrite('full.txt',out,'delimiter','\t')
dlmwrite('fpsn.txt',outd_fpsn,'delimiter','\t')
dlmwrite('fctr.txt',outd_fctr,'delimiter','\t')

