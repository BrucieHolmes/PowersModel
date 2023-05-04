%% ***************************** POWERS MODEl *****************************
clc; close all; clear all; %#ok<*CLALL>
%% *************************** INPUT DATA FILES ***************************
molar_mass = xlsread('input.xlsx', 'molar_mass');
oxides = xlsread('input.xlsx', 'binder');
parrot_killoh_constants = xlsread('input.xlsx', 'parrot_killoh');
comp_strength = xlsread('input.xlsx', 'comp_strength');
% w/c ratio & curing temperature
wc_ratio = 0.5;
Temperature = 20;
tic
%% ******* MODIFIED BOGUE CALCULATION OF CEMENT PHASES PROPORTIONS ********
[unhydrated] = modified_bogue(oxides,molar_mass);
%% ************ VOLUME & WEIGHT CALCULATIONS OF CEMENT PHASES *************
[volumes] = volume_calculations(wc_ratio);
%% ************************** ANALYSIS DURATION ***************************
% CALCULATIONS AT 1HR INTERVALS
T = 1:1:1344; % 56 days
Time_hrs = T';
Time = size(Time_hrs,1);
%% *********************** DISSOLUTION CALCULATIONS ***********************
[alpha] = phase_dissolution(Temperature,parrot_killoh_constants,unhydrated,wc_ratio,Time_hrs);
%% *********** COMPRESSIVE STRENGTH OF ASTM C109 MORTAR CUBES ***********
[compressive_strength] = mortar_strength(alpha,Time, wc_ratio, comp_strength);
%% ************************ POWERS HYDRATION MODEL ************************
[powers_output] = powers(alpha,wc_ratio,volumes,Time);
toc
%% ******************************* PLOTTING *******************************
% POWERS MODEL
x_powers_plot (Time,Time_hrs,powers_output)
% COMPRESSIVE STRENGTH OF ASTM C109 MORTAR CUBES
x_mortor_strength_plot(Time_hrs,compressive_strength)
% ********************************** END **********************************