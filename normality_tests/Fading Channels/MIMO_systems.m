% in this programe a highly scattered enviroment is considered. The
% Capacity of a MIMO channel with nt transmit antenna and nr recieve
% antenna is analyzed. The power in parallel channel (after
% decomposition) is distributed as water-filling algorithm

% the pdf of the matrix lanada elements is depicted too.

clear all
close all
clc

nt_V = [1 2 3 2 4];
nr_V = [1 2 2 3 4];

N0 = 1e-4;
B  = 1;
Iteration = 1e4; % must be grater than 1e2

SNR_V_db = [-10:3:20];
SNR_V    = 10.^(SNR_V_db/10);

color = ['b';'r';'g';'k';'c'];
notation = ['-o';'->';'<-';'-^';'-s'];

for(k = 1 : 5)
    nt = nt_V(k);
    nr = nr_V(k);
    for(i = 1 : length(SNR_V))
        Pt = N0 * SNR_V(i);
        for(j = 1 : Iteration)
            H = random('rayleigh',1,nr,nt);
            [S V D] = svd(H);
            landas(:,j)  = diag(V);
            [Capacity(i,j) PowerAllo] = WaterFilling_alg(Pt,landas(:,j),B,N0);
        end
    end

    f1 = figure(1);
    hold on
    plot(SNR_V_db,mean(Capacity'),notation(k,:),'color',color(k,:))
    
    f2 = figure(2);
    hold on
    [y,x] = hist(reshape(landas,[1,min(nt,nr)*Iteration]),100);
    plot(x,y/Iteration,'color',color(k,:));
    clear landas
end

f1 = figure(1)

legend_str = [];
for( i = 1 : length(nt_V))
    legend_str =[ legend_str ;...
        {['nt = ',num2str(nt_V(i)),' , nr = ',num2str(nr_V(i))]}];
end
legend(legend_str)
grid on
set(f1,'color',[1 1 1])
xlabel('SNR in dB')
ylabel('Capacity bits/s/Hz')

f2 = figure(2)
legend(legend_str)
grid on
set(f2,'color',[1 1 1])
ylabel('pdf of elements in matrix landa in svd decomposition of marix H')