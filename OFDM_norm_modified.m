clear all;

Fd=1;             % symbol rate (1Hz)
Fs=1*Fd;          % number of sample per symbol
M=4;              % kind(range) of symbol (0,1,2,3)
SNR = 5;
Ndata=512;        % all transmitted data symbol 
Sdata=64;         % 64 data symbol per frame to ifft
Slen=128;         % 128 length symbol for IFFT 
Nsym=Ndata/Sdata; % number of frame -> Nsym frame
GIlen=144;        % symbol with GI insertion
GI=16;            % guard interval length

% vector initialization
Y1=zeros(Ndata,1);
Y3=zeros(Slen,1);
z0=zeros(Slen,1);
signal=zeros(Ndata/Sdata*Slen,1);

% random integer generation by M kinds 
X = randint(Ndata, 1, M);

% digital symbol mapped as analog symbol
Y2 = qammod(X, M);
% 
% % covert to complex number
% Y2=ammod(Y1, 1, Fd);

for j=1:Nsym;

    for i=1:Sdata;
        Y3(i+Slen/2-Sdata/2,1)=Y2(i+(j-1)*Sdata,1);
    end

    z0=ifft(Y3);
    
    for i=1:Slen;
        signal(((j-1)*Slen)+i)=z0(i,1);
    end    
end

%% ************************************************************
% z1 is the OFDM signal with lenght 2048 and is complex
% A noisy signal in Rice or Reyleigh channel should be included
% noisy_signal
alpha=.05;
% alpha is the significance level in the range of [0.001,0.50]
% AGWN channel with differenc noise levels
sig_nois=awgn(signal,SNR,'measured');

%% *** Testing with a single carrier QPSK signal ***
constel = 2;
K=2^constel;
x = randintvec(Ndata,K);   % Create a signal source for PSK.
h = modem.pskmod('M',K,'PhaseOffset',0,'SymbolOrder','binary');    % Create a modulator object
                       % and display its properties.
y = modulate(h,x);     % Modulate the signal x.

sig_qpsk = awgn(y, SNR, 'measured');   % Output of AWGN channel


%% ************************************************
str = {'Jarque-Bera','Giannakis-Tsatsanis','Kolmogorov-Smirnov','Shapiro-Wilk',...
    'Anderson-Darling','D''Agostino-Pearson', 'Cramer-von Mises', 'Lilliefors', 'Chi^2'};
options.Interpreter='tex';
[s,v] = listdlg('PromptString','Select a test:',...
                'SelectionMode','single',...
                'ListString',str);
switch s  
    case 1
        [h_0,p_0]      = jbtest(abs(signal),alpha);  
        [h_awgn,p_awgn]= jbtest(abs(sig_nois),alpha);
        [h_sc,p_sc]    = jbtest(abs(sig_qpsk),alpha);
        
    case 2
        [h_0,p_0]      = GTtest(abs(signal));   
        [h_awgn,p_awgn]= GTtest(abs(sig_nois));
        [h_sc,p_sc]    = GTtest(abs(sig_qpsk));
        
    case 3
        [h_0,p_0]      = kstest(abs(signal),[], alpha, 0);   
        [h_awgn,p_awgn]= kstest(abs(sig_nois),[], alpha, 0);
        [h_sc,p_sc]    = kstest(abs(sig_qpsk),[], alpha, 0);

    case 4
        [h_0,p_0]      = swtest(abs(signal),alpha,1);   
        [h_awgn,p_awgn]= swtest(abs(sig_nois),alpha,1);
        [h_sc,p_sc]    = swtest(abs(sig_qpsk),alpha,1);

    case 5
        [h_0]      = AnDartest(abs(signal),alpha);   
        [h_awgn]= AnDartest(abs(sig_nois),alpha);
        [h_sc]    = AnDartest(abs(sig_qpsk),alpha);

    case 6
        h_0      = DagosPtest(abs(signal),alpha);  
        h_awgn= DagosPtest(abs(sig_nois),alpha);
        h_sc    = DagosPtest(abs(sig_qpsk),alpha);

    case 7
        h_0            = CVtest(abs(signal)',alpha);   
        h_awgn         = CVtest(abs(sig_nois)',alpha);
        h_sc           = CVtest(abs(sig_qpsk)',alpha);

    case 8
        [h_0,p_0]      = lillietest(abs(signal),alpha, 'norm');   
        [h_awgn,p_awgn]= lillietest(abs(sig_nois),alpha, 'norm');
        [h_sc,p_sc]    = lillietest(abs(sig_qpsk),alpha, 'norm');

    case 9
        [h_0,p_0]      = chi2gof(abs(signal));   
        [h_awgn,p_awgn]= chi2gof(abs(sig_nois));
        [h_sc,p_sc]    = chi2gof(abs(sig_qpsk));
end

Hypothesis = [h_0, h_awgn, h_sc]
