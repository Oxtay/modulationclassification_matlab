% for test
clear all;
close all;
DB_min = 1;
DB_max = 30;
DB_var = 0;
AMP    = 1;
iteration = 10;
samp      = 500;         %Number of samples per signal
error = zeros(DB_max-DB_min+1, iteration);

d_G  = zeros(DB_max-DB_min+1,iteration);
d_G2 = zeros(DB_max-DB_min+1,iteration);
h_1  = zeros(DB_max-DB_min+1,iteration);
h_2  = zeros(DB_max-DB_min+1,iteration);

%%
t_G = 2*10^4; %with two degrees of freedom, Threshold

for iterate = 1:iteration
    err = randn(samp,1); %*10^(-db/10);
    X = rand(samp,1);
    N = length(X);
    % x = randn(T,1)*10;
    M = N^.4;

    sumelements   = zeros(1,N);
    sumelements_2 = zeros(1,N);
    cum4   = zeros(1,ceil(M));
    cum4_2 = zeros(1,ceil(M));
    
    for db = DB_min:DB_max
        x = AMP*(X + err*10^(-(db-DB_var)/10));
        for eta = 1 : ceil(M)
            for t = 1:N-eta
                sumelements(t) = -x(t).^2.*x(t+eta).^2 - x(t).^4;
            end;
            for t = eta+1:N-eta
                sumelements_2(t) = -x(t).^2.*x(t+eta).*x(t-eta) - x(t).^4;
            end;    
            cum4(eta)   = 1/N*sum(sumelements);
            cum4_2(eta) = 1/N*sum(sumelements_2);
        end;
    d_G(db,iterate) = cum4 * cov(cum4)^-1 * cum4';
    d_G2(db,iterate) = cum4_2 * cov(cum4_2)^-1 * cum4_2';
    
    if d_G(db,iterate) <= t_G;
         h_1(db,iterate) = 0;
    else
         h_1(db,iterate) = 1;
    end
    
    if d_G2(db,iterate) <= t_G;
         h_2(db,iterate) = 0;
    else
         h_2(db,iterate) = 1;
    end
    
%     for count = 1:iteration
%             if h_1(db,count)==0
%                 error(db,count)=error(db,count)+1;
%             end;
%     end
    
    end
end
d_G_ave  = mean(d_G,2);
d_G2_ave = mean(d_G2,2);
h_1ave   = mean(h_1,2);
h_2ave   = mean(h_2,2);
%% Plotting the results

DB = (DB_min-DB_var):(DB_max-DB_var);

figure(1); 
plot(DB, d_G_ave); grid; hold on

figure(2);
plot(DB, d_G2_ave); grid; hold on

figure(3);
plot(DB, h_1ave); grid

figure(4);
plot(DB, h_2ave); grid

