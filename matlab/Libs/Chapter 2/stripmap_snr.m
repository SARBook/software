function [snr] = stripmap_snr(average_power, effective_aperture, rcs, cross_range_resolution, ...
    operating_frequency, slant_range, velocity, system_temperature, noise_figure, losses)
%STRIPMAP_SNR: Calcultes the signal-to-noise ratio for stripmap SAR imaging
% Inputs:
% average_power: average power transmitted by the radar (W)
% effective_aperture: the antenna effective aperture (m^2)
% rcs: the radar cross section of the target (m^2)
% cross_range_resolution: the cross-range resolution of the SAR system (m)
% operating_frequency: the radar operating frequency (Hz)
% slant_range: slant range to the imaged area (m)
% velocity: the velocity of the SAR platform (m/s)
% system_temperature: the system or reference temperature (K)
% noise_figure: the receiver noise figure
% losses: losses in the SAR system
%
% Outputs:
% Signal-to-noise ratio
%
%   This function implements Equation (2.24)
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
    (8 * pi * wavelength * slant_range^3 * cross_range_resolution * velocity * system_temperature * k * noise_figure * losses);

end

