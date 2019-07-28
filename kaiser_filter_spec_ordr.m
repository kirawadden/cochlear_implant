function Hd = kaiser_filter_spec_ordr(fc1, fc2)
%KAISER_50 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.6 and Signal Processing Toolbox 8.2.
% Generated on: 28-Jul-2019 11:27:40

% FIR Window Bandpass filter designed using the FIR1 function.

% All frequency values are in Hz.
Fs = 16000;  % Sampling Frequency

N    = 50;       % Order
Fc1  = fc1;      % First Cutoff Frequency
Fc2  = fc2;      % Second Cutoff Frequency
flag = 'scale';  % Sampling Flag
Beta = 0.5;      % Window Parameter
% Create the window vector for the design algorithm.
win = kaiser(N+1, Beta);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, [Fc1 Fc2]/(Fs/2), 'bandpass', win, flag);
Hd = dfilt.dffir(b);

% [EOF]
