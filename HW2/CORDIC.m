% ======================================================================= %
% This program was built by Sirapop Saengthongkam to study Cordic 
% algorithm.
% 
% This program can compute CORDIC algorithm with 2 Mode
% Mode = 0: Vectoring Mode --> Input: Xin, Yin, Zin = Angle 
%                              / Output: Xf/K = M, Zf = arctan(Yin/Xin)
% Mode = 1: Rotation  Mode --> Input: Xin = 1/K, Yin = 0, Zin = Angle 
%                              / Output: Xf = cos(Angle), Yf = sin(Angle)
% n is Iteration index if n is increase then the accuracy is increase.
% ======================================================================= %
clear; clc; close all;

% Constant
K     = 1.6468;             % K = sqrt(1+(2^-2n))

% Initial Conditions
Mode  = 1;                  % 0 is Vectoring Mode, 1 is Rotation Mode.
Xin   = 1/K;                % Initial Coordinate-x
Yin   = 0;                  % Initial Coordinate-y
Zin   = 60;                 % Initial Angle
n     = 10;                 % Iteration index

% Pre-Calculation
Theta = Zin * pi/180;
X     = zeros(n,1);
X(1)  = Xin;
Y     = zeros(n,1);
Y(1)  = Yin;
Z     = zeros(n,1);
Z(1)  = Theta;
sigma = zeros(n,1);
if (Mode)
    if (Z(1) < 0)
        sigma(1) = -1;
    else
        sigma(1) = 1;
    end
else
    if (Y(1) < 0)
        sigma(1) = 1;
    else
        sigma(1) = -1;
    end
end

% CORDIC - Iteration
for j = 1:n
    [signX, X(j+1)] = ADD_SUB(X(j), SHIFTER(Y(j), j-1), sigma(j), 0);
    [signY, Y(j+1)] = ADD_SUB(Y(j), SHIFTER(X(j), j-1), sigma(j), 1);
    [signZ, Z(j+1)] = ADD_SUB(Z(j), arctanLUT(j-1),     sigma(j), 0);
    sigma(j+1) = MUX2to1(signY, signZ, Mode);
end

% Display Values
j = (0:1:n)';
if (Mode)
    T = table(j, Z, sigma, X, Y)
    if ((Xin == 1/K)&&(Yin == 0))
        fprintf("======================================================\n")
        fprintf("\t\t\tXf = cos(%.1f°) = %.4f\n\t\t\t" + ...
            "Yf = sin(%.1f°) = %.4f\n", Zin, X(n+1), Zin, Y(n+1))
        fprintf("======================================================\n")
    end
else
    T = table(j, Y, sigma, X, Z)
    if (Zin == 0)
        fprintf("======================================================\n")
        fprintf("\tXf = Modulus = %.4f\n\t" + ...
            "Zf = arctan(%.4f/%.4f) = %.4f = %.1f°\n", X(n+1)/K, Yin, ...
            Xin, Z(n+1), Z(n+1)*180/pi)
        fprintf("======================================================\n")
    end
end