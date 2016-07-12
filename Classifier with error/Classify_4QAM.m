function [outcome,error] = Classify_4QAM(SNR)

K       = 4;
outcome = zeros(1,5);
n       = 512;      % Number of samples

% 16-QAM 
C_16QAM   = [-3 -3;-3 -1;3 1;1 -1;1 1;-3 1;3 -1;-1 -1;-1 1; ...
     -1 -3;1 -3;3 -3;-3 3;-1 3;1 3;3 3];             % The default combination of constellation 16-QAM
% 8-QAM
C_8QAM = [-3 -1;3 1;1 -1;1 1;-3 1;3 -1;-1 -1;-1 1]; % The default combination of constellation 8-QAM
% 4-QAM as Default
C_4QAM = [1 1; -1 1; 1 -1; -1 -1]; % The default combination of constellation 4-QAM
constel_pow = sum(sum(C_4QAM.^2,2).^0.5);
% 16-PSK
for i = 1:16
    C(i)=exp(2*1i*pi*(i-1)/16);
end;
C_16PSK = [real(C);imag(C)]';
% 8-PSK 
for i = 1:8
    C(i)=exp(2*1i*pi*(i-1)/8);
end;
C_8PSK = [real(C);imag(C)]';

%
[~, C1] = FindCCenter(SNR,n,K);
        
index1 = knnsearch(C1,C_8PSK);
index2 = knnsearch(C1,C_4QAM);
index3 = knnsearch(C1,C_8QAM);
index4 = knnsearch(C1,C_16QAM);
index5 = knnsearch(C1,C_16PSK);
        for row = 1:length(C1)
            C_diff_1(row,:) = C_4QAM(index2(row),:)-C1(row,:);
            C_diff_2(row,:) = C1(index1(row),:)-C_8PSK(row,:);
            C_diff_3(row,:) = C1(index3(row),:)-C_8QAM(row,:);
            C_diff_4(row,:) = C1(index4(row),:)-C_16QAM(row,:);
            C_diff_5(row,:) = C1(index5(row),:)-C_16PSK(row,:);
        end
Cluster_error(1) = sum(sum(C_diff_1.^2,2).^0.5)/constel_pow;
Cluster_error(2) = sum(sum(C_diff_2.^2,2).^0.5)/constel_pow;
Cluster_error(3) = sum(sum(C_diff_3.^2,2).^0.5)/constel_pow;
Cluster_error(4) = sum(sum(C_diff_4.^2,2).^0.5)/constel_pow;
Cluster_error(5) = sum(sum(C_diff_5.^2,2).^0.5)/constel_pow;

%% Classification
Threshold = 0.06;
for i = 1:5
    if Cluster_error(i)< Threshold
        outcome(i) = 1;
    else
        error(i) = Cluster_error(i);
    end
end;    
