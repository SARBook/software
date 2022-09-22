"""
Project: SAR Book
File: pga.py
Created by: Lee A. Harrison
On: 2/9/2022
Created with: PyCharm

Copyright (C) 2022 Artech House (artech@artechhouse.com)
This file is part of Introduction to Synthetic Aperture Radar Using Python and MATLAB
and can not be copied and/or distributed without the express permission of Artech House.
"""
import numpy as np
# from scipy.constants import c, pi
# from numpy import sqrt, linspace, zeros_like, exp, sin, cos, ones
# from scipy.interpolate import interp1d
# from scipy.fftpack import ifft, fftshift

from matplotlib import pyplot as plt


def pga(original_image, threshold):
    """
    Peform phsae gradient autofocus.
    :param original_image: The unfocused image.
    :param sensor_x: The threshold for setting the window width (dB).
    :return: The corrected image and the phase error estimate.
    """
    save_image = original_image.copy()

    index_center = int(np.ceil(original_image.shape[1] / 2))


    # Find the index of each max
    maximum_along_az_idx = []
    
    for i in range(original_image.shape[0]):  
        maximum_along_az_idx.append(original_image[i,:].argmax())
        
    
    # Circular shift
    for i in range(original_image.shape[0]):
        original_image[i,:] = np.roll(original_image[i,:], int(index_center - maximum_along_az_idx[i]))

    
    
    # Calculate the window width
    noncoherent_window = np.sum(abs(original_image)**2, 0)
        
    window_cutoff = np.max(20 * np.log10(noncoherent_window)) - abs(threshold)
    
   
    
    # Find the indices for the window
    last_index  = np.argwhere(20 * np.log10(noncoherent_window[0:index_center]) - window_cutoff<0)
    
    last_index = last_index[-1]

    
    first_index = np.argwhere(20 * np.log10(noncoherent_window[index_center+1:-1]) - window_cutoff<0)
    
    first_index = first_index[0]
    
    first_index = first_index + index_center - 1
        
    
    # Get the window filter
    noncoherent_window = np.zeros_like(noncoherent_window)

    noncoherent_window[last_index[0]:first_index[0]] = 1

    
    # Set the FFT size
    nfft = original_image.shape[1]

    # Calculate the image spectrum
    term1 = original_image * np.matlib.repmat(noncoherent_window, original_image.shape[0], 1)
    
    image_spectrum = np.fft.fft(np.fft.ifftshift(term1, 1), nfft, axis=1)
    
    
    # Calculate the delta phase and the error estimate
    delta_phase = np.angle( np.sum( np.conj(image_spectrum[:, 0:-2]) * image_spectrum[:,1:-1], axis=0 ))
    
    phase_error_estimate = np.zeros(nfft)
    
    phase_error_estimate[0:len(delta_phase)] = np.cumsum(delta_phase)  
    

    # Calculate the linear phase term
    linear_coefs = np.polyfit(range(len(phase_error_estimate)), phase_error_estimate, 1)

    # Updated phase error estimate
    phase_error_estimate = np.unwrap(phase_error_estimate - np.polyval(linear_coefs, range(len(phase_error_estimate))))

    # Calculate the image spectrum
    image_spectrum = np.fft.fft(np.fft.ifftshift(save_image, 1), nfft, axis=1)

    # Correct image spectrum with phase estimate
    image_spectrum = image_spectrum * np.matlib.repmat(np.exp(-1j*phase_error_estimate), save_image.shape[0], 1)

    # Finally compute the focused image
    corrected_image = np.fft.fftshift(np.fft.ifft(image_spectrum, axis=1), 1)
        
    return corrected_image, phase_error_estimate