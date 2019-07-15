function signalProcess(file_audio)
    %reads the data back into MATLAB using audioread
    [sampleData, Fs] = audioread(file_audio);

    %sampleNum is number of audio samples, channelNum is number of channels
    [sampleNum, channelNum] = size(sampleData);

    %converts a stereo channel to a single channel (mono channel)
    if channelNum == 2
        sampleData = sum(sampleData, 2);
    end

    %plays the audio
    %sound(sampleData, Fs);
    
    %if input signal is not 16kHz, downsample it to 16 kHz
    %if sampling rate is less then 16 kHz, select a different audio file
    if Fs ~= 16e3
        if Fs > 16e3
            [P,Q] = rat(16e3/Fs);
            sampleData = resample(sampleData, P, Q);
            Fs = 16e3;
            sampleNum = length(sampleData);
        elseif Fs < 16e3
            error('frequency is less than 16 kHz, please select a new audio file.');
        end
    end
    
    %plots the audio data as a function of the time
    x = linspace(0, sampleNum/Fs, sampleNum);
    plotSignal(x, sampleData, 'Audio Signal Original', 'time (s)')

    t = (0:length(sampleData)-1)/Fs;
    channel = [[100, 120]; [120,200];[200,240];[240,500];[500,1000];[1000,2000];[2000,2700];[2700,3400];[3400,5000];[5000,6000];[6000,7900]];
    
    for i = 1:length(channel)
        hd = kaiser_filter(channel(i,1),channel(i,2));
        filtered_sample = filter(hd, sampleData);
        figure
        plot(t,filtered_sample);
        title(['Channel ',num2str(i)]);
        ylabel('Magnitude')
        xlabel('Time (s)')
        ylim([-0.8 0.8]);
    end
    
    figure(); hold on
    plot(t,sampleData);
    for i = 1:11
        hd = kaiser_filter(channel(i,1),channel(i,2));
        filtered_sample = filter(hd, sampleData);
        plot(t,filtered_sample);
        title('Channels + Sample Data');
        ylabel('Magnitude')
        xlabel('Time (s)')
    end
    hold off

end



