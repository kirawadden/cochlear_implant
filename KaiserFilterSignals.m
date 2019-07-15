function filteredSignals = KaiserFilterSignals(filteredSignals, signal, t, channel)
    % Plots all filtered signals on one plot with many subplots and
    % returns an array holding each filtered signal per channel in each 
    % column
    
    figure
    for i = 1:length(channel)
        hd = kaiser_filter(channel(i,1),channel(i,2));
        filteredSignals(1:length(signal), i) = filter(hd, signal);
        subplot(length(channel),1,i);
        plot(t,filteredSignals(1:length(signal), i));
        title(['Channel ',num2str(i)]);
        ylabel('Magnitude')
        xlabel('Time (s)')
    end
    
end