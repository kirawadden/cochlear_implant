function plotLpfSignal(t, signals)
% Passes the signal through a Low Pass Chebychev IIR Type 1 filter
% with a cut off frequency of 400 Hz and stop band attenuation 80 dB
%
%   t       - An array holding discrete time samplings
%   signals - A N x M array holding the filtered signals in each column
    
    
    signalSize = size(signals);
    numSignals = signalSize(2); % Gets the number of signals passed through
    sampleSize = signalSize(1); % Gets the sample size of each signal
    
    figure
    for i = 1:numSignals
        Hd = envelop_filter;
        lpfSample = filter(Hd,signals(1:sampleSize,i));
        subplot(numSignals,1,i);
        plot(t,lpfSample);
        title(['Rectified Signal for Channel ',num2str(i)]);
        ylabel('Magnitude')
        xlabel('Time (s)')
        
    end
end
