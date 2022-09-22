function [snr] = spotlight_snr(average_power, effective_aperture, rcs, operating_frequency, slant_range, ...
    system_temperature, receiver_bandwidth, noise_figure, losses)
%SPOTLIGHT_SNR Calcultes the signal-to-noise ratio for spotlight SAR imaging
% Inputs:
% average_power: average power transmitted by the radar (W)
% effective_aperture: the antenna effective aperture (m^2)
% rcs: the radar cross section of the target (m^2)
% cross_range_resolution: the cross-range resolution of the SAR system (m)
% operating_frequency: the radar operating frequency (Hz)
% slant_range: slant range to the imaged area (m)
% system_temperature: the system or reference temperature (K)
% receiver_bandwidth: the bandwidth of the receiver (Hz)
% noise_figure: the receiver noise figure (dB)
% losses: losses in the SAR system (dB)
%
% Outputs:
% Signal-to-noise ratio
%
%   This function implements Equation (2.42)
%
%   Created by: Andy Harrison (2/20/2021)
%
%   Copyright (C) 2022 Artech House (artech@artechhouse.com)
%   This file is part of Introduction to Synthetic Aperture Radar Using Python and MATLAB
%   and can not be copied and/or distributed without the express permission of Artech House.

% Calculate the wavelength (m)
wavelength = 299792458 / operating_frequency;

% Boltzmann's constant 
k = 1.380649e-23;

% Calculate the clutter-to-noise ratio
snr = (average_power * effective_aperture^2 * rcs) ./ ...
    (4 * pi * wavelength^2 * slant_range.^4 * k * system_temperature * receiver_bandwidth * noise_figure * losses);

end

