function [Hypothesis,time] = norm_test(signal,alpha)


%% Jarque-Bera test
tic
[h,p] = jbtest(signal, alpha);               
toc;
time(1)=toc;
% alpha is the significance level in the range of [0.001,0.50]
% scatterplot(Y2)
Hypothesis(1) = h;

%% One-sample Kolmogorov-Smirnov test
tic
[h,p] = kstest(signal, [], alpha);
toc;
time(2)=toc;
%The Kolmogorov-Smirnov test requires that CDF be predetermined. It is not
%accurate if CDF is estimated from the data. To test x against a normal distribution 
%without specifying the parameters, use lillietest instead.
Hypothesis(2) = h;

%% Lilliefors test
tic
[h,p] = lillietest(signal, alpha, 'norm');
toc;
time(3)=toc;
Hypothesis(3) = h;

%% Z test
% The result of the test is returned in h. h = 1 indicates a rejection of the null hypothesis at the 5% 
% significance level. h = 0 indicates a failure to reject the null hypothesis at the 5% significance level.
% [h(4),p(4)] = ztest(signal, 0, 1)

%% T test
% performs a t-test of the null hypothesis that data in the vector x are a random sample from a normal 
% distribution with mean 0 and unknown variance, against the alternative that the mean is not 0. The result 
% of the test is returned in h. h = 1 indicates a rejection of the null hypothesis at the 5
% significance level. h = 0 indicates a failure to reject the null hypothesis at the 5% significance level.
% [h(5),p(5)] = ttest(signal)

%% Chi-square
% performs a chi-square goodness-of-fit test of the default null hypothesis
% that the data in vector x are a random sample from a normal distribution with mean and 
% variance estimated from x, against the alternative that the data are not normally 
% distributed with the estimated mean and variance. The result h is 1 if the null hypothesis 
% can be rejected at the 5% significance level. The result h is 0 if the null hypothesis cannot 
% be rejected at the 5% significance level.
tic
[h,p] = chi2gof(signal);
toc;
time(4)=toc;
Hypothesis(4) = h;

%% Shapiro-Wilk
tic
[h,p] = swtest(signal, alpha, 1);
toc;
time(5)=toc;
Hypothesis(5) = h;

%% Anderson-Darling
tic
h = AnDartest(signal, alpha);
toc;
time(6)=toc;
Hypothesis(6) = h;

%% D'Agostino-Pearson
tic
h = DagosPtest(signal, alpha);
toc;
time(7)=toc;
Hypothesis(7) = h;

%% Cramer-von Mises
tic
h = mtest(signal', alpha);
toc;
time(8)=toc;
Hypothesis(8) = h;

%% Giannakis-Tsatsanis

