% Written by: Okhtay Azarmanesh
% This test examines the error rate for k-means algorithm when we
% initialize it with k-center versus when the k observations are chosen
% randomly. 
% The error rate versus sample size is then ploted. 

close all;
clear all;
n_limit = 10000;                 % Number of samples
n_loop  = n_limit/50;
iterate = 10;
counter = 0;
SNR     = 10;               % in dB. The amount of noise after passing from an AWGN channel
K       = 16;
C       = [-3 -3;-3 -1;3 1;1 -1;1 1;-3 1;3 -1;-1 -1;-1 1; ...
     -1 -3;1 -3;3 -3;-3 3;-1 3;1 3;3 3]; % The default combination of constellation 16-QAM
% C       = [-3 -1;3 1;1 -1;1 1;-3 1;3 -1;-1 -1;-1 1]; % The default combination of constellation 8-QAM

sum_er1         = zeros(1,n_loop);
sum_er2         = zeros(1,n_loop);
Clust_er1       = zeros(1,n_loop);
Clust_er2       = zeros(1,n_loop);
constel_pow     = sum(sum(C.^2,2).^0.5);

h = modem.qammod('M',K,'PhaseOffset',0,'SymbolOrder','binary');    % Create a modulator object

%% Using K-center for initializing

for i=1:iterate
    for n_l=1:n_loop
        n = n_l*50;
        x = randi(K,n,1)-1;                   % Create a signal source for 16QAM.
        y = modulate(h,x);                    % Modulate the signal x.
        y_chann = awgn(y,SNR);                % Output of AWGN channel
        Data = [real(y_chann), imag(y_chann)];
        [cluster,u] = KCenterClustering(Data,K);
        [~, C1] = kmeans(Data, K, 'Start', u);
        index = knnsearch(C1,C); % Finds the nearest neighbor in C1 for each point in C
        for row = 1:length(C1)
            C1_diff(row,:) = C1(index(row),:)-C(row,:);
        end
        Clust_er1(n_l) = sum(sum(C1_diff.^2,2).^0.5);
    end;
    sum_er1(i,:) = Clust_er1;
    counter = counter+1
end;

%% Using k observations at random for initialization
for i=1:iterate
    for n_l=1:n_loop
        n = n_l*50;
        x = randi(K,n,1)-1;         % Create a signal source for PSK.
        y = modulate(h,x);          % Modulate the signal x.
        y_chann = awgn(y,SNR);      % Output of AWGN channel
        Data = [real(y_chann), imag(y_chann)];
        [~, C2] = kmeans(Data, K, 'emptyaction','drop','start', 'sample');
        index = knnsearch(C2,C); % Finds the nearest neighbor in C1 for each point in C
        for row = 1:length(C2)
            C2_diff(row,:) = C2(index(row),:)-C(row,:);
        end
        Clust_er2(n_l) = sum(sum(C2_diff.^2,2).^0.5);
    end;
    sum_er2(i,:) = Clust_er2;
    counter = counter+1
end

%% Plotting
ave_error1 = mean(sum_er1)/constel_pow;
ave_error2 = mean(sum_er2)/constel_pow;
n = 50:50:n_limit;
figure('Units','characters','Position',[20 5 90 30]);
loglog(n, ave_error1,'r', n, ave_error2,'-'), grid on, hold on
axis square
axis tight
% axis([10 n_limit min(ave_error1) max(ave_error1)]), axis('square')
% title({'Average error power in finding cluster centers';'in a 16-QAM signal with SNR=30dB'}) 
legend('k-center','Uniform')
xlabel('Number of samples'), ylabel('\epsilon_{CDE}')
