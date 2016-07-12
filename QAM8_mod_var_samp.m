close all;
clear all;
counter = 0;
iterate = 100;
n_limit = 200;                % Number of samples
n_loop = n_limit/20;
constel = 3;
K = 2^constel;
sum_error = zeros(1,n_loop);
C2 = [-3 -1;3 1;1 -1;1 1;-3 1;3 -1;-1 -1;-1 1]; % The default combination of constellation 8-QAM
SNR=3;               % dB - The amount of noise after passing from an AWGN channel
SNR_ratio = 10^(SNR/20);
% Cluster_error = zeros(1,12);
for i=1:iterate
for n_l=1:n_loop
    n = n_l*20;
% clear C1 y_chann y x K h noise IDX1 u cluster g Data
    
    x = randintvec(n,K);   % Create a signal source for 16QAM.
    h = modem.qammod('M',K,'PhaseOffset',0,'SymbolOrder','binary');    % Create a modulator object
                       % and display its properties.
    y = modulate(h,x);     % Modulate the signal x.
    noise = SNR_ratio*randn(n,1)+sqrt(-1)*SNR_ratio*randn(n,1);
    y_chann = y+noise;     % Output of AWGN channel
    g = modem.qamdemod(h); % Create a demodulator object from a modem.qammod object and display its properties.
    z = demodulate(g,y_chann);   % Demodulate the signal y_chann. 

% The k-mean command should be performed on y_chann

    Data = [real(y_chann), imag(y_chann)];
    [cluster,u] = KCenterClustering(Data,K);
    [IDX1, C1] = kmeans(Data, K, 'Start', u);
    C_diff = C1-C2;
    Cluster_error(n_l) = sum(sum(C_diff));
Cluster_error = sum(sum(C_diff));
end;

sum_error(i,:) = Cluster_error;
counter = counter+1
end;

abs_error = abs(sum_error);
ult_error = sum(abs_error)/(iterate*SNR_ratio);
n = 20:20:n_limit;
plot(n, ult_error)