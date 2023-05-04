function [volumes] = volume_calculations (wc_ratio)

% THIS FUNCTION CALCULATES THE TOTAL CEMENT AND WATER VOLUME, WEIGHT & DENSITY

% VOLUME & WEIGHT CALCULATIONS OF CEMENT
Total_volume = 100^3;
density_cement = 3.15;
Cement_Vol = (Total_volume*(1/density_cement))/((1/density_cement)+wc_ratio);
volume_water = Total_volume - Cement_Vol;
Weight_Cement = density_cement * Cement_Vol;
per_cement_volume = 100*Cement_Vol/Total_volume;
per_water_volume = 100*volume_water/Total_volume;

volumes = [Cement_Vol, volume_water, Weight_Cement, density_cement, ...
per_cement_volume, per_water_volume];

end