close all;
clear all;
counter = 0;
iterate = 1000;
n_samp  = 512;                % Number of samples
SNR_max = 30;               % The amount of noise after passing from an AWGN channel
%% 16-PSK
constel = 4;
K       = 2^constel;
sum_error1       = zeros(1,SNR_max);
Cluster_error1   = zeros(1,SNR_max);
for i = 1:K
    C(i)=exp(2*1i*pi*(i-1)/K);
end;
C2 = [real(C);imag(C)]';
constel_pow1 = sum(sum(C2.^2,2).^0.5);
for i=1:iterate
    for SNR=1:SNR_max
        [IDX1, C1] = FindCCenterPSK(SNR,n_samp,K);
        index = knnsearch(C1,C2);
        for row = 1:length(C1)
            C_diff(row,:) = C1(index(row),:)-C2(row,:);
        end
        Cluster_error1(SNR) = sum(sum(C_diff.^2,2).^0.5);
    end;
sum_error1(i,:) = Cluster_error1;
counter = counter+1
end;
%% 8-PSK
constel = 3;
K       = 2^constel;
sum_error2       = zeros(1,SNR_max);
Cluster_error2   = zeros(1,SNR_max);
for i = 1:K
    C(i)=exp(2*1i*pi*(i-1)/K);
end;
C2 = [real(C);imag(C)]';
constel_pow2 = sum(sum(C2.^2,2).^0.5);
for i=1:iterate
    for SNR=1:SNR_max
        [IDX1, C1] = FindCCenterPSK(SNR,n_samp,K);
        index = knnsearch(C1,C2);
        for row = 1:length(C1)
            C_diff(row,:) = C1(index(row),:)-C2(row,:);
        end
        Cluster_error2(SNR) = sum(sum(C_diff.^2,2).^0.5);
    end;
sum_error2(i,:) = Cluster_error2;
counter = counter+1
end;
%% Plotting
ave_error1 = mean(sum_error1)/constel_pow1;
ave_error2 = mean(sum_error2)/constel_pow2;

n = 1:SNR_max;
figure('Units','characters','Position',[20 5 130 50]);
semilogy(n, ave_error2,'r'), grid on, axis([1 SNR_max min(ave_error2) max(ave_error2)]), axis('square')
axis tight
hold on
semilogy(n, ave_error1)
title(['Average error power in finding cluster centers in PSK signals with 512 samples.']) 
legend('16-PSK','8-PSK')
xlabel('SNR (dB)'), ylabel('Error rate')