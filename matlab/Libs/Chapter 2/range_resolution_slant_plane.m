function [range_resolution] = range_resolution_slant_plane(waveform_bandwidth)
%RANGE_RESOLUTION_SLANT_PLANE: calculates the range resolution in the slant
%plane for stripmap SAR imaging
%
% Inputs:
% waveform_bandwidth: bandwidth of the waveform (Hz)
%
% Outputs:
% Range resolution in the slant plane (m)
%
%   This function implements Equation (2.2)
%
%   Created by: Andy Harrison (2/12/2021)
%
%   Copyright (C) 2022 Artech House (artech@artechhouse.com)
%   This file is part of Introduction to Synthetic Aperture Radar Using Python and MATLAB
%   and can not be copied and/or distributed without the express permission of Artech House.

% Calculate the range resolution (m)
range_resolution = 299792458 ./ (2 * waveform_bandwidth);

end
