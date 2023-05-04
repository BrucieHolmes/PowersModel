function [unhydrated] = modified_bogue(oxides, molar_mass)

% THIS FUNCTION DETERMINES THE CEMENT PHASE & GYPSUM PROPORTIONS USING THE
% BOGUE METHOD / EQUATIONS FROM MEASURED OXIDE CONCENTRATIONS

% BASED ON EXCEL SPREADSHEET SHARED BY BARBARA LOTHENBACH
% STEP 1 - CALCULATE mol/100g OF SPECIES
SiO2_mol = oxides(1)/(molar_mass(5)+2*molar_mass(1));
Al2O3_mol = oxides(2)/(2*molar_mass(4)+3*molar_mass(1));
Fe2O3_mol = oxides(3)/(2*molar_mass(6)+3*molar_mass(1));
CaO_mola = oxides(4)/(molar_mass(2)+molar_mass(1));
CO2_mol = oxides(9)/(molar_mass(11)+2*molar_mass(1));

% STEP 2 - CALCULATE SPECIES MOLAR WEIGHT
SiO2_molwt = molar_mass(5)+2*molar_mass(1);
Al2O3_molwt = 2*molar_mass(4)+3*molar_mass(1);
Fe2O3_molwt = 2*molar_mass(6)+3*molar_mass(1);
CaO_molwt = molar_mass(2)+molar_mass(1);
CO2_molwt = molar_mass(11)+2*molar_mass(1);

% STEP 3 - CALCULATE C3A & C4AF PHASE PROPORTIONS
C3A_prop = (Al2O3_mol-Fe2O3_mol)*(Al2O3_molwt+3*CaO_molwt);
C4AF_prop = Fe2O3_mol*(Fe2O3_molwt+Al2O3_molwt+4*CaO_molwt);

% STEP 4 - CALCULATE PHASE mol/100g
C3A_mol = C3A_prop/(3*CaO_molwt+Al2O3_molwt);
C4AF_mol = C4AF_prop/(4*CaO_molwt+Fe2O3_molwt+Al2O3_molwt);
CaO_molb = oxides(8)/CaO_molwt;
CaCO3_g = CO2_mol*(CO2_molwt+CaO_molwt);
CaCO3_mol = CaCO3_g/(CO2_molwt+CaO_molwt);

% STEP 5 - CALCULATE C3S & C2S PHASE PROPORTIONS
C3S_prop = ((CaO_mola-3*C3A_mol-4*C4AF_mol-CaO_molb-CaCO3_mol)-2*SiO2_mol)*(3*CaO_molwt+SiO2_molwt);
C2S_prop = (-1*(CaO_mola-3*C3A_mol-4*C4AF_mol-CaO_molb-CaCO3_mol)+3*SiO2_mol)*(2*CaO_molwt+SiO2_molwt);

% UNHYDRATED CEMENT PHASES IN DECIMAL FORM
C3S_unhydrated = C3S_prop / 100;
C2S_unhydrated = C2S_prop / 100;
C3A_unhydrated = C3A_prop / 100;
C4AF_unhydrated = C4AF_prop / 100;

unhydrated = [C3S_unhydrated,C2S_unhydrated,C3A_unhydrated,C4AF_unhydrated];

end
