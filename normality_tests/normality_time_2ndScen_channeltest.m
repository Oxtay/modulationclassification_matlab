% Simulating Normality tests - For calculation of error rate in Normality
% tests
% Written by Okhtay Azarmanesh
close all
clear all
% tic;

%% initializing
DB_min    = 3;
DB_max    = 15;
n         = 9;      % Number of Normality tests
samp      = 512;    %Number of samples per signal
iteration = 10;    % Number of runs per simulation
err_all   = zeros((DB_max-DB_min+1),n);
ti        = zeros(iteration, n);
i         = 1;
signif    = 0.05;
% counter = 1;
M         = 4;
h         = modem.pskmod('M',M,'PhaseOffset',0,'SymbolOrder','binary');

%%
for db = DB_min:DB_max

error=zeros(n,1);
% for alp=0.01:0.01:signif % Test significance importance in our results
    for j=1:iteration
            % Defining the waveform and how the signal will be tested in a channel.
        X_2 = randi(M,samp,1)-1;
        X_1 = modulate(h,X_2); % Modulating the signal with PSK
        X = awgn(X_1,db);   % Transmitting the signal through a AWGN Channel
        [H,Threshold,t] = norm_test_time(real(X), signif);
        for count = 1:n
            if H(count)==0
                error(count)=error(count)+1;
            end;
        end;
%         hy(j,:)=H; %assigning all the hypothesis results into a vector
        ti(j,:)=t; %assigning times from each calculation of different tests into a vector
   end;
    err_all(i,:)=error/iteration; %Average error for a correct normality detection per #iteration of simulations
    i=i+1;
end;

parfor i=1:(DB_max-DB_min+1)    
%     hy_ave(i,:) = mean(hy); %average hypothesis results from 100 runs of the norm test
    ti_ave(i,:) = mean(ti); %average time from 100 runs of norm test
end;
%     i=i+1;
% end;
% alp=0.01:0.01:signif;
% figure(1);plot(alp, ti_ave);
% figure(2);plot(alp, hy_ave);
% figure(3);plot(ti_ave(20));
% figure(4);plot(hy_ave(1));
% figure(5);plot(hy_ave(10));
% figure(6);plot(hy_ave(20));
% err_percent = error/(signif*100)
% elaps_time = toc;

%% Plotting error vs. SNR

figure(1);
db = DB_min:DB_max;
semilogy(db, err_all(:,1),'-rx');
hold on
semilogy(db, err_all(:,2),'--bd');
semilogy(db, err_all(:,3),'-gp');
semilogy(db, err_all(:,4),'-c+');
semilogy(db, err_all(:,5),'--mo');
semilogy(db, err_all(:,6),':bs');
semilogy(db, err_all(:,7),':k^');
semilogy(db, err_all(:,8),'-.r*');
semilogy(db, err_all(:,9),'-.b*');

legend('Jarque-Bera','Kolmogorov-Smirnov', 'Lilliefors', ...
    '\chi^2', 'Shapiro-Wilk', 'Anderson-Darling'...
    , 'D''Agostino-Pearson', 'Cramer-von Mises', 'Giannakis-Tsatsanis');
grid; axis('square'); 
% figure('Units','characters','Position',[5 5 90 50]);
title('Error vs. SNR')
xlabel('SNR'); ylabel('Error rate');

%% Plotting time

% figure(2);
% plot(db, ti_ave(:,1),'-rx');
% hold on
% plot(db, ti_ave(:,2),'--bd');
% plot(db, ti_ave(:,3),'-gp');
% plot(db, ti_ave(:,4),'-c+');
% plot(db, ti_ave(:,5),'--mo');
% plot(db, ti_ave(:,6),':bs');
% plot(db, ti_ave(:,7),':k^');
% plot(db, ti_ave(:,8),'-.r*');
% 
% legend('Jarque-Bera','Kolmogorov-Smirnov', 'Lilliefors', ...
%     '\chi^2', 'Shapiro-Wilk', 'Anderson-Darling'...
%     , 'DAgostino-Pearson', 'Cramer-von Mises');
% grid; axis('square'); 
% % figure('Units','characters','Position',[5 5 90 50]);
% title('Time Elapsed by each Normality Test')
% xlabel('SNR'); ylabel('Time (sec)');

%% Time average plotting of different tests

figure(2);
h = bar(ti_ave(1,:));
% hold on
% for chakhan = 1:n
%     h(chakhan) = bar(chakhan, ti_ave(1,chakhan));
% end;
% hold off
% set(gca, 'YGrid', 'on')
% 
% ch = get(h,'Children');
% fvd = get(ch,'Faces');
% fvcd = get(ch,'FaceVertexCData');
% [zs, izs] = sortrows(ti_ave(1,:)',1);
% 
% k = 128;                % Number of colors in color table
% colormap(jet(k));    % Expand the previous colormap
% shading interp          % Needed to graduate colors
% for i = 1:n
%     color = floor(k*i/n);       % Interpolate a color index
%     row = izs(i);               % Look up actual row # in data
%     fvcd(fvd(row,1)) = 1;       % Color base vertices 1st index
%     fvcd(fvd(row,4)) = 1;    
%     fvcd(fvd(row,2)) = color;   % Assign top vertices color
%     fvcd(fvd(row,3)) = color;
% end
% set(ch,'FaceVertexCData', fvcd);  % Apply the vertex coloring
% set(ch,'EdgeColor','k')           % Give bars black borders
% title('')
grid on;
xlabel('Gaussianity tests'); ylabel('Time elapsed (sec)');
