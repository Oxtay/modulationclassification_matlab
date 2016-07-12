function qpskd(g,f)
%Modulation  QPSK
%Example: g is a binay vector; f is the carrier frequency. 
%qpskd([1 0 1 1 0 0],2)
%Author. Diego Orlando Barragán Guerrero
%diegokillemall@yahoo.com
%Private Technical University of Loja (ECUADOR)
%See also:
%http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=14328&objectType=FILE
if nargin > 2
    error('Too many input arguments');
elseif nargin==1
    f=1;
end

if f<1;
    error('Frequency must be bigger than 1');
end
%*-*-*-*-*-*
l=length(g);
r=l/2;
re=ceil(r);
val=re-r;

if val~=0;
    error('Please insert a vector divisible for 2');
end
%*-*-*-*-*-*

t=0:2*pi/99:2*pi;
cp=[];sp=[];
mod=[];mod1=[];bit=[];
for n=1:2:length(g);
    if g(n)==0 && g(n+1)==1;
        die=sqrt(2)/2*ones(1,100);
        die1=-sqrt(2)/2*ones(1,100);
        se=[zeros(1,50) ones(1,50)];
    elseif g(n)==0 && g(n+1)==0;
        die=-sqrt(2)/2*ones(1,100);
        die1=-sqrt(2)/2*ones(1,100);
        se=[zeros(1,50) zeros(1,50)];
    elseif g(n)==1 && g(n+1)==0;
        die=-sqrt(2)/2*ones(1,100);
        die1=sqrt(2)/2*ones(1,100);
        se=[ones(1,50) zeros(1,50)];
    elseif g(n)==1 && g(n+1)==1;
        die=sqrt(2)/2*ones(1,100);
        die1=sqrt(2)/2*ones(1,100);
        se=[ones(1,50) ones(1,50)];
    end
    c=cos(f*t);
    s=sin(f*t);
    cp=[cp die];    %Amplitude cosino
    sp=[sp die1];   %Amplitude sino
    mod=[mod c];    %cosino carrier (Q)
    mod1=[mod1 s];  %sino carrier   (I)
    bit=[bit se];
end
bpsk=cp.*mod+sp.*mod1;
subplot(2,1,1);plot(bit,'LineWidth',1.5);grid on;
title('Binary Signal')
axis([0 50*length(g) -1.5 1.5]);

subplot(2,1,2);plot(bpsk,'LineWidth',1.5);grid on;
title('QPSK modulation')
axis([0 50*length(g) -1.5 1.5]); 