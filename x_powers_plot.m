function [] = x_powers_plot (Time,Time_hrs,powers_output)

figure
subplot (1,7,1)
xaxis1 = Time_hrs;
yaxis = powers_output(1:Time,1).*100;
yaxisA = smooth(yaxis);
semilogx(xaxis1,yaxisA,'k-')
xlabel('Time (hrs)')
ylabel('Chemical Shrinkage (%)')
set(gca,'fontsize',15)
grid on
subplot (1,7,2)
xaxis1 = Time_hrs;
yaxis = powers_output(1:Time,2);
yaxisA = smooth(yaxis);
semilogx(xaxis1,yaxisA,'k-')
xlabel('Time (hrs)')
ylabel('Capillary water fraction')
set(gca,'fontsize',15)
grid on
subplot (1,7,3)
xaxis1 = Time_hrs;
yaxis = powers_output(1:Time,3);
yaxisA = smooth(yaxis);
semilogx(xaxis1,yaxisA,'k-')
xlabel('Time (hrs)')
ylabel('Gel water fraction')
set(gca,'fontsize',15)
grid on
subplot (1,7,4)
xaxis1 = Time_hrs;
yaxis = powers_output(1:Time,4);
yaxisA = smooth(yaxis);
semilogx(xaxis1,yaxisA,'k-')
xlabel('Time (hrs)')
ylabel('Gel solids fraction')
set(gca,'fontsize',15)
title ('Powers Hydration & Porosity Model')
grid on
subplot (1,7,5)
xaxis1 = Time_hrs;
yaxis = powers_output(1:Time,5);
yaxisA = smooth(yaxis);
semilogx(xaxis1,yaxisA,'k-')
xlabel('Time (hrs)')
ylabel('Unhydrated Cement fraction')
set(gca,'fontsize',15)
grid on
subplot (1,7,6)
xaxis1 = Time_hrs;
yaxis = powers_output(1:Time,7).*100;
yaxisA = smooth(yaxis);
semilogx(xaxis1,yaxisA,'k-')
xlabel('Time (hrs)')
ylabel('Water-filled Porosity (%)')
set(gca,'fontsize',15)
grid on
subplot (1,7,7)
xaxis1 = Time_hrs;
yaxis = powers_output(1:Time,8).*100;
yaxisA = smooth(yaxis);
semilogx(xaxis1,yaxisA,'k-')
xlabel('Time (hrs)')
ylabel('Total Porosity (%)')
set(gca,'fontsize',15)
grid on

figure
powers_model = [powers_output(1:Time,5), powers_output(1:Time,4), ...
powers_output(1:Time,3), powers_output(1:Time,2), powers_output(1:Time,1)];
area(powers_model)
set (gca,'Xscale','log','fontsize',15);
legend('Cement','Gel Solids','Gel Water','Capillary Water','Chemical Shrinkage')
xlabel('Hydration Time (hrs)')
ylabel('Volume Fraction')
set(gca,'fontsize',15)
grid on

end