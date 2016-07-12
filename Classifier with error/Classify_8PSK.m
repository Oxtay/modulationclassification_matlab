function outcome = Classify_8PSK(SNR)
K       = 8;
outcome = zeros(1,6);
n       = 512;      % Number of samples

% 16-QAM The default combination of constellation 16-QAM
C_16QAM = [-3 -3;-3 -1;3 1;1 -1;1 1;-3 1;3 -1;-1 -1;-1 1;-1 -3;1 -3;3 -3;-3 3;-1 3;1 3;3 3]; 

% 8-QAM  The default combination of constellation 8-QAM
C_8QAM  = [-3 -1;3 1;1 -1;1 1;-3 1;3 -1;-1 -1;-1 1];

% 4-QAM  The default combination of constellation 4-QAM
C_4QAM  = [1 1;-1 1;1 -1;-1 -1;1 1;-1 1;1 -1;-1 -1];

% 64-QAM 
C_QAM = zeros(sqrt(64),sqrt(64));
for i = 1:sqrt(64)
    for j = 1:sqrt(64)
        C_QAM(i,j) = (2*(i-sqrt(64)/2)-1)+1i*(2*(j-sqrt(64)/2)-1);
    end
end
D       = [real(C_QAM) imag(C_QAM)];
C_64QAM = reshape(D,64,2);


% 16-PSK
for i = 1:16
    C_PSK(i)=exp(2*1i*pi*(i-1)/16);
end;
C_16PSK = [real(C_PSK);imag(C_PSK)]';
% 8-PSK 
for i = 1:8
    C_psk(i)=exp(2*1i*pi*(i-1)/8);
end;
C_8PSK = [real(C_psk);imag(C_psk)]';

%
constel_pow = sum(sum(C_8PSK.^2,2).^0.5);
[~, C1] = FindCCenterPSK(SNR,n,K);
        
index1 = knnsearch(C1,C_8PSK);
index2 = knnsearch(C1,C_4QAM);
index3 = knnsearch(C1,C_8QAM);
index4 = knnsearch(C1,C_16QAM);
index5 = knnsearch(C1,C_16PSK);
index6 = knnsearch(C1,C_64QAM);
        for row = 1:length(C1)
            C_diff_1(row,:) = C1(index1(row),:)-C_8PSK(row,:);
            C_diff_2(row,:) = C1(index2(row),:)-C_4QAM(row,:);
            C_diff_3(row,:) = C1(index3(row),:)-C_8QAM(row,:);
            C_diff_4(row,:) = C1(index4(row),:)-C_16QAM(row,:);
            C_diff_5(row,:) = C1(index5(row),:)-C_16PSK(row,:);
            C_diff_6(row,:) = C1(index6(row),:)-C_64QAM(row,:);
        end
Cluster_error(1) = sum(sum(C_diff_1.^2,2).^0.5)/constel_pow;
Cluster_error(2) = sum(sum(C_diff_2.^2,2).^0.5)/constel_pow;
Cluster_error(3) = sum(sum(C_diff_3.^2,2).^0.5)/constel_pow;
Cluster_error(4) = sum(sum(C_diff_4.^2,2).^0.5)/constel_pow;
Cluster_error(5) = sum(sum(C_diff_5.^2,2).^0.5)/constel_pow;
Cluster_error(6) = sum(sum(C_diff_6.^2,2).^0.5)/constel_pow;

%% Classification
Threshold = 0.2;
for i = 1:6
    if Cluster_error(i)< Threshold
        outcome(i) = 1;
    end
end;    
