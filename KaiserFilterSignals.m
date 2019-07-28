function filteredSignals = KaiserFilterSignals(filteredSignals, signal, t, channel)
    % Plots all filtered signals on one plot with many subplots and
    % returns an array holding each filtered signal per channel in each 
    % column
    % 
    % Inputs:
    %   filteredSignals     - An N X M empty array holding. M columns
    %                         represents the number of signals to be stored and N rows of smplae
    %                         data
    %   signal              - A N x 1 array of signal data
    %   t                   - An array holding discrete sampling times
    %   channel             - Number of channels of the cochlear implant
    
    figure
    for i = 1:length(channel)
        hd = kaiser_filter_spec_ordr(channel(i,1),channel(i,2));
        filteredSignals(1:length(signal), i) = filter(hd, signal);
        subplot(length(channel),1,i);
        plot(t,filteredSignals(1:length(signal), i));
        title(['Channel ',num2str(i)]);
        ylabel('Magnitude')
        xlabel('Time (s)')
    end
    
end