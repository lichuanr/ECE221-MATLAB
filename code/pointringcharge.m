
zprime = linspace(-3, 3, 500);
for i = 1:500
    if (i > 250)
        E(i) = lineofcharge(0.5, 2*3*(10^(-3)), 0, 0, zprime(i), 500);
    else
        E(i) = - lineofcharge(0.5, 2*3*(10^(-3)), 0, 0, zprime(i), 500);
    end
    E_THEORY(i) = 2*3*(10^(-3))*0.5*zprime(i)/(2*8.854e-12*((zprime(i)^2+0.5^2)^(3/2)));
    
end

figure


x = linspace(-3, 3, 500);

plot(E, x, 'ro')
hold on;
plot(E_THEORY, x, 'b-')

xlabel('z - offset');
ylabel('electric fields along z axis');
legend('E calculated', 'E theory', 0);
hold off;



