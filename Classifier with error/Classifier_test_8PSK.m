clear all
clc
RUN = 1000;
ratio = RUN/100;
Class_8PSK = zeros(1,6);
SNR = 5;
for run = 1:RUN
    outcome = Classify_8PSK(SNR);
    Class_8PSK = Class_8PSK+outcome;
    progress_percent = int16(run/ratio);
    progress(progress_percent)
end;
Class_8PSK/ratio
