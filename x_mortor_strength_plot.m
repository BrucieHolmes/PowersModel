function [] = x_mortor_strength_plot(Time_hrs,compressive_strength)

figure
xaxis1 = Time_hrs;
yaxis = compressive_strength;
yaxisA = smooth(yaxis);
semilogx(xaxis1,yaxisA,'k-')
xlabel('Hydration Time (hrs)')
ylabel('Compressive Strength (MPa)')
title('Compressive Strength of ASTM C109 Mortar cubes')
set(gca,'fontsize',15)
grid on 
end

