clear all;
n=10;                % Number of samples
SNR=0.03;                % The amount of noise after passing from an AWGN channel(Not exactly sure how to measure it with dB scale
x = randint(n,1)+randint(n,1)+randint(n,1)+randint(n,1)+randint(n,1)+randint(n,1)+randint(n,1)+randint(n,1);   % Create a signal source for 16QAM.
h = modem.pskmod('M',2,'PhaseOffset',0,'SymbolOrder','binary');    % Create a modulator object
                       % and display its properties.
y = modulate(h,x);     % Modulate the signal x.
noise=SNR*randn(n,1)+i*SNR*randn(n,1);
y_chann = y+noise;     % Output of AWGN channel
g = modem.pskdemod(h); % Create a demodulator object
                       % from a modem.qammod object
                       % and display its properties.
z = demodulate(g,y_chann);   % Demodulate the signal y_chann. 
figure(1)
plot(real(y_chann), imag(y_chann),'.')  % I-Q diagram of output
% The k-mean command should be performed on y_chann
