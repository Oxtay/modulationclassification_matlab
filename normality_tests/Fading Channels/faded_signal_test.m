c = rayleighchan(1/10000,100);
sig = 1i*ones(2000,1);  % Generate signal
y = filter(c,sig);      % Pass signal through channel
c                       % Display all properties of the channel

% Plot power of faded signal, versus sample number.
plot(20*log10(abs(y)))