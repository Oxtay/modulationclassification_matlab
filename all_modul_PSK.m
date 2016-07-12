close all;
clear all;
n=400;                % Number of samples
SNR=30;               % The amount of noise after passing from an AWGN channel
                       %(Not exactly sure how to measure it with dB scale
for constel=2:5
    K=2^constel;
x = randintvec(n,K);   % Create a signal source for PSK.
h = modem.pskmod('M',K,'PhaseOffset',0,'SymbolOrder','binary');    % Create a modulator object
                       % and display its properties.
y = modulate(h,x);     % Modulate the signal x.
% noise=SNR*randn(n,1)+i*SNR*randn(n,1);
y_chann = awgn(y,SNR);     % Output of AWGN channel
g = modem.pskdemod(h); % Create a demodulator object from a modem.qammod object
                       % and display its properties.
z = demodulate(g,y_chann);   % Demodulate the signal y_chann. 
figure;
plot(real(y_chann), imag(y_chann),'.')  % I-Q diagram of output
% The k-mean command should be performed on y_chann
Data = [real(y_chann), imag(y_chann)];
[cluster,u]=KCenterClustering(Data,K);
[IDX1, C1] = kmeans(Data, K, 'Start', u);

hold on, plot(C1(:,1),C1(:,2),'r+');grid; axis('square');
end;
