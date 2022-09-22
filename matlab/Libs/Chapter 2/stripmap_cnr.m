function [cnr] = stripmap_cnr(average_power, effective_aperture, backscatter_coefficient, range_resolution, ...
    operating_frequency, slant_range, velocity, system_temperature, noise_figure, losses)
%STRIPMAP_CNR: Calcultes the clutter-to-noise ratio for stripmap SAR imaging
% Inputs:
% average_power: average power transmitted by the radar (W)
% effective_aperture: the antenna effective aperture (m^2)
% backscatter_coefficient: the backscattering coefficient for distributed clutter
% range_resolution: the range resolution of the SAR system (m)
% operating_frequency: the radar operating frequency (Hz)
% slant_range: slant range to the imaged area (m)
% velocity: the velocity of the SAR platform (m/s)
% system_temperature: the system or reference temperature (K)
% noise_figure: the receiver noise figure (dB)
% losses: losses in the SAR system (dB)
%
% Outputs:
% Clutter-to-noise ratio
%
%   This function implements Equation (2.26)
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
cnr = (average_power * effective_aperture^2 * backscatter_coefficient * range_resolution) ./ ...
    (8 * pi * wavelength * slant_range^3 * velocity * system_temperature * k * lin(noise_figure) * lin(losses));

end

