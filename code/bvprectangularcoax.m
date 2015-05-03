function [V,Ex,Ey,C,We,We2,gridpointsx,gridpointsy,innerx,innery,outerx,outery]=bvprectangularcoax(a,b,c,d,xo,yo,er,Vo)
%
% [V,Ex,Ey,C,We,gridpointsx,gridpointsy,innerx,innery,outerx,outery]=bvprectangularcoax(a,b,c,d,xo,yo,er,Vo)
%
% This function used the finite difference method to solve the
% two-dimensional electrostatic boundary value problem related to a square
% coaxial cable.
%   a = width of outer conductor
%   b = height of outer conductor
%   c = width of inner conductor
%   d = height of inner conductor
%   xo = the x-coordinate of the location of the bottom left corner of the inner conductor
%   yo = the y-coordinate of the location of the bottom left corner of the inner conductor
%   er = the relative permittivity of the dielectric which fills the space
%   between the inner and outer conductor
%   Vo = electric potential of the inner conductor (outer is grounded)

% Define the fundamental constant eo
eo=8.854e-12;

% Set number of nodes and node spacings
Nx=201;
hx=a/(Nx-1)
hy=hx;
Ny=round(b/hy+1)

% Set the initial values of V to zero
V = zeros(Nx,Ny);

% Set the known potential values (or boundary values)
V(1,1:Ny)=0; % Grounded left side
V(1:Nx,1)=0; % Grounded bottom side
V(Nx,1:Ny)=0; % Grounded right side
V(1:Nx,Ny)=0; % Grounded top side

innerstartx=round(xo/hx+1);
innerendx=round(innerstartx+c/hx);
innerstarty=round(yo/hy+1);
innerendy=round(innerstarty+d/hy);
V(innerstartx:innerendx,innerstarty:innerendy)=Vo; % Set potentials of inner conductor

% Determine the final voltage distributions (your code goes here...)
