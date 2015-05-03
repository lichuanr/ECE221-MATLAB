function [Etot, Ex, Ey, Ez] = lineofcharge(a, rhol, x, y, z, N)


epsilon=8.854e-12;

dt = (2*pi)/N;

tprime = linspace(0, 2*pi, N);

for k = 1:length(tprime)
    
    integrand = dt/(((x-a*cos(tprime(k)))^2+(y-a*sin(tprime(k)))^2+(z)^2)^(3/2));
    
    
    dEx(k) = integrand*(x-a*cos(tprime(k)));
    
    dEy(k) = integrand*(y-a*sin(tprime(k)));
    
    dEz(k) = integrand*z;
end

Ex = a*rhol*sum(dEx)/(4*pi*epsilon);

Ey = a*rhol*sum(dEy)/(4*pi*epsilon);

Ez = a*rhol*sum(dEz)/(4*pi*epsilon);

Etot = (Ex^2+Ey^2+Ez^2)^(1/2);



