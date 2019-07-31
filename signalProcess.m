function signalProcess(file_audio)
    tic;
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
    
   % Sets the passband frequency for the channels
   channel = [[100, 120]; [120,200];[200,240];[240,500];[500,1000]; ...
             [1000,2000];[2000,2700];[2700,3400];[3400,5000];[5000,6000];[6000,7900]];
%    7 Channels
%    channel = [[100, 200];[200,500];[500,800]; ...
%              [800,2000];[2000,2700];[2700,5000];[5000 ,7900]];
%    15 Channels
%    channel = [[100, 120]; [120,200];[200,240];[240,300];[300,400];[400,500];[500,800]; [800, 1200]; ...
%              [1200, 1800];[1800,2600];[2600,3400];[3400,4400];[4400,5000];[5000,6000];[6000,7900]];
%    Overlapping sub bands (11 Channels)
%     channel = [[100, 140]; [120,220];[180,280];[240,540];[450,1000]; ...
%              [900,2100];[2000,2900];[2700,3600];[3400,5000];[4800,6000];[5700,7900]];
         
   
   % Creates empty arrays to hold the filtered and rectified signals
   filteredSamples  = zeros(length(sampleData),length(channel));
   
   % Plot the audio sample
   t = linspace(0, sampleNum/Fs, sampleNum);
   plotAudioData(t, sampleData, ['Unfiltered Audio Sample ' string(file_audio)], 'time (s)'); %plots audio data as a function of time
   
   % Filter the signal through all channels
   filteredSamples = KaiserFilterSignals(filteredSamples, sampleData, t, channel); % plots all filtered signals on one plot with many subplots
   
   % Plot the Fourier Transform of the filtered signals per channel
   plotFourierTransforms(Fs, filteredSamples); % fourier transforms and plots all on one graph
   
   % Envelop the signals
   rectifiedSamples = abs(filteredSamples); % Rectify the filtered signals
   envelopedSignals = plotLpfSignal(t, rectifiedSamples); %plots the lpf of the rectified signal
   
   % signalAM = zeros(length(sampleData),1);

   signalFinal = zeros(length(sampleData), 1);  % Stores the final output signal
   
   figure
   for i = 1:length(channel)
    % generates a signal using the cosine function that oscillates at 1kHz
    f = sqrt(channel(i,1)*channel(i,2));
    signal = cos(2*pi*f*t);
    signalAM = signal(1:length(sampleData)).*envelopedSignals((1:length(sampleData)),i)'; % Store the AM signal
    
    signalFinal = signalFinal + signalAM(1, 1:length(sampleData))';
    
    % plots two cycles of the waveform as a function of time
    subplot(length(channel),1,i);
    figure
    plot(t, signalFinal);
    xlabel('Time');
    ylabel('Audio Signal');
   end
   
   sound(signalFinal, Fs);
%    Write filter audio sample to new file
%    audiowrite('channel_test/connor_harvard_1.3_overlap.wav', signalFinal, Fs);

   timerVal = toc
end


