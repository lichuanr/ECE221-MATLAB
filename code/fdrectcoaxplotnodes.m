function [gridpointsx,gridpointsy,innerx,innery,outerx,outery]=fdrectcoaxplotnodes(a,b,c,d,xo,yo,Nx,Ny,contourdel)
%
%   function [gridpointsx,gridpointsy,innerx,innery,outerx,outery]=fdrectcoaxplotnodes(a,b,c,d,xo,yo,Nx,Ny,contourdel)
%   This function creates a plot of the node grid for the finite difference
%   method solution of the potential within a rectangular coaxial cable.
%
%   contourdel = this is a parameter that specifies the location of the
%   contour which is used in the Gauss's law calcuation of the charge on
%   the inner conductor.  Specifically, this is the number of nodes away
%   from the inner conductor at which the inner nodes of the contour exist
%   (i.e., the VIC points).
%

% Determine node spacings in the x and y directions
hx=a/(Nx-1);
hy=b/(Ny-1);

% Determine indexes that represent the inner conductor
% These are rounded to ensure that they are integers
innerstartx=round(xo/hx+1);
innerendx=round(innerstartx+c/hx);
innerstarty=round(yo/hy+1);
innerendy=round(innerstarty+d/hy);

% Plot the grid points and known voltage points

% gridpointsx is a matrix (size Nx x Ny) that contains the x-values of the
% locations of the nodes within the grid.
% gridpointsy is a matrix (size Nx x Ny) that contains the y-values of the
% locations of the nodes within the grid.
[gridpointsx,gridpointsy]=meshgrid(0:hx:a,0:hy:b);

% innerx and innery are matrices that contains the x- and y-values of the
% locations of the nodes that relate to the inner conductor.
[innerx,innery]=meshgrid((innerstartx-1)*hx:hx:(innerendx-1)*hx,(innerstarty-1)*hy:hy:(innerendy-1)*hy);

% outerx and outery are matrices that contains the x- and y-values of the
% locations of the nodes that relate to the outer conductor.
outerx=[0:hx:a,zeros(1,Ny-2),a:-hx:0,zeros(1,Ny-2)];
outerx((Nx+1):(Nx+Ny-2))=a;
outery=[zeros(1,Nx),hy:hy:(b-hy),zeros(1,Nx),(b-hy):-hy:hy];
outery((Nx+Ny-1):(2*Nx+Ny-2))=b;

figure
% Plot all the nodes
plot(gridpointsx,gridpointsy,'b*');hold;

% Plot the known potentials of the outer conductor
plot(outerx,outery,'g+');

% Plot the known potentials of the inner conductor
plot(innerx,innery,'ro');

% Plot the location of the contour which is used in the Gauss's law
% calculation of the charge on the inner conductor
plot(gridpointsx(innerstarty-contourdel,innerstartx-contourdel:innerendx+contourdel),gridpointsy(innerstarty-contourdel,innerstartx-contourdel:innerendx+contourdel),'r--');
plot(gridpointsx(innerendy+contourdel,innerstartx-contourdel:innerendx+contourdel),gridpointsy(innerendy+contourdel,innerstartx-contourdel:innerendx+contourdel),'r--');
plot(gridpointsx(innerstarty-contourdel:innerendy+contourdel,innerstartx-contourdel),gridpointsy(innerstarty-contourdel:innerendy+contourdel,innerstartx-contourdel),'r--');
plot(gridpointsx(innerstarty-contourdel:innerendy+contourdel,innerendx+contourdel),gridpointsy(innerstarty-contourdel:innerendy+contourdel,innerendx+contourdel),'r--');
