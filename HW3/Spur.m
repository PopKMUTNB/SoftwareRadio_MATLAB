% ======================================================================= %
% This program was built by Sirapop Saengthongkam to study 
% 1. Behavior of Spur
% 2. Spur locations for quadrature DDS (Complex in-input to Discrete 
% Fourier Transform (DFT)) [Bin]
% 3. Power Spectrum of Carrier-to-Spur Relative Power [dBc]. 
% ======================================================================= %
clear, clc, close all;

% ======================== Initial Conditions =========================== %
j = 12;
k = 8;
dP = 1121;
Pe = 4096;
N = 2^k;
M = (2^(j-k))/gcd(dP, 2^(j-k));
Y = M-1;
% ======================================================================= %

% ===================== Position of Spurs in bin ======================== %
fprintf("Number of Spurs are %d\n", Y);
r = [0:1:Y];
Fr = mod((dP/gcd(dP, 2^j)) + r*(N*dP/gcd(dP, 2^j)), Pe);

% Fourier Series De-Aliasing of spurs position
for n = 1:M
    if (Fr(n) > (Pe/2))
        Fr_new = Pe - Fr(n);
        Fr(n) = Fr_new;
    else 
        Fr(n) = Fr(n);
    end
end

% Show the Fourier bin position of Carrier and Spurs
fprintf("Carrier bin[Fr(0)] = %d \n", Fr(1));
for i = 2:M
    fprintf("Spur#%d bin[Fr(%d)] = %d \n", i-1, i-1, Fr(i));
end
% ======================================================================= %

% ======================= Magnitude of Spurs ============================ %
SP = [1:M];
SP(1) = (sin(pi/N)^2)*((pi/(M*N))^2)/(((pi/N)^2)*(sin(pi/(M*N))^2));
for r = 1:Y
    SP(r+1) = 10*log10((sinc(1/N)^2 * sinc(N*r/(N*M) + 1/(N*M))^2) / ...
        (sinc(1/(N*M))^2 * sinc(r + 1/N)^2));
end
% ======================================================================= %

% ==================== Relative Power to Carrier ======================== %
for r = 1:M    
    Crr2Spr_dB(r) = SP(1) - SP(r);
end
% ======================================================================= %

% ============================ Plotting ================================= %
Plot_data = stem(Fr, Crr2Spr_dB, "filled");
Plot_data.BaseValue = -80;
ylim([-80, 0])
title("POWER SPECTRUM", 'fontsize', 10, 'fontname', 'Times New Roman')
xlabel("FREQUENCY BIN", 'fontsize', 10, 'fontname', 'Times New Roman')
ylabel("RELATIVE POWER (dBc)", 'fontsize', 10, 'fontname', ...
    'Times New Roman')
% ======================================================================= %
