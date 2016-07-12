% for test
% alpha = 2; %default significance level
clear all;
close all;
DB_min = 1;
DB_max = 25;
DB_var = 0;
AMP = 1;
SAMP_MAX = 1000;
iteration = 50;
% samp = 10000;         %Number of samples per signal

d_G = zeros(DB_max-DB_min+1,iteration);
d_G2 = zeros(DB_max-DB_min+1,iteration);

%%
for samp = 100:100:SAMP_MAX
t_G = 2; %with two degrees of freedom, Threshold
i = samp/100; %for making a vector from different sample sizes
% %% ======== For the sake of comparison with a normal distribution ========
% for eta = 1 : ceil(M)
%     for t = 1:T-eta
%         sumnoise(t) = -err(t).^2.*err(t+eta).^2 - err(t).^4;
%     end;
%     for t = eta+1 : T-eta
%         sumnoise_2(t) = -err(t).^2.*err(t+eta).*err(t-eta) - err(t).^4;
%     end;
%     
%     cum4n(eta) = 1/T*sum(sumnoise);
%     cum4n_2(eta) = 1/T*sum(sumnoise_2);
% 
% end;
% d_Gn(db) = cum4n * cov(cum4n)^-1 * cum4n';
% d_Gn_2(db) = cum4n_2 * cov(cum4n_2)^-1 * cum4n_2';

for iterate = 1:iteration
    err = randn(samp,1); %*10^(-db/10);
    X = rand(samp,1);
    T = length(X);
    % x = randn(T,1)*10;
    M = T^.4;

    sumelements = zeros(1,T);
    sumelements_2 = zeros(1,T);
    cum4 = zeros(1,ceil(M));
    cum4_2 = zeros(1,ceil(M));
    
    for db = DB_min:DB_max
        x = AMP*(X + err*10^(-(db-DB_var)/10));
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
    d_G(db,iterate) = cum4 * cov(cum4')^-1 * cum4';
    d_G2(db,iterate) = cum4_2 * cov(cum4_2')^-1 * cum4_2';
    progress(iterate);
    end;
end
d_G_ave(:,i) = mean(d_G,2);
d_G2_ave(:,i) = mean(d_G2,2);
end;
%% Finding average threshold
DB = (DB_min-DB_var):(DB_max-DB_var);

figure(1); 
plot(DB, d_G_ave(:,5)); grid; hold on
plot(DB, d_G2_ave(:,5),'r'); 
xlabel('SNR (dB)'), ylabel('Absolute value')
legend('First method','Second method')
% Normalizing the vectors
N = SAMP_MAX/100;
for i = 1:N
    d_G_norm(:,i) = d_G_ave(:,i)/norm(d_G_ave(:,i));
    d_G2_norm(:,i) = d_G2_ave(:,i)/norm(d_G2_ave(:,i));
end
%% Plotting the results
figure('Units','characters','Position',[5 5 100 55]);
subplot(2,1,1);plot(DB, d_G_ave); grid; hold on; 
axis normal
title('(a) d_{G4} calculated by first method in G-T test') 
xlabel('SNR (dB)'), ylabel('Absolute value')
legend('100 samples','200 samples','300 samples','400 samples','500 samples', ...
    '600 samples','700 samples','800 samples','900 samples','1000 samples', 'Location', 'EastOutside')
subplot(2,1,2);plot(DB, d_G_norm); grid; hold on; 
axis([DB_min DB_max 0.05 0.25])
title('(b) d_{G4} calculated by first method in G-T test, after normalization') 
xlabel('SNR (dB)'), ylabel('Normalized value')

figure('Units','characters','Position',[5 5 100 55]);
subplot(2,1,1);plot(DB, d_G2_ave); grid; hold on; 
axis normal
title('(a) d_{G4} calculated by second method in G-T test') 
xlabel('SNR (dB)'), ylabel('Absolute value')
legend('100 samples','200 samples','300 samples','400 samples','500 samples', ...
    '600 samples','700 samples','800 samples','900 samples','1000 samples', 'Location', 'EastOutside')
subplot(2,1,2);plot(DB, d_G2_norm); grid; hold on; 
axis([DB_min DB_max 0.05 0.25])
title('(b) d_{G4} calculated by second method in G-T test, after normalization') 
xlabel('SNR (dB)'), ylabel('Normalized value')
hold off
%%
% Examining to see if d_G_ave is linear with respect to the number of
% samples
lin = 1:SAMP_MAX/100;
reg1 = robustfit(lin, d_G_ave(5,:));
reg2 = robustfit(lin, d_G2_ave(5,:));
samp = 100:100:SAMP_MAX;

figure;
scatter(samp,d_G_ave(5,:),'filled'); grid on; hold on
plot(samp,reg1(1)+reg1(2)*lin,'g','LineWidth',2);
legend('G-T statistic','Robust Regression')
xlabel('Sample size')

figure;
scatter(samp,d_G2_ave(5,:),'filled'); grid on; hold on
plot(samp,reg2(1)+reg2(2)*lin,'g','LineWidth',2);
legend('G-T statistic','Robust Regression')
xlabel('Sample size')

