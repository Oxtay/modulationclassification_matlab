close all;
clear all;
counter = 0;
iterate = 50;
step    = 20;
n_limit = 5000;                % Number of samples
n_loop  = n_limit/step;
sum_error = zeros(1,n_loop);
Cluster_error = zeros(1,n_loop);
%% 16-PSK
constel = 4;
K       = 2^constel;
for i = 1:K
    C(i)=exp(2*1i*pi*(i-1)/K);
end;
C2 = [real(C);imag(C)]';
constel_pow = sum(sum(C2.^2,2).^0.5);
%%
SNR=20;               % The amount of noise after passing from an AWGN channel(Not exactly sure how to measure it with dB scale
for i=1:iterate
for n_l=1:n_loop
    n = (n_l)*step;
    [IDX1, C1] = FindCCenterPSK(SNR,n,K);
    index = knnsearch(C1,C2);
    for row = 1:length(C1)
    C_diff(row,:) = C1(index(row),:)-C2(row,:);
    end
    Cluster_error(n_l) = sum(sum(C_diff.^2,2).^0.5);
% Cluster_error = sum(sum(C_diff));
end;

sum_error(i,:) = Cluster_error;
counter = counter+1
end;
%% Plotting
ave_error = mean(sum_error)/constel_pow;
n = step:step:n_limit;
figure('Units','characters','Position',[30 5 130 40]);
loglog(n, ave_error), grid on, axis([10 n_limit min(ave_error) max(ave_error)]), axis('square')
title('Average error power in finding cluster centers in a 16-PSK signal with SNR=20 dB') 
xlabel('Number of samples'), ylabel('Relative error')