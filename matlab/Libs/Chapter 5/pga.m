function [corrected_image, phase_error_estimate] = pga(original_image, threshold)
save_image = original_image;

index_center = ceil(size(original_image, 2)/2);

% Circular shift
[~, maximum_along_az_idx] = max(abs(original_image), [], 2);
for i = 1:size(original_image, 1)
    original_image(i,:) = circshift(transpose(original_image(i,:)), index_center - maximum_along_az_idx(i));
end

% Calculate the window width
noncoherent_window = sum(abs(original_image).^2, 1);
window_cutoff = max(20 * log10(noncoherent_window)) - abs(threshold);

% Find  indices for the window
last_index  = find(20 * log10(noncoherent_window(1:index_center    )) - window_cutoff<0, 1, 'last' );
first_index = find(20 * log10(noncoherent_window(index_center+1:end)) - window_cutoff<0, 1, 'first');

last_index = last_index+1;
first_index = first_index + index_center - 1;

noncoherent_window = zeros(size(noncoherent_window));
noncoherent_window(last_index:first_index) = 1;

% Set the FFT size
nfft = size(original_image, 2);

% Calculate the image spectrum
image_spectrum = fft(ifftshift( original_image .* repmat(noncoherent_window, size(original_image,1), 1), 2), nfft, 2);

% Calculate the delta phase and the error estimate
delta_phase = angle( sum(  conj(image_spectrum(:, 1:end-1)) .* image_spectrum(:, 2:end), 1) );
phase_error_estimate = [0 cumsum(delta_phase)];

% Calculate the linear phase term
linear_coefs = polyfit(1:length(phase_error_estimate), phase_error_estimate, 1);

% Updated phase error estimate
phase_error_estimate = unwrap(phase_error_estimate - polyval(linear_coefs, 1:length(phase_error_estimate)));

% Calculate the image spectrum
image_spectrum = fft(ifftshift( save_image, 2), nfft, 2);

% Correct image spectrum with phase estimate
image_spectrum = image_spectrum .* repmat(exp(-1j*phase_error_estimate), size(save_image, 1), 1);

% Finally compute the focused image
corrected_image = fftshift(ifft(image_spectrum, [], 2), 2);

end