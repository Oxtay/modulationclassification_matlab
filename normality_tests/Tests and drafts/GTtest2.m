function [h, d_G, t] = GTtest2(x)

T = length(x);
M = T^.4;
sumelements  = zeros(1,T);
cum4_1       = zeros(1,ceil(M));
t_G          = 8000;        % Threshold
for eta = 1 : ceil(M)
    tic
    for t = eta+1 : T-eta
        sumelements(t) = -x(t).^2.*x(t+eta).*x(t-eta) - x(t).^4;
    end;
    t = toc;
    cum4_1(eta) = 1/T*sum(sumelements);
end;
d_G = cum4_1 * cov(cum4_1)^-1 * cum4_1';

if d_G <= t_G;
   h = 0;
else
   h = 1; 
end
return,