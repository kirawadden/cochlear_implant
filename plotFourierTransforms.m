function plotFourierTransforms(Fs, filteredSignals)
% Fourier transforms each and plots all on one graph

    signalSize = size(filteredSignals);
    numSignals = signalSize(2); % Gets the number of signals passed through
    sampleSize = signalSize(1); % Gets the sample size of each signal

    figure
    for i = 1:numSignals
        ftSignal = fft(filteredSignals(1:sampleSize, i));
        L = length(filteredSignals(1:sampleSize, i));
        P2 = abs(ftSignal/L);
        P1 = P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);
        f = Fs*(0:(L/2))/L;
        subplot(numSignals, 1, i);
        plot(f,P1) 
        title(['FT Channel ',num2str(i)]);
        xlabel('f (Hz)')
        ylabel('|P1(f)|')
    end
end