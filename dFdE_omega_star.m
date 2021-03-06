function dFdE_omega_star_3D=dFdE_omega_star(nx,xarray,nL,Larray,nE,Earray,F_r_3D)  %3D (r,Lambda,E)
    global R0 a m_mode rhoh
    dFdE_omega_star_3D(1:nx,1:nL,1:nE)=0;
    m=m_mode;

    c= R0*rhoh*m/a;
    
    for ix=1:nx
        for iL=1:nL
            for iE=1:nE
    dFdE_omega_star_3D(ix,iL,iE) =F_r_3D(ix,iL,iE)*c/(2*xarray(ix));
            end
        end
    end
    
end