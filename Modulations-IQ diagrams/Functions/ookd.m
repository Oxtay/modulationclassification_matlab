function ookd(g,f)
%Modulation  OOK
% Example:
% ookd([1 1 0 1 0],2)
%Author: Diego Orlando Barragán Guerrero
%diegokillemall@yahoo.com
%Private Technical University of Loja (ECUADOR)
%Long Live Heavy-Metal
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

t=0:2*pi/99:2*pi;
cp=[];sp=[];
mod=[];mod1=[];bit=[];

for n=1:length(g);
    if g(n)==0; 
        die=zeros(1,100);   %Modulante
        se=zeros(1,100);    %Señal
    else g(n)==1;
        die=ones(1,100);    %Modulante
        se=ones(1,100);     %Señal
    end
    c=sin(f*t);
    cp=[cp die];    
    mod=[mod c];    
    bit=[bit se];
end

ook=cp.*mod;
subplot(2,1,1);plot(bit,'LineWidth',1.5);grid on;
title('Binary Signal');
axis([0 100*length(g) -2.5 2.5]);


subplot(2,1,2);plot(ook,'LineWidth',1.5);grid on;
title('OOK modulation');
axis([0 100*length(g) -2.5 2.5]); 