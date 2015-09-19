clear
close all
global R0 a rhoh mn nn e xs deltax
global nL nx nt ne xa xb La Lb ta tb ea eb np
global dt nt
global p rhod xi0

R0=1.65; % major radius unit m
a=0.40;  % minor radius
e=a/R0;
rhoh=0.08; % vh/Omega=sqrt(2Th/M)/Omega, Omega=Be/M
xs=0.4; % rs/a position of rational surface q=1
deltax=0.06; % the artificial width along q=1 surface
rhod=0.01; % the drift orbit width
xi0=1.0; % ratio of displacement and minor radius, xi0/a

mn=1; % poloidal mode number
nn=1; % toroidal mode number

nL=100; % Lambda grid number
nt=20; % theta grid number
nx=20; % x grid number
ne=20; % epsilon grid number


xa=1e-06; % left boundary of x
xb=1.0;   % right boundary of x
La=1e-06; % left boundary of Lambda
Lb=1-0.3; % right boundary of Lambda
ta=1e-06; % left boundary of theta
tb=2*pi;  % right boundary of theta
ea=1e-06; % left boundary of epsilon
eb=4.0;   % right boundary of epsilon

% coordinate grids

dx=(xb-xa)/(nx);
x=xa:dx:xb; % construct x array priorly, 
            % without calculating xi every step
            
Lambda=zeros(nL+1,length(x));  % construct Lambda 2D array due to
for j=1:length(x)              % Lambda maximum as a function of x  
    Lb=1-eps1(x(j));           
    dL=(Lb-La)/(nL);
    Lambda(:,j)=La:dL:Lb;
end
            

dt=(tb-ta)/nt;
t=ta:dt:tb;  %left boundary of t  should be finite, 
             % otherwise, cannot form the grids of t for caculating theta
             % array t construct priorly which will 
             %accelerate the speed without caculating tj every step.
             
de=(eb-ea)/ne;
ee=ea:de:eb;

tau=1.0; % +1 or -1 for v_parallel direction 

tfun3D=zeros(nL+1,nx+1,nt+1); % collect tfun(Lambda,x,theta) data 
                              % store as 3D array
                              % according to above 
                              % defined coordinate grids


p=-1:1;                       % p=-1,0,1
np=length(p);                 

Yp3D=zeros(np,nL+1,nx+1); % collect Yp(p,Lambda,x) data 
                          %  store as 3D array
                          %  according to above 
                          %  defined coordinate grids
                          
WF3D=zeros(ne+1,nL+1,nx+1); % collect WF(epsilon,Lambda,x) data 
                            % store as 3D array
                            % according to above 
                            % defined coordinate grids
omega=5;

for j=1:nL                % j=nL+1 ellipitic function become infinite.
    for j1=1:nx+1         % elliminte this point
        for j2=1:nt+1
        tfun3D(j,j1,j2)=tfun(Lambda(j,j1),t(j2),x(j1),tau); % the data of 
        end                             % tfun store as 3D array, 
                                        % which also accelerates the 
                                        % speed without calculating 
                                        % tfun every step
        
    end
end
for j2=1:np
  for j=1:nL
    for j1=1:nx+1
        Yp3D(j2,j,j1)=Yp(Lambda(j,j1),tfun3D(j,j1,:),x(j1),p(j2),tau); % the data 
    end                                      % of Yp store as 3D 
                                              % array, which also acc-
                                              % -elerates the speed 
                                            % without calculating Yp 
                                            % every step
        
    
  end
end
for j2=1:ne+1
  for j=1:nL
    for j1=1:nx+1
        WF3D(j2,j,j1)=WF(omega,Lambda(j,j1),ee(j2),x(j1),Yp3D(:,j,j1)); % the data 
    end                                      % of WF store as 3D 
                                             % array, which also 
                                             % accelerates the speed 
                                             % without calculating WF 
                                             % every step
        
    
  end
end
