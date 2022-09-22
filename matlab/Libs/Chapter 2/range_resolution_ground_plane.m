function [range_resolution] = range_resolution_ground_plane(waveform_bandwidth, look_angle)
%RANGE_RESOLUTION_GROUND_PLANE: calculates the range resolution in the
%ground plane for stripmap SAR imaging
% Inputs:
% waveform_bandwidth: bandwidth of the waveform (Hz)
% look_angle: look angle measured from the platform, Figure 2.2 (deg)
%
% Outputs:
% Range resolution in the ground plane (m)
%
%   This function implements Equation (2.3)
%
%   Created by: Andy Harrison (2/12/2021)
%
%   Copyright (C) 2022 Artech House (artech@artechhouse.com)
%   This file is part of Introduction to Synthetic Aperture Radar Using Python and MATLAB
%   and can not be copied and/or distributed without the express permission of Artech House.

% Calculate the range resolution (m)
range_resolution = 299792458 ./ (2 * waveform_bandwidth * cosd(90 - look_angle));

end
