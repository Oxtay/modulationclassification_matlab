close all;
clear all;
counter = 0;
iterate = 50;
n_limit = 10000;                % Number of samples
n_loop = n_limit/100;
constel = 6;
K = 2^constel;
sum_error = zeros(1,n_loop);
Cluster_error = zeros(1,n_loop);
%% *******************************
C = zeros(sqrt(K),sqrt(K));
for i = 1:sqrt(K)
    for j = 1:sqrt(K)
        C(i,j) = (2*(i-sqrt(K)/2)-1)+1i*(2*(j-sqrt(K)/2)-1);
    end
end
D = [real(C) imag(C)];
C2 = reshape(D,K,2);

% C2   = [-3 -3;-3 -1;3 1;1 -1;1 1;-3 1;3 -1;-1 -1;-1 1; ...
%      -1 -3;1 -3;3 -3;-3 3;-1 3;1 3;3 3]; % The default combination of constellation 16-QAM
% C2 = [-3 -1;3 1;1 -1;1 1;-3 1;3 -1;-1 -1;-1 1]; % The default combination of constellation 8-QAM
% C2 = [1 1; -1 1; 1 -1; -1 -1]; % The default combination of constellation 4-QAM
%% *******************************
constel_pow = sum(sum(C2.^2,2).^0.5);
SNR=20;               % The amount of noise after passing from an AWGN channel(Not exactly sure how to measure it with dB scale
for i=1:iterate
for n_l=1:n_loop
    n = (n_l)*100;
    [IDX1, C1] = FindCCenter(SNR,n,K);
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
n = 100:100:n_limit;
figure('Units','characters','Position',[20 5 120 40]);
loglog(n, ave_error), grid on, axis([10 n_limit min(ave_error) max(ave_error)]), axis('square')
axis tight
title(['Average error power in finding cluster centers in a ',num2str(K),'-QAM signal']) 
xlabel('Number of samples'), ylabel('Relative error')