close all;
clear all;
n=400;               % Number of samples
SNR=7;               % The amount of noise after passing from an AWGN channel

%% Using K-center for initializing
for con=1:2
    constel = 2*con;
    K=2^constel;
x = randintvec(n,K);   % Create a signal source for PSK.
h = modem.qammod('M',K,'PhaseOffset',0,'SymbolOrder','binary');    % Create a modulator object
                       % and display its properties.
y = modulate(h,x);     % Modulate the signal x.

y_chann = awgn(y,SNR);     % Output of AWGN channel
g = modem.qamdemod(h); % Create a demodulator object from a modem.qammod object
                       % and display its properties.
z = demodulate(g,y_chann);   % Demodulate the signal y_chann. 
% figure(con);
subplot(2,1,con);plot(real(y_chann), imag(y_chann),'.','MarkerSize',5)  % I-Q diagram of output
% The k-mean command should be performed on y_chann
Data = [real(y_chann), imag(y_chann)];
[cluster,u]=KCenterClustering(Data,K);
[IDX1, C1] = kmeans(Data, K, 'Start', u);

subplot(2,1,con);hold on, plot(C1(:,1),C1(:,2),'ro','MarkerEdgeColor','r',...
                                   'MarkerFaceColor','r',...
                                   'MarkerSize',5);
title(['(',con+96,')',' ',num2str(constel),'-QAM with k-center initialization']);xlabel('I');ylabel('Q');
grid; axis('square'); axis([-constel constel -constel constel])
end;
