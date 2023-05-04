function [compressive_strength] = mortar_strength(alpha, Time, wc_ratio, comp_strength)

% THIS FUNCTION CALCULATES THE COMPRESSIVE STRENGTH OF ASTM C109 MORTAR 
% CUBES AT ANY AGE BY RELATING IT TO THE GEL-SPACE RATIO

% Mindess,S & Young,J.F, Concrete, Prentice-Hall, Englewood Cliffs, NJ, 1981.
% Powers TC (1962) in 4th ISCC, Vol. 2, pp. 577

intrinsic = comp_strength(1);
n = comp_strength(2);

% Gel-space ratio calculation & Mortar compressive strength
gel_space = single(zeros(Time,1));
compressive_strength = single(zeros(Time,1));
for i = 1:Time
    gel_space(i) = (0.68*alpha(i)) / ((0.32*alpha(i)) + wc_ratio);
    compressive_strength(i) = intrinsic*(gel_space(i).^n);
end

end
