% Example for creating a MIMO rayleigh fading channel
% The following example creates a MIMO channel object with two transmit 
% and receive antennas, three paths, Rician K-factor greater than zero, 
% and specific correlation matrices. First create the channel object 
% using the mimochan function
chan = mimochan(2, 2, 1e-4, 60, [0 2.5e-4 3e-4], [0 -2 -3])

chan.KFactor = 2;
chan.TxCorrelationMatrix = [1 0.6; 0.6 1];
chan.RxCorrelationMatrix = [1 0.5*1i; -0.5*1i 1];

y = filter(chan, ones(20, 2));

t=(0:19)*chan.InputSamplePeriod;
plot(t,abs(y))
xlabel('Time (s)')
ylabel('Amplitude')
legend('1st antenna output','2nd antenna output')