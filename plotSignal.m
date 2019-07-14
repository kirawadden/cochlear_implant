function plotSignal(x, y, title_name, x_label)
%plotSignal(x, y, totle_name, x_label) plots the signal with appropriate
%graph axis and titles
%plots the audio data as a function of the sample number
figure
plot(x, y)
title(title_name);
xlabel(x_label);
ylabel('magnitude');

end

