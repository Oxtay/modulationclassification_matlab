function OFDM_offset_clustering(D_parameter)
% Original OFDM code, written by fred harris
% Modified for Modulation Classification purposes, by Okhtay Azarmanesh
% Feb 10, 2011
% ofdm_802ii_call(d_frq,d_tm,d_clk,d_gn,d_phs,del_t)
% clear all;
% D_parameter = [0,.1,0,0,0,0];

% Initializing
d_frq = D_parameter(1); %Carrier Frequency Offset
d_tm  = D_parameter(2); %Frame Time Offset
d_clk = D_parameter(3); %Sampling Clock Offset
d_gn  = D_parameter(4); %I-Q Fain Imbalance
d_phs = D_parameter(5); %I-Q Phase Imbalance
del_t = D_parameter(6); %I-Q Differential time

% global D_frq D_tm D_clk D_gn D_phs Del_t;

% ff1=(-0.5:1/128:.5-1/128);
% f1dat=zeros(1,128);

hh1=sinc(-4+del_t:4+del_t).*kaiser(9,5)';
hh1=hh1/sum(hh1);
hh2=[0   0   0   0  1  0   0   0   0];


hh1a=sinc(-4+d_tm:4+d_tm).*kaiser(9,5)';
hh1a=hh1a/sum(hh1a);

hh1b=sinc(-4-0.1:4-0.1).*kaiser(9,5)';
hh1c=sinc(-4+0.1:4+0.1).*kaiser(9,5)';
hh1d=5*(hh1b-hh1c);

for mm=1:30
% generate reference data
fd1=zeros(1,128);
dx1=(floor(4*rand(1,52))-1.5)/1.5;
dy1=(floor(4*rand(1,52))-1.5)/1.5;
dx1(27)=0;
dy1(27)=0;
%go to time domain
fd1(64-26:64+25)=dx1+1i*dy1;
fd1=fftshift(fd1);
d1=ifft(fd1);
% in time domain

% delay quadrature response relative to in-phase response
x1=real(d1);
y1=imag(d1);
%add cyclic prefix and then delay quad signal and strip prefix
x2=[x1(120:128) x1 x1(1:9)];
y2=[y1(120:128) y1 y1(1:9)];

x3=conv(x2,hh2);
y3=conv(y2,hh1);

x4=x3(14:141);
y4=y3(14:141);
% differential delay on I and Q has been inserted


% insert gain and phase imbalance

d1a=x4+1i*(1+d_gn)*y4*exp(1i*d_phs);
% gain and phase imbalance inserted

%adding frequency offset

d1a=d1a.*exp(-1i*2*pi*(-64:63)*d_frq/128);
%shifted spectrum

%now insert block delay
x1=real(d1a);
y1=imag(d1a);
%add cyclic prefix and then delay quad signal and strip prefix
x2=[x1(120:128) x1 x1(1:9)];
y2=[y1(120:128) y1 y1(1:9)];

x3=conv(x2,hh1a);
y3=conv(y2,hh1a);

x4=x3(14:141);
y4=y3(14:141);
d1a=x4+1i*y4;
% block delay on I and Q has been inserted

% now insert clock offset
x1=real(d1a);
y1=imag(d1a);
%add cyclic prefix and then delay quad signal and strip prefix
x2=[x1(120:128) x1 x1(1:9)];
y2=[y1(120:128) y1 y1(1:9)];

x3=conv(x2,hh1d);
y3=conv(y2,hh1d);

x3a=conv(x2,hh2);
y3a=conv(y2,hh2);

x3b=x3a+(d_clk/153)*(-77:76).*x3;
y3b=y3a+(d_clk/153)*(-77:76).*y3;


x4=x3b(14:141);
y4=y3b(14:141);
d1a=x4+1i*y4;
% block delay on I and Q has been inserted

% clock offset inserted
% d1a=d1a+0.0078*exp(-j*2*pi*(rand(1)+(0:127)*4.5/128));
fd2a=fftshift(fft(d1a));
fdet2(mm,:)=fd2a(64-(-28:28));
f_avg(mm,:)=fd2a;
end
% figure(1)
% %subplot(2,2,2)
% plot(-0.5:1/56:0.5,real(fdet2(:,1:57)),'or')
% grid
% title('Real Spectrum (In-Phase) ')
% xlabel('Normalized Frequency')
% ylabel('Amplitude')
% figure(2)
% %subplot(2,2,4)
% plot(-0.5:1/56:0.5,real(fdet2(:,1:57)),'or')
% grid
% title('Imaginary Spectrum (Quad-Phase)')
% xlabel('Normalized Frequency')
% ylabel('Amplitude')
% figure(3)
%subplot(2,2,3)
% gg=get(gca);
% set(gca,'gridlinestyle','-')
plot(fdet2(:,1:57),'.b','MarkerSize',5)

%========== Clustering ===========
const_size = 16; %Constellation size
dimension = size(fdet2);

%convert the dimension of fdet2 from 16x114 to 1710x1
farray = reshape(fdet2, 1, dimension(1)*dimension(2));
Data   = [real(farray'), imag(farray')];
[cluster,u]=KCenterClustering(Data,const_size);

[IDX1, C1] = kmeans(Data, const_size, 'Start', u);

hold on;
plot(C1(:,1),C1(:,2),'rp','MarkerEdgeColor','r',...
                          'MarkerFaceColor','r',...
                          'MarkerSize',8);
grid
axis('square')
axis([-1.5 1.5 -1.5 1.5])