function [ftSignal] = FT_Signal(signal, Fs, name)
%Fourier Transform the signal and plot the signle sided amplitude of X(t)
    figure
    ftSignal = fft(signal);
    L = length(signal);
    P2 = abs(ftSignal/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
    plot(f,P1) 
    title(name)
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
    
end

