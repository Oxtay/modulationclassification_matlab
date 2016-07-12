close all;
clear all;
n = 1024;                % Number of samples
SNR = 10;               % after passing from an AWGN channel (in dB)
noise_factor = 10^(-SNR/20);

%%
% ***** For QAM modulations - SCALED to 1 watt ******

figure('Units','characters','Position',[30 5 135 50]);

for constel=1:4
    K = 2^(2*constel);
x = randintvec(n,K);        % Create a signal source for QAM modulations.
h = modem.qammod('M',K,'PhaseOffset',0,'SymbolOrder','binary');    % Create a modulator object
% scale = sqrt(modnorm(x,'avpow',1))
y = modulate(h,x);          % Modulate the signal x.
y_chann = awgn(y ,SNR);     % Output of AWGN channel

% g = modem.qamdemod(h);      % Create a demodulator object
%                             % from a modem.qammod object
%                             % and display its properties.
% z = demodulate(g,y_chann);  % Demodulate the signal y_chann. 

subplot(2,2,constel); plot(real(y_chann), imag(y_chann),'.','MarkerSize',4)  % I-Q diagram of output

Data = [real(y_chann), imag(y_chann)];

[~,u]=KCenterClustering(Data,K);

[~, C1] = kmeans(Data, K, 'Start', u);

% plot(Data(:,1),Data(:,2),'.');
hold on, 
plot(C1(:,1),C1(:,2),'ro','MarkerEdgeColor','r',...
                                   'MarkerFaceColor','r',...
                                   'MarkerSize',4);
% progress;
end;
subplot(2,2,1); title('(i) 4-QAM');xlabel('I');ylabel('Q'); 
grid; axis('square'); axis([-2 2 -2 2])
subplot(2,2,2); title('(ii) 16-QAM');xlabel('I');ylabel('Q'); 
grid; axis('square'); axis([-4 4 -4 4])
subplot(2,2,3); title('(iii) 64-QAM');xlabel('I');ylabel('Q'); 
grid; axis('square'); axis([-10 10 -10 10])
subplot(2,2,4); title('(iv) 256-QAM');xlabel('I');ylabel('Q'); 
grid; axis('square'); axis([-20 20 -20 20])

%%
% ***** For PSK modulations ******

% SNR = 20;   % SNR for PSK modulation(in dB)
% noise_factor = 10^(-SNR/20);

figure('Units','characters','Position',[30 5 135 50]);

for constel=2:5
    K = 2^constel;
x = randintvec(n,K);   % Create a signal source for QAM modulations.
h = modem.pskmod('M',K,'PhaseOffset',0,'SymbolOrder','binary');    % Create a modulator object
                       % and display its properties.
y = modulate(h,x);     % Modulate the signal x.
y_chann = awgn(y ,SNR);       % Output of AWGN channel

subplot(2,2,constel-1); plot(real(y_chann), imag(y_chann),'.','MarkerSize',4)  % I-Q diagram of output

Data = [real(y_chann), imag(y_chann)];

[~,u]=KCenterClustering(Data,K);

[~, C1] = kmeans(Data, K, 'Start', u);

% plot(Data(:,1),Data(:,2),'.');
hold on, 
plot(C1(:,1),C1(:,2),'ro','MarkerEdgeColor','r',...
                                   'MarkerFaceColor','r',...
                                   'MarkerSize',4);
% progress;
end;
subplot(2,2,1); title('(i) QPSK');xlabel('I');ylabel('Q'); 
grid; axis('square'); axis([-2 2 -2 2])
subplot(2,2,2); title('(ii) 8-PSK');xlabel('I');ylabel('Q');
grid; axis('square');axis([-2 2 -2 2])
subplot(2,2,3); title('(iii) 16-PSK');xlabel('I');ylabel('Q');
grid; axis('square');axis([-2 2 -2 2])
subplot(2,2,4); title('(iv) 32-PSK');xlabel('I');ylabel('Q');
grid; axis('square');axis([-2 2 -2 2])

%%
% ***** For PAM modulations ******


figure('Units','characters','Position',[30 5 135 50]);

for constel=1:4
    K = 2^constel;
x = randintvec(n,K);   % Create a signal source for QAM modulations.
h = modem.pammod('M',K,'SymbolOrder','binary');    % Create a modulator object
                       % and display its properties.
y = modulate(h,x);     % Modulate the signal x.

y_chann = awgn(y ,SNR);% Output of an AWGN channel

subplot(2,2,constel); plot(real(y_chann), imag(y_chann),'.','MarkerSize',4)  % I-Q diagram of output

Data = [real(y_chann), imag(y_chann)];

[~,u]=KCenterClustering(Data,K);

[~, C1] = kmeans(Data, K, 'Start', u);

% plot(Data(:,1),Data(:,2),'.');
hold on, 
plot(C1(:,1),C1(:,2),'ro','MarkerEdgeColor','r',...
                                   'MarkerFaceColor','r',...
                                   'MarkerSize',4);
% progress;
end;
subplot(2,2,1); title('(a) 2-PAM');xlabel('I');ylabel('Q');
grid; axis('square');axis([-2 2 -2 2])
subplot(2,2,2); title('(b) 4-PAM');xlabel('I');ylabel('Q');
grid; axis('square');axis([-4 4 -2 2])
subplot(2,2,3); title('(c) 8-PAM');xlabel('I');ylabel('Q');
grid; axis('square');axis([-10 10 -2 2])
subplot(2,2,4); title('(d) 16-PAM');xlabel('I');ylabel('Q');
grid; axis('square');axis([-20 20 -2 2])

%%
% ***** For MSK modulations ******
K = 2;
figure('Units','characters','Position',[30 5 130 50]);

x = randintvec(n,K);   % Create a signal source for QAM modulations.
h = modem.mskmod;    % Create a modulator object
                       % and display its properties.
y = modulate(h,x);     % Modulate the signal x.

y_chann = awgn(y ,SNR);% Output of an AWGN channel

plot(real(y_chann), imag(y_chann),'.','MarkerSize',4)  % I-Q diagram of output

Data = [real(y_chann), imag(y_chann)];

[~,u]=KCenterClustering(Data,K);

[~, C1] = kmeans(Data, K, 'Start', u);
hold on, 
plot(C1(:,1),C1(:,2),'ro','MarkerEdgeColor','r',...
                                   'MarkerFaceColor','r',...
                                   'MarkerSize',4);
title('MSK'); xlabel('I'); ylabel('Q'); %axis([-2 2 -2 2])
grid; axis('square');

%%
% ***** For DPSK modulations ******

figure('Units','characters','Position',[30 5 130 50]);

for constel=1:4
    K = 2^constel;
x = randintvec(n,K);   % Create a signal source for QAM modulations.
h = modem.dpskmod('M',K,'PhaseRotation',0,'SymbolOrder','binary');    % Create a modulator object
                       % and display its properties.
y = modulate(h,x);     % Modulate the signal x.

y_chann = awgn(y ,SNR);       % Output of AWGN channel

subplot(2,2,constel); plot(real(y_chann), imag(y_chann),'.','MarkerSize',4)  % I-Q diagram of output

Data = [real(y_chann), imag(y_chann)];

[~,u]=KCenterClustering(Data,K);

[~, C1] = kmeans(Data, K, 'Start', u);

% plot(Data(:,1),Data(:,2),'.');
hold on, 
plot(C1(:,1),C1(:,2),'ro','MarkerEdgeColor','r',...
                                   'MarkerFaceColor','r',...
                                   'MarkerSize',4);
% progress;
end;
subplot(2,2,1); title('(a) 2-DPSK');xlabel('I');ylabel('Q');
grid; axis('square');axis([-2 2 -2 2])
subplot(2,2,2); title('(b) 4-DPSK');xlabel('I');ylabel('Q');
grid; axis('square');axis([-2 2 -2 2])
subplot(2,2,3); title('(c) 8-DPSK');xlabel('I');ylabel('Q');
grid; axis('square');axis([-2 2 -2 2])
subplot(2,2,4); title('(d) 16-DPSK');xlabel('I');ylabel('Q');
grid; axis('square');axis([-2 2 -2 2])

%%
% ***** For FSK modulations ******
freqsep = 32;
nsamp = 8;
Fs = 512;
figure('Units','characters','Position',[30 5 130 50]);

for constel=1:4
    K = 2^constel; 
% K = 2;
x = randi(K,n,1)-1;      % Create a signal source for FSK modulations.
y = fskmod(x, K, freqsep, nsamp, Fs);    % Create a modulator object
                         % and display its properties.
                         % Modulate the signal x.

y_chann = awgn(y ,SNR);       % Output of AWGN channel

% z = fskdemod(y_chann, K, freqsep, nsamp, Fs);   % Demodulate the signal y_chann. 

subplot(2,2,constel); plot(real(y_chann), imag(y_chann),'.','MarkerSize',4)  % I-Q diagram of output
% The k-mean command should be performed on y_chann

Data = [real(y_chann), imag(y_chann)];

[~,u]=KCenterClustering(Data,K);

[~, C1] = kmeans(Data, K, 'Start', u);
% 
% % plot(Data(:,1),Data(:,2),'.');
hold on, 
plot(C1(:,1),C1(:,2),'ro','MarkerEdgeColor','r',...
                          'MarkerFaceColor','r',...
                          'MarkerSize',4);
% progress;
end;
subplot(2,2,1); title('(a) 2-FSK');xlabel('I');ylabel('Q');
grid; axis('square');axis([-2 2 -2 2])
subplot(2,2,2); title('(b) 4-FSK');xlabel('I');ylabel('Q');
grid; axis('square');axis([-2 2 -2 2])
subplot(2,2,3); title('(c) 8-FSK');xlabel('I');ylabel('Q');
grid; axis('square');axis([-2 2 -2 2])
subplot(2,2,4); title('(d) 16-FSK');xlabel('I');ylabel('Q');
grid; axis('square');axis([-2 2 -2 2])

%%
% ***** For OQPSK modulations ******

figure('Units','characters','Position',[30 5 130 50]);

K = 4;
x = randintvec(n,K);   % Create a signal source for QAM modulations.
h = modem.oqpskmod;    % Create a modulator object
                       % and display its properties.
y = modulate(h,x);     % Modulate the signal x.

y_chann = awgn(y ,SNR);       % Output of AWGN channel

plot(real(y_chann), imag(y_chann),'.','MarkerSize',4)  % I-Q diagram of output

Data = [real(y_chann), imag(y_chann)];

[cluster,u]=KCenterClustering(Data,K);

[IDX1, C1] = kmeans(Data, K, 'Start', u);

% plot(Data(:,1),Data(:,2),'.');
hold on, 
plot(C1(:,1),C1(:,2),'ro','MarkerEdgeColor','r',...
                                   'MarkerFaceColor','r',...
                                   'MarkerSize',4);

title('OQPSK');xlabel('I');ylabel('Q'); 
grid; axis('square'); axis([-2 2 -2 2])
