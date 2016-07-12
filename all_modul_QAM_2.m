close all;
clear all;
n=256;                % Number of samples
SNR=7;               % The amount of noise after passing from an AWGN channel
                       %(Not exactly sure how to measure it with dB scale
%% Using K-center for initializing
for con=1:2
    constel = 2*con;
    K=2^constel;
    x = randintvec(n,K);   % Create a signal source for PSK.
    h = modem.qammod('M',K,'PhaseOffset',0,'SymbolOrder','binary');    % Create a modulator object
    y = modulate(h,x);     % Modulate the signal x.
    y_chann = awgn(y,SNR); % Output of AWGN channel
    subplot(2,2,con);plot(real(y_chann), imag(y_chann),'.','MarkerSize',5)  % I-Q diagram of output
    subplot(2,2,con+2); plot(real(y_chann), imag(y_chann),'.','MarkerSize',5)  % I-Q diagram of output
    
    Data = [real(y_chann), imag(y_chann)];
    [cluster,u]=KCenterClustering(Data,K);
    [~, C1] = kmeans(Data, K, 'Start', u, 'emptyaction','drop');
    [~, C2] = kmeans(Data, K, 'Start', 'uniform', 'emptyaction','drop');

    subplot(2,2,con);hold on, plot(C1(:,1),C1(:,2),'ro','MarkerEdgeColor','r',...
                                   'MarkerFaceColor','r',...
                                   'MarkerSize',5);
    title(['(',con+96,')',' ',num2str(K),'-QAM with k-center initialization']);xlabel('I');ylabel('Q');
    grid; axis('square'); axis([-constel constel -constel constel])

    % Using k observations at random
   

    subplot(2,2,con+2); hold on, plot(C2(:,1),C2(:,2),'ro','MarkerEdgeColor','r',...
                                   'MarkerFaceColor','r',...
                                   'MarkerSize',5);
    title(['(',con+98,')',' ',num2str(K),'-QAM without k-center initialization']);xlabel('I');ylabel('Q');
    grid; axis('square'); axis([-constel constel -constel constel])
end;
