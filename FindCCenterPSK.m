function [IDX1, C]=FindCCenterPSK(SNR,n,K)
    x = randintvec(n,K);              % Create a signal source 
    h = modem.pskmod('M',K,'PhaseOffset',0,'SymbolOrder','binary');    % Create a modulator object
    y = modulate(h,x);                % Modulate the signal x.
    y_chann = awgn(y, SNR);                % Output of AWGN channel
%     g = modem.qamdemod(h);            % Create a demodulator object from a modem.qammod object and display its properties.
%     z = demodulate(g,y_chann);        % Demodulate the signal y_chann. 

    Data = [real(y_chann), imag(y_chann)];
    [~,u] = KCenterClustering(Data,K);
    [IDX1, C] = kmeans(Data, K, 'Start', u, 'emptyaction','drop');