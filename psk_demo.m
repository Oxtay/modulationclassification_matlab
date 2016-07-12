
nBit = 3;
M = 2^nBit;
N = 1e2;						% Number of samples
Ex = 1;

EbN0_dB = 10;
EbN0 = 10.^(EbN0_dB/10);
EsN0 = EbN0 * (nBit);

noise_var = 0.5*Ex/EsN0;
a = randsrc(N, 1, [0:M-1]);
x = pskmod(a, M);				% Modulate the signal x.
noise = 0.5*sqrt(noise_var) * (randn(N,1) + sqrt(-1)*randn(N,1));
y = x + noise;					% Output of AWGN channel
x_hat = pskdemod(y, M);			% Demodulate the signal y_chann. 	
scatterplot(y);


%% ---
nBit = 1;
M = 2^nBit;
temp = pskmod(0:M-1, M);
Ex = mean(abs(temp).^2);

%% ---
EbN0_dB = 1:10;
EbN0 = 10.^(EbN0_dB/10);
EsN0 = EbN0 * (nBit);
EsN0_dB = 10*log10(EsN0);

Error = zeros(length(EbN0_dB), 1);
BER = zeros(length(EbN0_dB), 1);

%% ---
framesize = 1e4;
for k = 1:length(EsN0)
	tic
	SNR = EsN0(k);
	fprintf('[%4.1f dB] ' , EbN0_dB(k)); 
	
	noise_var = 0.5 * (Ex/SNR);
	sigma = sqrt(noise_var);
	
	DataLength = 0;
	fprintf('wait ...  '); 
	t = 1;
	while Error(k) < 100,
		progress(Error(k));
		
		msg = randsrc(1, framesize, 0:M-1);
		s = pskmod(msg, M, 0);

		n = sigma * (randn(1, length(s))+sqrt(-1)*randn(1, length(s)));
		y = s + n;						% the received signal after feedforward filter nff taps
		
		d = pskdemod(y, M, 0);
		[n_e, ratio] = biterr(d, msg);
		DataLength = DataLength + framesize * nBit;
		Error(k) = Error(k) + n_e;
	end
	fprintf('\b completed.\n');
	fprintf('%d errors in %d bits \n', Error(k), DataLength);
	BER(k) = Error(k)/DataLength;
	toc
	fprintf('\n');
end

h = semilogy(EbN0_dB, BER, 'bo-'); 
grid on, hold on;
title('Error Rate Performance')
xlabel('\gamma_b [dB]'), ylabel('P_e(b)');

