% ======================================================================= %
% This program was built by Sirapop Saengthongkam to calculate and plot
% the Image Rejection Ratio (IMRR) which is the ratio of the
% intermediate-frequency (IF) signal level produced by the desired input
% frequency to that produced by the image frequency.
%
% Image rejection formulas:
% Image Frequency Rejection Ratio: IRR expressed in dB
% IRR = sqrt(1 + (p^2)(Q^2)), where
% p = (f_Image / f_RF) - (f_RF / f_Image);
% Q is the quility facter, in this situation, give Q = 1;
% The Image Rejection Ratio for a given value of gain imbalance 'G',
% and phase imbalance 'theta' is determined by,
% IMRR = 10log((1+2*G*cos(theta)+G^2) / (1-2*G*cos(theta)+G^2));
% ======================================================================= %
clear; clc; close all;

% Parameters
index = 1;      % An iteration index 
index_irr = 1;  % An iteration index
err = 0.001;    % An error margin parameter

% Evaluate Gain and Phase imbalance from iteration algorithm below.
for IMRR = 40:-5:20
    for G = 0:0.001:2
        for theta = 0:0.001:12
            % Image-Rejection Ratio equation:
            check = 10*log10((1+10^(G/20)*2*cos(theta*pi/180)+(10^(G/20))^2) ...
                / (1-(10^(G/20))*2*cos(theta*pi/180)+(10^(G/20))^2));

            % If IRR is in the range of error margin then save the Gain and
            % Phase imbalance value and increment an iteration index.
            if ((check < IMRR+err)&&(check > IMRR-err))
                Gain_imb(index, index_irr) = G;
                Phase_imb(index, index_irr) = theta;
                index = index + 1;
            end
        end
    end
    % Plot every point into the Graph
    plot(Gain_imb(:,index_irr), Phase_imb(:,index_irr))
    hold on;
    
    % Update and increment the iteration index
    index = 1;
    index_irr = index_irr + 1;
end

% Adding title, labels, and legends. into the Graph
title('Image-Rejection Ratio')
xlabel('Amplitude Error [dB]')
ylabel('Phase Error [degree]')
legend("40 dB", "35 dB", "30 dB", "25 dB", "20 dB")
