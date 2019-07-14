function signalProcess(file_audio)
%reads the data back into MATLAB using audioread
[sampleData, sampleRate] = audioread(file_audio);

%sampleNum is number of audio samples, channelNum is number of channels
[sampleNum, channelNum] = size(sampleData);

%converts a stereo channel to a single channel (mono channel)
if channelNum == 2
    sampleData = sum(sampleData, 2);
end

%plays the audio
sound(sampleData, sampleRate);

%rewrites the audio to a new file
audiowrite(strcat('new_file.wav', file_audio), sampleData, sampleRate);

%plots the audio data as a function of the sample number
figure
plot(1:sampleNum, sampleData)
xlabel('Number of Signals');
ylabel('Audio Signal');

%if input signal is not 16kHz, downsample it to 16 kHz
%if sampling rate is less then 16 kHz, select a different audio file
if sampleRate ~= 16e3
    if sampleRate > 16e3
        [P,Q] = rat(16e3/sampleRate);
        resample(sampleData, P, Q);
    elseif sampleRate < 16e3
        error('frequency is less than 16 kHz, please select a new audio file.');
    end
end

end

