function Hd = cheby1_filter_spec_ordr(n, fc1, fc2)
% INPUTS
% n - order
% fc1 - cutoff frequency 1
% fc2 - cutoff frequency 2
%CHEBY1_FILTER_SPEC_ORDR Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.6 and Signal Processing Toolbox 8.2.
% Generated on: 28-Jul-2019 13:46:23

% Chebyshev Type I Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 16000;  % Sampling Frequency

N      = n;   % Order
Fpass1 = fc1;  % First Passband Frequency
Fpass2 = fc2;  % Second Passband Frequency
Apass  = 1;    % Passband Ripple (dB)

% Construct an FDESIGN object and call its CHEBY1 method.
h  = fdesign.bandpass('N,Fp1,Fp2,Ap', N, Fpass1, Fpass2, Apass, Fs);
Hd = design(h, 'cheby1');

% [EOF]