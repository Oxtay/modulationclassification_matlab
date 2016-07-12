function outcome = Classify_64QAM(SNR)
% clear all
% SNR     = 10;
K       = 64;
outcome = zeros(1,6);
n       = 512;      % Number of samples

% 16-QAM The default combination of constellation 16-QAM
C_16QAM = [-3 -3;-3 -1;3 1;1 -1;1 1;-3 1;3 -1;-1 -1;-1 1;-1 -3;1 -3;3 -3;-3 3;-1 3;1 3;3 3]; 
C_16QAM_rep  = [C_16QAM;C_16QAM;C_16QAM;C_16QAM];
% 8-QAM  The default combination of constellation 8-QAM
C_8QAM  = [-3 -1;3 1;1 -1;1 1;-3 1;3 -1;-1 -1;-1 1;-3 -1;3 1;1 -1;1 1;-3 1;3 -1;-1 -1;-1 1];
C_8QAM_rep  = [C_8QAM;C_8QAM;C_8QAM;C_8QAM];

% 4-QAM  The default combination of constellation 4-QAM
C_4QAM  = [1 1;-1 1;1 -1;-1 -1;1 1;-1 1;1 -1;-1 -1;1 1;-1 1;1 -1;-1 -1;1 1;-1 1;1 -1;-1 -1];
C_4QAM_rep  = [C_4QAM;C_4QAM;C_4QAM;C_4QAM];
% 64-QAM 
C_QAM = zeros(sqrt(K),sqrt(K));
for i = 1:sqrt(K)
    for j = 1:sqrt(K)
        C_QAM(i,j) = (2*(i-sqrt(K)/2)-1)+1i*(2*(j-sqrt(K)/2)-1);
    end
end
D       = [real(C_QAM) imag(C_QAM)];
C_64QAM = reshape(D,K,2);

% 16-PSK
for i = 1:16
    C_PSK(i)=exp(2*1i*pi*(i-1)/16);
end;
C_16PSK = [real(C_PSK);imag(C_PSK)]';
C_16PSK_rep = [C_16PSK;C_16PSK;C_16PSK;C_16PSK];
% 8-PSK 
for i = 1:8
    C_psk(i)=exp(2*1i*pi*(i-1)/8);
end;
C_8PSK = [real(C_psk);imag(C_psk)]';
C_8PSK_rep1 = [C_8PSK;C_8PSK;C_8PSK;C_8PSK];
C_8PSK_rep  = [C_8PSK_rep1;C_8PSK_rep1];
%
constel_pow = sum(sum(C_64QAM.^2,2).^0.5);
[~, C1] = FindCCenter(SNR,n,K);
        
index1 = knnsearch(C1,C_64QAM);
index2 = knnsearch(C1,C_4QAM_rep);
index3 = knnsearch(C1,C_8QAM_rep);
index4 = knnsearch(C1,C_16QAM_rep);
index5 = knnsearch(C1,C_8PSK_rep);
index6 = knnsearch(C1,C_16PSK_rep);
        for row = 1:length(C1)
            C_diff_1(row,:) = C1(index1(row),:)-C_64QAM(row,:);
            C_diff_2(row,:) = C_4QAM_rep(index2(row),:)-C1(row,:);
            C_diff_3(row,:) = C_8QAM_rep(index3(row),:)-C1(row,:);
            C_diff_4(row,:) = C_16QAM_rep(index4(row),:)-C1(row,:);
            C_diff_5(row,:) = C1(index5(row),:)-C_8PSK_rep(row,:);
            C_diff_6(row,:) = C1(index5(row),:)-C_16PSK_rep(row,:);
        end
Cluster_error(1) = sum(sum(C_diff_1.^2,2).^0.5)/constel_pow;
Cluster_error(2) = sum(sum(C_diff_2.^2,2).^0.5)/constel_pow;
Cluster_error(3) = sum(sum(C_diff_3.^2,2).^0.5)/constel_pow;
Cluster_error(4) = sum(sum(C_diff_4.^2,2).^0.5)/constel_pow;
Cluster_error(5) = sum(sum(C_diff_5.^2,2).^0.5)/constel_pow;
Cluster_error(6) = sum(sum(C_diff_6.^2,2).^0.5)/constel_pow;

%% Classification
Threshold = 0.09;
for i = 1:6
    if Cluster_error(i)< Threshold
        outcome(i) = 1;
    end
end;    
