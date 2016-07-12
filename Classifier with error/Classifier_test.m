clear all;
RUN = 10000;
ratio = RUN/100;
Class_16QAM = zeros(1,5);
SNR = 2;
for run = 1:RUN
    [outcome,error] = Classify_16QAM(SNR);
    Class_16QAM = Class_16QAM+outcome;
    progress_percent = int16(run/ratio);
    progress(progress_percent)
end;
Class_16QAM/ratio
