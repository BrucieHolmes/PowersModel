function [powers_output] = powers (alpha, wc_ratio, volumes, Time)

% THIS FUNCTION CALCULATES THE POWERS HYDRATION PREDICTIONS OF:
% CHEMICAL SHRINKAGE, CAPILLARY WATER, GEL WATER, GEL SOLIDS, CEMENT AND 
% VOLUME BALANCE

% DENSITY WATER = 1g/cm3
pc = wc_ratio / (wc_ratio+(1/volumes(4)));
%Vb = cement_properties(3)*0.01*(densities(12)/volumes(4));

chemical_shrinkage = single(zeros(Time,1));
capillary_water = single(zeros(Time,1));
gel_water = single(zeros(Time,1));
gel_solids = single(zeros(Time,1));
cement = single(zeros(Time,1));
volume_balance = single(zeros(Time,1));

for i = 1:Time
    chemical_shrinkage(i) = 0.2*(1-pc).*alpha(i);
    capillary_water(i) = pc - (1.32*(1-pc).*alpha(i));
    gel_water(i) = 0.6*(1-pc).*alpha(i);
    gel_solids(i) = 1.52*(1-pc).*alpha(i);
    cement(i) = (1-pc).*(1-alpha(i));
    volume_balance(i) = (chemical_shrinkage(i) + capillary_water(i) + ...
    gel_water(i) + gel_solids(i) + cement(i));
end

% CAPILLARY POROSITY, WATER FILLED POROSITY & UNDRATED CEMENT PHASE FRACTIONS
porosity_water_filled = single(zeros(Time,1));
porosity_total_capillary = single(zeros(Time,1));

% Pcem = cement density
% fexp = volumetric expansion coeff for solid cement hydration products
% relative to the ement reacted = 1.15
% CS = chemical shrinkage per gram of cement = 0.07mL/g
 
for i = 1:Time
    porosity_water_filled(i) = ((volumes(4)*wc_ratio)-((1.15+(volumes(4)*...
        0.07)).*alpha(i)))/(1+(volumes(4)*wc_ratio));
    porosity_total_capillary(i) = ((volumes(4)*wc_ratio)-(1.15.*alpha(i)))/...
        (1+(volumes(4)*wc_ratio));
end

powers_output = [chemical_shrinkage, capillary_water, gel_water, ...
gel_solids, cement, volume_balance, porosity_water_filled, ...
porosity_total_capillary];

end
