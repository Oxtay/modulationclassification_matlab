function [h, d_G] = GTtest(x)

% alpha = 2; %default significance level
T = length(x);
M = T^.4;

sumelements  = zeros(1,T);
cum4_1       = zeros(1,ceil(M));
t_G          = 4.2*10^4;        % Threshold
for eta = 1 : ceil(M)
%     for t = 1:T-eta
%         sumelements(t) = -x(t).^2.*x(t+eta).^2 - x(t).^4;
% %       sumelements_3(t) = -x_2(t).^2.*x_2(t+eta).^2 - x_2(t).^4;
%     end;
    for t = eta+1 : T-eta
        sumelements(t) = -x(t).^2.*x(t+eta).*x(t-eta) - x(t).^4;
%       sumelements_3(t) = -x_2(t).^2.*x_2(t+eta).^2 - x_2(t).^4;
    end;
        cum4_1(eta) = 1/T*sum(sumelements);
end;
d_G = cum4_1 * cov(cum4_1)^-1 * cum4_1';

%% Normalizing the vectors
% N = SAMP_MAX/100;
% for i = 1:N
%     d_G_norm(:,i) = d_G_ave(:,i)/norm(d_G_ave(:,i));
% end

if d_G <= t_G;
   h = 0;
else
   h = 1; 
end
return,