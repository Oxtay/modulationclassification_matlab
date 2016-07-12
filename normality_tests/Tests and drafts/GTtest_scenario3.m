function [h, d_G] = GTtest_scenario3(x)

T            = length(x);
M            = T^.4;
sumelements  = zeros(1,T);
cum4         = zeros(1,ceil(M));
t_G          = 4000;        % Threshold
for eta = 1 : ceil(M)
    for t = eta+1 : T-eta
        sumelements(t) = -x(t).^2.*x(t+eta).*x(t-eta) - x(t).^4;
    end;
        cum4(eta) = 1/T*sum(sumelements);
end;
d_G = cum4 * cov(cum4)^-1 * cum4';

if d_G <= t_G;
   h = 0;
else
   h = 1; 
end
return,