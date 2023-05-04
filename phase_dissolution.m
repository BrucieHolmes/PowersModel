function [alpha] = phase_dissolution (Temperature, parrot_killoh_constants, unhydrated, wc_ratio, Time_hrs)

% THIS FUNCTION CALCULATES THE CEMENT PHASE DISSOLUTION OVER TIME
% FUNCTION USES THE METHOD BY PARROTT & KILLOH

% References:
% Parrot L.J., Killoh D.C.; Prediction of cement hydration. Br. Ceram. Proc.
% 1984, 35, p.41-53
% Lothenbach B, Le Saout G, Gallucci E, Scrivener K.; Influence of limestone
% on the hydration of Portland cements. Cement and Concrete Research, 2008, 
% 38, p.848-860

no_time_steps = length(Time_hrs);

Tref = parrot_killoh_constants(9);
T = 273.15 + Temperature;

a0 = parrot_killoh_constants(34);

Ea = parrot_killoh_constants(5);
Kng = parrot_killoh_constants(10);
Nng = parrot_killoh_constants(11);
H = parrot_killoh_constants(12);
Ksf = parrot_killoh_constants(22);
Nsf = parrot_killoh_constants(23);
Kdif = parrot_killoh_constants(30);
C3S =  ParticleProp(Kng, Nng, Kdif, Ksf, Nsf, H, Ea, unhydrated(1), no_time_steps, a0);

Ea = parrot_killoh_constants(6);
Kng = parrot_killoh_constants(13);
Nng = parrot_killoh_constants(14);
H = parrot_killoh_constants(15);
Ksf = parrot_killoh_constants(24);
Nsf = parrot_killoh_constants(25);
Kdif = parrot_killoh_constants(31);
C2S =  ParticleProp(Kng, Nng, Kdif, Ksf, Nsf, H, Ea, unhydrated(2), no_time_steps, a0);

Ea = parrot_killoh_constants(7);
Kng = parrot_killoh_constants(16);
Nng = parrot_killoh_constants(17);
H = parrot_killoh_constants(18);
Ksf = parrot_killoh_constants(26);
Nsf = parrot_killoh_constants(27);
Kdif = parrot_killoh_constants(32);
C3A =  ParticleProp(Kng, Nng, Kdif, Ksf, Nsf, H, Ea, unhydrated(3), no_time_steps, a0);

Ea = parrot_killoh_constants(8);
Kng = parrot_killoh_constants(19);
Nng = parrot_killoh_constants(20);
H = parrot_killoh_constants(21);
Ksf = parrot_killoh_constants(28);
Nsf = parrot_killoh_constants(29);
Kdif = parrot_killoh_constants(33);
C4AF =  ParticleProp(Kng, Nng, Kdif, Ksf, Nsf, H, Ea, unhydrated(4), no_time_steps, a0);

alpha = single(zeros(no_time_steps,1));

alpha(1) = a0;

Asurf = parrot_killoh_constants(1);
Aref = parrot_killoh_constants(2);
As_Af = Asurf / Aref;
RH = 1.0;
RHeffect = ((RH - 0.55) / 0.45)^4;
vol_tot = C3S.volPC + C2S.volPC + C3A.volPC + C4AF.volPC;

for i = 2:no_time_steps
    dt = (Time_hrs(i) - Time_hrs(i - 1)) / 24;
    C3S.next_alpha(i, alpha(i - 1), T, Tref, RHeffect, wc_ratio, As_Af, dt);
    C2S.next_alpha(i, alpha(i - 1), T, Tref, RHeffect, wc_ratio, As_Af, dt);
    C3A.next_alpha(i, alpha(i - 1), T, Tref, RHeffect, wc_ratio, As_Af, dt);
    C4AF.next_alpha(i, alpha(i - 1), T, Tref, RHeffect, wc_ratio, As_Af, dt);
    alpha(i) = (C3S.alpha(i) * C3S.volPC + ...
                C2S.alpha(i) * C2S.volPC + ...
                C3A.alpha(i) * C3A.volPC + ...
                C4AF.alpha(i) * C4AF.volPC ) / vol_tot;
end


end
