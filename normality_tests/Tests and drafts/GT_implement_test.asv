% Comparing in time of two different implementations of Giannakis-Tsatsanis
% test
% Written by Okhtay Azarmanesh
close all
clear all

%% initializing
DB_min    = 3;
DB_max    = 25;
n         = 2;      % Number of Normality tests
samp      = 100;    %Number of samples per signal
iteration = 10000;    % Number of runs per simulation
err_all1   = zeros((DB_max-DB_min+1),1);
err_all2   = zeros((DB_max-DB_min+1),1);
err_all3   = zeros((DB_max-DB_min+1),1);
t1        = zeros(iteration,1);
t2        = zeros(iteration,1);
t3        = zeros(iteration,1);
i         = 1;

%%
for db = DB_min:DB_max

error1=0;
error2=0;
error3=0;
    for j=1:iteration
        err = randn(samp,1)*10^(-db/10);
        X_1 = rand(samp,1);
        X = X_1 + err;
        
        tic
        [h1, d_g1, time1] = GTtest1(real(X));
        time_out1 = toc;
        
        tic
        [h2, d_g2, time2] = GTtest2(real(X));
        time_out2 = toc;
        
        tic
        [h3, d_g3, time3] = GTtest3(real(X));
        time_out3 = toc;
        
            if h1==0
                error1=error1+1;
            end;
            if h2==0
                error2=error2+1;
            end;
            if h3==0
                error3=error3+1;
            end;
        t1(j)=time1; %assigning times from each calculation of different tests into a vector
        t2(j)=time2; %assigning times from each calculation of different tests into a vector
        t3(j)=time3; %assigning times from each calculation of different tests into a vector
   end;
    err_all1(i)=error1/iteration; %Average error for a correct normality detection per #iteration of simulations
    err_all2(i)=error2/iteration; %Average error for a correct normality detection per #iteration of simulations
    err_all3(i)=error3/iteration; %Average error for a correct normality detection per #iteration of simulations
    i=i+1;
end;

%% Averaging
t_ave(1) = mean(t1); %average time from 100 runs of norm test
t_ave(2) = mean(t2); %average time from 100 runs of norm test
t_ave(3) = mean(t3); %average time from 100 runs of norm test

%% Plotting error vs. SNR

figure(1);
db = DB_min:DB_max;
plot(db, err_all1,'-rx', db, err_all2,'--bd', db, err_all3,'--go');
grid; axis('square'); 
title('Error vs. SNR for Gaussian signals')
xlabel('SNR'); ylabel('Eror rate');
legend('G-T 1', 'G-T 2', 'G-T 3');

%% Time average plotting of different tests

figure(2)
h = bar(t_ave);
set(gca, 'ylim', [2.4e-5 2.7e-5])
title('For Gaussian signals')
grid on;
xlabel('Gaussianity tests'); ylabel('Time elapsed (sec)');
