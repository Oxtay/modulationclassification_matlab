% for testing GT normality test for 3rd Scenario: feeding a real modulated
% QPSK signal into an AWGN channel and performing the test on it.
clear all;
close all;
DB_min      = 1;
DB_max      = 25;
DB_var      = 0;
SAMP_MAX    = 1000;
iteration   = 50;
Mod         = 4;
h           = modem.pskmod('M',Mod);
d_G         = zeros(DB_max-DB_min+1,iteration);
d_G2        = zeros(DB_max-DB_min+1,iteration);

%%
for samp = 100:100:SAMP_MAX
    i = samp/100; %for making a vector from different sample sizes

    for iterate = 1:iteration
         X_2 = randi(Mod,samp,1)-1;
         X_1 = modulate(h,X_2);
         T   = length(X_1);
         M   = T^.4;

         sumelements = zeros(1,T);
         sumelements_2 = zeros(1,T);
         cum4 = zeros(1,ceil(M));
         cum4_2 = zeros(1,ceil(M));
    
       for db = DB_min:DB_max
             x = awgn(X_1,db-DB_var);
             for eta = 1 : ceil(M)
                for t = 1:T-eta
                    sumelements(t) = -x(t).^2.*x(t+eta).^2 - x(t).^4;
                end;
                for t = eta+1:T-eta
                    sumelements_2(t) = -x(t).^2.*x(t+eta).*x(t-eta) - x(t).^4;
                end;    
                cum4(eta) = 1/T*sum(sumelements);
                cum4_2(eta) = 1/T*sum(sumelements_2);
            end;
            d_G(db,iterate) = cum4 * cov(cum4)^-1 * cum4';
            d_G2(db,iterate) = cum4_2 * cov(cum4_2)^-1 * cum4_2';
       end;
    end
    d_G_ave(:,i)  = mean(d_G,2);
    d_G2_ave(:,i) = mean(d_G2,2);

end;
%% Finding average threshold
DB = (DB_min-DB_var):(DB_max-DB_var);

% Normalizing the vectors
N = SAMP_MAX/100;
for i = 1:N
    d_G_norm(:,i)  = d_G_ave(:,i)/norm(d_G_ave(:,i));
    d_G2_norm(:,i) = d_G2_ave(:,i)/norm(d_G2_ave(:,i));
end
%% Plotting the results
figure('Units','characters','Position',[5 5 100 55]);
subplot(2,1,1);plot(DB, d_G_ave); grid; hold on; 
axis normal
title('(a) Before normalization') 
xlabel('SNR (dB)'), ylabel('Absolute value')
legend('100 samples','200 samples','300 samples','400 samples','500 samples', ...
    '600 samples','700 samples','800 samples','900 samples','1000 samples', 'Location', 'EastOutside')
subplot(2,1,2);plot(DB, d_G_norm); grid; hold on; 
axis([DB_min DB_max 0.0 0.30])
title('(b) d_{G4}, first method in G-T test, for QPSK signal after AWGN channel, after normalization') 
xlabel('SNR (dB)'), ylabel('Normalized value')

figure('Units','characters','Position',[5 5 100 55]);
subplot(2,1,1);plot(DB, d_G2_ave); grid; hold on; 
axis normal
title('(a) Before normalization') 
xlabel('SNR (dB)'), ylabel('Absolute value')
legend('100 samples','200 samples','300 samples','400 samples','500 samples', ...
    '600 samples','700 samples','800 samples','900 samples','1000 samples', 'Location', 'EastOutside')
subplot(2,1,2);plot(DB, d_G2_norm); grid; hold on; 
axis([DB_min DB_max 0.0 0.30])
title('(b) d_{G4}, second method in G-T test, QPSK signal after AWGN channel, after normalization') 
xlabel('SNR (dB)'), ylabel('Normalized value')
hold off

lin = 1:SAMP_MAX/100;
reg1 = robustfit(lin, d_G_ave(5,:));
reg2 = robustfit(lin, d_G2_ave(5,:));



