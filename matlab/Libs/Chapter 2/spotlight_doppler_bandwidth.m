function [doppler_bandwidth] = spotlight_doppler_bandwidth(velocity, aperture_length, operating_frequency, slant_range)
%SPOTLIGHT_DOPPLER_BANDWIDTH: calculates the Doppler bandwidth for spotlight SAR
% Inputs:
% velocity: target velocity (m/s)
% aperture_length: synthetic aperture length (m)
% operating_frequency: radar operating frequency (Hz)
% slant_range: slant range to the imaging area (m)
%
% Outputs:
% Doppler bandwidth (Hz)
%
%   This function implements Equation (2.39)
%
%   Created by: Andy Harrison (2/20/2021)
%
%   Copyright (C) 2022 Artech House (artech@artechhouse.com)
%   This file is part of Introduction to Synthetic Aperture Radar Using Python and MATLAB
%   and can not be copied and/or distributed without the express permission of Artech House.

% Calculate the wavelength (m)
wavelength = 299792458 / operating_frequency;

% Calculate the Doppler bandwidth
doppler_bandwidth = 2 * velocity * aperture_length / (wavelength * slant_range);
end

