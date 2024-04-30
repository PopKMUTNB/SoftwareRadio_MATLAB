% ======================================================================= %
% This program was built by Sirapop Saengthongkam to study Cordic 
% algorithm.
% 
% This program can compute CORDIC algorithm with 2 Mode
% Mode = 0: Vectoring Mode --> Input: Xin, Yin, Angle / Output: M,
%                              tan(Yin/Xin)
% Mode = 1: Rotation  Mode --> Input: Xin, Yin, Angle / Output: cos(Angle),
%                              sin(Angle)
% n is Iteration index if n is increase then the accuracy is increase.
% ======================================================================= %
clear; clc; close all;

% Initial Conditions
Mode  = 0;                  % 0 is Vectoring Mode, 1 is Rotation Mode.
Xin   = 0.75;               % Initial Coordinate-x
Yin   = 0.43;               % Initial Coordinate-y
Angle = 0;                  % Initial Angle
n     = 12;                 % Iteration index
K     = 1.6468;             % K constant

% Pre-Calculation
Theta = Angle * pi/180;
X     = zeros(n,1);
X(1)  = Xin;
Y     = zeros(n,1);
Y(1)  = Yin;
Z     = zeros(n,1);
Z(1)  = Theta;
sigma = zeros(n,1);
sigma(1) = 1;

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
T = table(j, Z, sigma, X, Y)
