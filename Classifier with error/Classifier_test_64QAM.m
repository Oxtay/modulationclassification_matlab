clear all
clc
RUN = 10000;
ratio = RUN/100;
Class_64QAM = zeros(1,6);
SNR = 2;
for run = 1:RUN
    outcome = Classify_64QAM(SNR);
    Class_64QAM = Class_64QAM+outcome;
    progress_percent = int16(run/ratio);
    progress(progress_percent)
end;
Class_64QAM/ratio
