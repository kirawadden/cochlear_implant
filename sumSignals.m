function sampleData = sumSignals(file1)
%   Overlays two audio signals together. Used to create speech in noise
%   test signals. 
%     rawSignal = {file1 file2};
%     sampleDatas = zeros(1, length(rawSignal));
%     for i = 1:length(rawSignal)
         %reads the data back into MATLAB using audioread
        [sampleData, Fs] = audioread(file1);
        
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
%     end

end