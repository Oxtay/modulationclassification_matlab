% Written by Okhtay Azarmanesh, 
% February 11, 2011
% Part of the research on Modulation Classification

% Carrier Frequency Offset          range = [-1, 1]
% Frame Time Offset                 range = [-1, 1]
% Sampling Clock Offset             range = [-1, 1]
% I-Q Fain Imbalance                range = [-0.2, 0.2]
% I-Q Phase Imbalance               range = [-0.2, 0.2]
% I-Q Differential time             range = [-0.2, 0.2]
% ==============================================
clear all;
close all;
offset = 0.1; %Percentage of Offset/100
imbalance = 0.2; %Percentage of Imbalance/100
figure('Units','characters','Position',[30 5 130 50]);

%Without any offset
D_offset = [0,0,0,0,0,0];
figure(1); subplot(2,2,1)
OFDM_offset_zeroremoval(D_offset);
title('(a) OFDM Signal')
xlabel('I'); ylabel('Q');

%Carrier Frequency Offset
D_offset = [offset,0,0,0,0,0];
figure(1); subplot(2,2,2)
OFDM_offset_zeroremoval(D_offset);
% OFDM_offset_clustering(D_offset);
title('(b) With Carrier Frequency Offset')
xlabel('I'); ylabel('Q');

%Frame Time Offset
D_offset = [0,offset,0,0,0,0];
figure(1); subplot(2,2,3);
OFDM_offset_zeroremoval(D_offset);
% OFDM_offset_clustering(D_offset);
title('(c) With Frame Time Offset')
xlabel('I'); ylabel('Q');

%Sampling Clock Offset
D_offset = [0,0,offset,0,0,0];
figure(1); subplot(2,2,4);
OFDM_offset_zeroremoval(D_offset);
% OFDM_offset_clustering(D_offset);
title('(d) With Sampling Clock Offset')
xlabel('I'); ylabel('Q');

% ====================== I-Q imbalances ===================
figure('Units','characters','Position',[30 5 130 50]);

%Without any offset
D_offset = [0,0,0,0,0,0];
figure(2); subplot(2,2,1)
OFDM_offset_zeroremoval(D_offset);
title('(a) OFDM Signal')
xlabel('I'); ylabel('Q');

%I-Q Gain Imbalance
D_offset = [0,0,0,imbalance,0,0];
figure(2); subplot(2,2,2)
OFDM_offset_zeroremoval(D_offset);
% OFDM_offset_clustering(D_offset);
title('(b) With I-Q Gain Imbalance')
xlabel('I'); ylabel('Q');

%I-Q Phase Imbalance
D_offset = [0,0,0,0,imbalance,0];
figure(2); subplot(2,2,3)
OFDM_offset_zeroremoval(D_offset);
% OFDM_offset_clustering(D_offset);
title('(c) With I-Q Phase Imbalance')
xlabel('I'); ylabel('Q');

%I-Q Differential time
D_offset = [0,0,0,0,0,imbalance];
figure(2); subplot(2,2,4)
% OFDM_offset_clustering(D_offset);
OFDM_offset_zeroremoval(D_offset);
title('(d) With I-Q Differential Time')
xlabel('I'); ylabel('Q');

% %Carrier Frequency Offset with zeros removed
% D_offset = [0.05,0,0,0,0,0];
% figure(8)
% OFDM_offset_zeroremoval(D_offset);
% title('Algorithm Performance With Carrier Frequency Offset')
