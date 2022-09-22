function [support_band] = stripmap_support_band(image_span, slant_range, frequency, antenna_width)
%STRIPMAP_SUPPORT_BAND: calculates the support band for stripmap SAR
%imaging
% Inputs:
% image_span: along-track image span (m)
% slant_range: nominal slant-range to the swath center (m)
% frequency: radar operating frequency (Hz)
% antenna_width: width of the antenna in the along-track direction (m)
%
% Outputs:
% Stripmap SAR support band (m)
%
%   This function implements Equation (2.5)
%
%   Created by: Andy Harrison (2/12/2021)
%
%   Copyright (C) 2022 Artech House (artech@artechhouse.com)
%   This file is part of Introduction to Synthetic Aperture Radar Using Python and MATLAB
%   and can not be copied and/or distributed without the express permission of Artech House.

% Calculate the wavelength (m)
wavelength = 299792458 / frequency;

% Calculate the support band (m)
support_band = [-0.5 * image_span - slant_range * wavelength / (2 * antenna_width), ...
    0.5 * image_span + slant_range * wavelength / (2 * antenna_width)];
end

