function [Roystest] = Roystest(X,alpha)
%ROYSTEST. Royston's Multivariate Normality Test. 
% It is well known that many multivariate statistical procedures call upon
% the assumption of multivariate normality (MVN). At least 50 different
% procedures have been proposed for this problem. Unfortunately, different
% conclusions about the MVN of a data set can be reached by different
% procedures (Mecklin and Mundfrom, 2005).
%
% The Shapiro-Wilk test (Shapiro and Wilk, 1965), is generally considered 
% to be an excellent test of univariate normality. It is only natural to 
% extend it to the multivariate case, as done by Royston (1982). Simulation
% results have show Royston’s test to have very good Type I error control
% and power against many different alternative distributions. Further, 
% Royston’s test involves a rather ingenious correction for the correlation
% between the variables in the sample.
%
% Royston’s (1983) marginal method first tests each of the p variates for
% univariate normality with a Shapiro-Wilk statistic, then combines the p
% dependent tests into one omnibus test statistic for multivariate
% normality. Royston transforms the p-Shapiro-Wilk statistics into what he
% claims is an approximately Chi-squared random variable, with e (1< e <p)
% degrees of freedom. The degrees of freedom are estimated by taking into
% account possible correlation structures between the original p test
% statistics. This test has been found to behave well when the sample size
% is small and the variates are relatively uncorrelated (Mecklin and
% Mundfrom, 2005).
%
% Let W_j denote the value of the Shapiro-Wilk statistic for the jth
% variable in a p-variate distribution. Then,
%
%            R_j = { pHi^-1 [1/2Phi{-((1 - W_j)^g - m)/s}] }^2 ,
%               
% where g, m,and s are calculated from polynomial approximations and Phi^-1
% and Phi(.) denotes, respectivelly, the inverse and standard normal cdf.
% If the data are MVN,
%                               _p _  
%                               \             
%                       H  =  e /_ _ R_j/p
%                               j=1   
%
% is approximately Chi-square distributed, where the equivalent degrees of
% freedom is,
%                     e = p/[1 + (p - 1) mC],
%
% where mC is an estimate of the average correlation among the R_j's. This
% Chi-square distribution is used to obtain the critical or P-value for the
% MVN test.
%
% This m-file has a function to generate the Shapiro-Wilk's W statistic 
% needed to feed the Royston's test for multivariate normality. It was
% taken from the Fortran Algorithm AS R94 (Royston, 1995) [URL address
% http://lib.stat.cmu.edu/apstat/181]. Here, we present both the options
% for the sample kurtosis type: 1) Shapiro-Francia for leptokurtic, and 
% 2) Shapiro-Wilk for the platykurtic ones. 
%
% Syntax: function Roystest(X,alpha) 
%      
% Inputs:
%      X - data matrix (Size of matrix must be n-by-p; data=rows,
%          indepent variable=columns) 
%  alpha - significance level (default = 0.05)
%
% Output:
%        - Royston's Multivariate Normality Test
%
% Example: From the Table 11.5 (Iris data) of Johnson and Wichern (1992,
%          p. 562), we take onlt the Isis setosa data to test if it has a 
%          multivariate normality distribution using the Doornik-Hansen
%          omnibus test. Data has 50 observations on 4 independent 
%          variables (Var1 (x1) = sepal length; Var2 (x2) = sepal width; 
%          Var3 (x3) = petal length; Var4 (x4) = petal width. 
%
%                      ------------------------------
%                        x1      x2      x3      x4       
%                      ------------------------------
%                       5.1     3.5     1.4     0.2     
%                       4.9     3.0     1.4     0.2     
%                       4.7     3.2     1.3     0.2     
%                       4.6     3.1     1.5     0.2     
%                       5.0     3.6     1.4     0.2     
%                       5.4     3.9     1.7     0.4     
%                        .       .       .       .      
%                        .       .       .       .      
%                        .       .       .       .      
%                       5.1     3.8     1.6     0.2     
%                       4.6     3.2     1.4     0.2     
%                       5.3     3.7     1.5     0.2     
%                       5.0     3.3     1.4     0.2     
%                      ------------------------------
%
% Total data matrix must be:
% You can get the X-matrix by calling to iris data file provided in
% the zip as 
%          load path-drive:iriset 
% 
% Calling on Matlab the function: 
%          Roystest(X)
%
% Answer is:
%
% Royston's Multivariate Normality Test
% -------------------------------------------------------------------
% Number of variables: 4
% Sample size: 50
% -------------------------------------------------------------------
% Royston's statistic: 31.518027
% Equivalent degrees of freedom: 3.923160
% P-value associated to the Royston's statistic: 0.000002
% With a given significance = 0.050
% Data analyzed do not have a normal distribution.
% -------------------------------------------------------------------
%
% Created by A. Trujillo-Ortiz, R. Hernandez-Walls, K. Barba-Rojo, 
%             and L. Cupul-Magana
%             Facultad de Ciencias Marinas
%             Universidad Autonoma de Baja California
%             Apdo. Postal 453
%             Ensenada, Baja California
%             Mexico.
%             atrujo@uabc.mx
%
% Copyright. November 20, 2007.
%
% To cite this file, this would be an appropriate format:
% Trujillo-Ortiz, A., R. Hernandez-Walls, K. Barba-Rojo and
%   L. Cupul-Magana. (2007). Roystest:Royston's Multivariate Normality Test.   
%   A MATLAB file. [WWW document]. URL http://www.mathworks.com/
%   matlabcentral/fileexchange/loadFile.do?objectId=17811
%
% References:
% Johnson, R.A. and Wichern, D. W. (1992). Applied Multivariate Statistical
%      Analysis. 3rd. ed. New-Jersey:Prentice Hall.
% Mecklin, C.J. and Mundfrom, D.J. (2005). A Monte Carlo comparison of the
%      Type I and Type II error rates of tests of multivariate normality.
%      Journal of Statistical Computation and Simulation, 75:93-107.
% Royston, J.P. (1982). An Extension of Shapiro and Wilk’s W Test for
%      Normality to Large Samples. Applied Statistics, 31(2):115–124.
% Royston, J.P. (1983). Some Techniques for Assessing Multivariate
%      Normality Based on the Shapiro-Wilk W. Applied Statistics, 32(2):
% Royston, J.P. (1992). Approximating the Shapiro-Wilk W-Test for non-
%      normality. Statistics and Computing, 2:117-119.
%      121–133.
% Royston, J.P. (1995). Remark AS R94: A remark on Algorithm AS 181: The W
%      test for normality. Applied Statistics, 44:547-551.
% Shapiro, S. and Wilk, M. (1965). An analysis of variance test for 
%      normality. Biometrika, 52:591–611.
%

if nargin < 2,
    alpha = 0.05; %default
end

if (alpha <= 0 || alpha >= 1),
    fprintf(['Warning: Significance level error; must be 0 <'...
        ' alpha < 1 \n']);
    return;
end

if nargin < 1,
    error('Requires at least one input argument.');
    return;
end

[n,p] = size(X);

if (n <= 3),
    error('n is too small.');
    return,
elseif (n >= 4) && (n <=11),
    x = n;
    g = -2.273 + 0.459*x;
    m = 0.5440 - 0.39978*x + 0.025054*x^2 - 0.0006714*x^3;
    s = exp(1.3822 - 0.77857*x + 0.062767*x^2 - 0.0020322*x^3); 
    for j = 1:p,
        W(j) = ShaWilstat(X(:,j));
        Z(j) = (-log(g - (log(1 - W(j)))) - m)/s;
    end
elseif (n >= 12) && (n <=2000),
    x = log(n);
    g = 0;
    m = -1.5861 - 0.31082*x - 0.083751*x^2 + 0.0038915*x^3;
    s = exp(-0.4803 -0.082676*x + 0.0030302*x^2);  
    for j = 1:p,
        W(j) = ShaWilstat(X(:,j));
        Z(j) = ((log(1 - W(j))) + g - m)/s;
    end
else
    error('n is not in the proper size range.'); %error('n is too large.');return,
    return,
end

for j = 1:p,
    R(j) = (norminv((normcdf( - Z(j)))/2))^2;
end

u = 0.715;
v = 0.21364 + 0.015124*(log(n))^2 - 0.0018034*(log(n))^3;
l = 5;
C = corrcoef(X); %correlation matrix
NC = (C.^l).*(1 - (u*(1 - C).^u)/v); %transformed correlation matrix
T = sum(sum(NC)) - p; %total
mC = T/(p^2 - p); %average correlation
e = p/(1 + (p - 1)*mC); %equivalent degrees of freedom
H = (e*(sum(R)))/p; %Royston's statistic
P = 1 - chi2cdf(H,e); %P-value

disp(' ')
disp('Royston''s Multivariate Normality Test')
disp('-------------------------------------------------------------------')
fprintf('Number of variables: %i\n', p);
fprintf('Sample size: %i\n', n);
disp('-------------------------------------------------------------------')
fprintf('Royston''s statistic: %3.6f\n', H);
fprintf('Equivalent degrees of freedom: %3.6f\n', e);
fprintf('P-value associated to the Royston''s statistic: %3.6f\n', P);
fprintf('With a given significance = %3.3f\n', alpha);
if P >= alpha;
    disp('Data analyzed have a normal distribution.');
else
    disp('Data analyzed do not have a normal distribution.');
end
disp('-------------------------------------------------------------------')

%-----------------------------------
function [W] = ShaWilstat(x)
%SHAWILTEST Shapiro-Wilk' W statistic for assessing a sample normality.
% This m-file is generating from the Fortran Algorithm AS R94 (Royston,
% 1995) [URL address http://lib.stat.cmu.edu/apstat/181]. Here we take only
% the procedure to generate the Shapiro-Wilk's W statistic, needed to feed
% the Royston's test for multivariate normality. Here, we present both the
% options for the sample kurtosis type: 1) Shapiro-Francia for leptokurtic,
% and 2) Shapiro-Wilk for the platykurtic ones. Do not assume that the
% result of the Shapiro-Wilk test is clear evidence of normality or non-
% normality, it is just one piece of evidence that can be helpful.
%
% Input:
%      x - data vector (3 < n < 5000)
%
% Output:
%      W - Shapiro-Wilk's W statistic
%
% Example: From the example given by Scholtz and Stephens (1987, p.922). We
% only take the data set from laboratory 1 of eight measurements of the
% smoothness of a certain type of paper:38.7,41.5,43.8,44.5,45.5,46.0,47.7,
% 58.0
%
% Data vector is:
%  x=[38.7,41.5,43.8,44.5,45.5,46.0,47.7,58.0];
%
% Calling on Matlab the function: 
%          W = ShaWilstat(x)
%
% Answer is:
%
% W = 0.8476
%
% Created by A. Trujillo-Ortiz, R. Hernandez-Walls, K. Barba-Rojo, 
%             and L. Cupul-Magana
%             Facultad de Ciencias Marinas
%             Universidad Autonoma de Baja California
%             Apdo. Postal 453
%             Ensenada, Baja California
%             Mexico.
%             atrujo@uabc.mx
%
% Copyright. November 18, 2007.
%
% Reference:
% Scholz, F.W. and Stephens, M.A. (1987), K-Sample Anderson-Darling Tests.
%     Journal of the American Statistical Association, 82:918-924.
%

x  =  x(:); %put data in a column vector
n = length(x); %sample size

if n < 3,
   error('Sample vector must have at least 3 valid observations.');
end

if n > 5000,
    warning('Shapiro-Wilk statistic might be inaccurate due to large sample size ( > 5000).');
end

x = sort(x); %sorting of data vector in ascending order
m = norminv(((1:n)' - 3/8) / (n + 0.25));
w = zeros(n,1); %preallocating weights

if kurtosis(x) > 3, %Shapiro-Francia test is better for leptokurtic samples
    w = 1/sqrt(m'*m) * m;
    W = (w' * x) ^2 / ((x - mean(x))' * (x - mean(x)));
else %Shapiro-Wilk test is better for platykurtic samples
    c = 1/sqrt(m' * m) * m;
    u = 1/sqrt(n);
    p1 = [-2.706056,4.434685,-2.071190,-0.147981,0.221157,c(n)];
    p2 = [-3.582633,5.682633,-1.752461,-0.293762,0.042981,c(n-1)];

    w(n) = polyval(p1,u);
    w(1) = -w(n);

    if n == 3,
        w(1) = 0.707106781;
        w(n) = -w(1);
    end

    if n >= 6,
        w(n-1) = polyval(p2,u);
        w(2) = -w(n-1);
    
        ct =  3;
        phi = (m'*m - 2 * m(n)^2 - 2 * m(n-1)^2) / ...
                (1 - 2 * w(n)^2 - 2 * w(n-1)^2);
    else
        ct = 2;
        phi = (m'*m - 2 * m(n)^2) / (1 - 2 * w(n)^2);
    end

    w(ct:n-ct+1) = m(ct:n-ct+1) / sqrt(phi);

    W = (w' * x) ^2 / ((x - mean(x))' * (x - mean(x)));
end

return,