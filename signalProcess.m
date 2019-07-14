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

    %rewrites the audio to a new file
    audiowrite(strcat('new_file.wav', file_audio), sampleData, Fs);

    
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
    
    %find the FT of the signal
    ftSignal = fft(sampleData);
    f = linspace(0, Fs, sampleNum);
    plotSignal(f, abs(ftSignal), 'T Audio Signal FT', 'frequency (Hz)')
     
    %plots the audio data as a function of the sample number
    x = linspace(0, sampleNum/Fs, sampleNum);
    plotSignal(x, sampleData, 'Audio Signal Original', 'time (s)')
    
end



