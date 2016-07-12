EbNo = 8:2:20;
M = 16; % Use 16 QAM
L = 1;  % Start without diversity
ber = berfading(EbNo,'qam',M,L);
semilogy(EbNo,ber);
text(18.5, 0.02, sprintf('L=%d', L))
hold on
% Loop over diversity order, L, 2 to 20
for L=2:20
    ber = berfading(EbNo,'qam',M,L);
    semilogy(EbNo,ber);
end
text(18.5, 1e-11, sprintf('L=%d', L))
title('QAM over fading channel with diversity order 1 to 20')
xlabel('E_b/N_o (dB)')
ylabel('BER')
grid on