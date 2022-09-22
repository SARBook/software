function [doppler_bandwidth] = stripmap_doppler_bandwidth(velocity, frequency, beamwidth)
%STRIPMAP_DOPPLER_BANDWIDTH: calculates the Doppler bandwidth for stripmap SAR
% Inputs:
% velocity: target velocity (m/s)
% frequency: radar operating frequency (Hz)
% beamwidth: radar antenna beamwidth (deg)
%
% Outputs:
% Doppler bandwidth (Hz)
%
%   This function implements Equation (2.17)
%
%   Created by: Andy Harrison (2/12/2021)
%
%   Copyright (C) 2022 Artech House (artech@artechhouse.com)
%   This file is part of Introduction to Synthetic Aperture Radar Using Python and MATLAB
%   and can not be copied and/or distributed without the express permission of Artech House.

% Calculate the wavelength (m)
speed_of_light = 299792458;
wavelength = speed_of_light / frequency;


% Calculate the Doppler bandwidth
doppler_bandwidth = 4 * velocity / wavelength * sind(0.5 * beamwidth);
end

