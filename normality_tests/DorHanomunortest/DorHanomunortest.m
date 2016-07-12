function [DorHanomunortest] = DorHanomunortest(X,alpha)
%DORHANOMNORTEST. Doornik-Hansen Omnibus Multivariate (Univariate) Normality Test.
% Doornik-Hansen (1994) introduce a multivariate version of the univariate
% omnibus test for normality of Shenton and Bowman (1977), based on the
% transformed skewness and kurtosis. Due that the skewness and kurtosis are
% not independently distributed and the kurtosis approaches very slowly to
% normality, they propose a test assuming independence of skewness and 
% kurtosois. The kurtosis is less convenient for it is conditional to more
% than 1 + skewness, and with a gamma distribution. So, they suggest to 
% transform them to create statistics much closer to standard normal. Where
% the transformation for the skewness is as in D'Agostino (1970), and the
% kurtosis is tranformed from a gamma to a Chi-square distribution using 
% the Wilson-Hilferty cubed root transformation, which then is translated
% into standard normal.
%
% Using the correlation matrix (makes the test scale invariant) and the 
% diagonal matrix of reciprocals of the p standard deviations, a 
% multivariate normal can thus be transformed into independent standard
% normals as,
%
%                         st = Z*V*L^(-1/2)*V';
%
% where: Z is the standardized (normalized) data matrix
%        V is the eigenvectors matrix
%        L is the eigenvalues diagonal matrix [L^(-1/2) gives invariance to
%        ordering]
%
% The skewness is transformed using the D'Agostino procedure, and the
% kurtosis is transformed from a gamma distribution to a chi-square. The
% the Doornik-Hansen statistic is,
%
%                          DH = z1*z1' + z2*z2'
%
% and it approximates to a chi-square with 2p degrees of freedom.
%
% If the rank of the correlation matrix is less than p, some eigenvalues
% will be zero. In that case the following procedure can be used. Select
% the eigenvectors corresponding to the p* non-nonzero eigenvalues, G say,
% and create a new data matrix X* = GX. This will be an n x p* matrix. Now
% compute DH using X* and base the tests on p* degrees of freedom.
%
% We can test a multivariate or univariate normal distribution.
%
% Syntax: function DorHanomunortest(X,alpha) 
%      
% Inputs:
%      X - data matrix (Size of matrix must be n-by-p; data=rows,
%          indepent variable=columns) 
%  alpha - significance level (default = 0.05)
%
% Output:
%        - Doornik-Hansen Omnibus Multivariate (Univariate) Normality Test
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
%          DorHanomunortest(X)
%
% Answer is:
%
% Doornik-Hansen Omnibus Multivariate (Univariate) Normality Test
% -------------------------------------------------------------------
% Number of variables: 4
% So, it is a multivariate case.
% Sample size: 50
% -------------------------------------------------------------------
% Asymptotic statistic: 22.2470
% P-value associated to the asymptotic statistic: 0.0045
% With a given significance = 0.050
% Data analyzed do not have a normal distribution.
% -------------------------------------------------------------------
% Omnibus Doornik-Hansen statistic: 24.4145
% P-value associated to the Omnibus Doornik-Hansen statistic: 0.0020
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
% Copyright.November 10, 2007.
%
% To cite this file, this would be an appropriate format:
% Trujillo-Ortiz, A., R. Hernandez-Walls, K. Barba-Rojo and L. Cupul-Magana
% (2007). DorHanomunortest:Doornik-Hansen Omnibus Multivariate (Univariate)
% Normality Test. A MATLAB file. [WWW document]. URL http://www.mathworks.com/
% matlabcentral/fileexchange/loadFile.do?objectId=17530
%
% References:
% Doornik, J. A. and Hansen, H. (1994), An omnibus test for univariate and
%      multivariate normality. Discussion Paper W4&91. Nuffield College,
%      Oxford, UK.
% D'Agostino, R. B. (1970), Transformation to normality of the null 
%      distribution of g1. Biometrika, 57:679-681.
% Shenton, L. R. and Bowman, K. O. (1977), A bivariate model for the 
%      distribution of sqrt(b)1 and b2. J. Am. Statist. Ass., 72:206-211.
%

switch nargin
    case{2}
        if isempty(X) == false && isempty(alpha) == false
            if (alpha <= 0 || alpha >= 1)
                fprintf(['Warning: Significance level error; must be 0 <'...
                    ' alpha < 1 \n']);
                return;
            end
        end
    case{1}
        alpha = 0.05;
    otherwise 
        error('Requires at least one input argument.');
end

[n,p] = size(X);
pi = p;

R = corrcoef(X);

[V L] = eig(R);

L(find(L <= 1e-12)) = 0;
L(find(L > 1e-12)) = 1.0./sqrt(L(find(L > 1e-12)));

if (rank(R) < p);
    G = V(:,any(L~=0));
    X = X*G;
    p = size(X,2);
    disp(' ');
    disp(['NOTE:Due that some eigenvalue resulted zero, a new data' ...
        ' matrix was created.']);
    disp(['Initial number of variables = ' num2str(pi) ', were reduced'...
        ' to = ' num2str(p) '']);
    R = corrcoef(X);
    [V L] = eig(R);
else
end

Z = (X - repmat(mean(X),n,1))./repmat(std(X,1),n,1);

%Transformation of the skewness by the D'Agostino procedure   
st = Z*V*L*V';
sk = mean(st.^3);
ku = mean(st.^4);
n2 = n.^2;
b = 3*(n2 + 27*n - 70)*(n + 1)*(n + 3)/((n - 2)*(n + 5)*(n + 7)*(n + 9));
w2 = -1 + sqrt(2*(b - 1));
d = 1/sqrt(log(sqrt(w2)));
y = sk*sqrt((w2 - 1)*(n + 1)*(n + 3)/(12*(n - 2)));
z1 = d*log(y + sqrt(y.^2 + 1)); %transformed skewness

%Transformation of kurtosiss from a gamma distribution to a chi-square
d = (n - 3)*(n + 1)*(n2 + 15*n - 4);
a = (n - 2)*(n + 5)*(n + 7)*(n2 + 27*n - 70)/(6*d);
c = (n - 7)*(n + 5)*(n + 7)*(n2 + 2*n - 5)/(6*d);
k = (n + 5)*(n + 7)*(n*n2 + 37*n2 + 11*n - 313) / (12*d);  
al = a + sk.^2*c;
chi = (ku - 1 - sk.^2)*k*2;
chi = abs(chi);
z2 = (((chi./(2*al)).^(1/3)) - 1 + 1./(9*al)).*sqrt(9*al); %transformed
                                                           %kurtosis
ku = ku - 3;
DH = z1*z1' + z2*z2'; %omnibus normality statistic
AS = n/6*sk*sk' + n/24*ku*ku'; %asymptotic statistic
v = 2*p; %degrees of freedom
PO = 1 - chi2cdf(DH,v);
PA = 1 - chi2cdf(AS,v);

disp(' ')
disp('Doornik-Hansen Omnibus Multivariate (Univariate) Normality Test')
disp('-------------------------------------------------------------------')
fprintf('Number of variables: %i\n', p);
if p == 1;
    disp('So, it is an univariate case.'),
else (p > 1);
        disp('So, it is a multivariate case.'),
end
fprintf('Sample size: %i\n', n);
disp('-------------------------------------------------------------------')
fprintf('Asymptotic statistic: %3.4f\n', AS);
fprintf('P-value associated to the asymptotic statistic: %3.4f\n', PA);
fprintf('With a given significance = %3.3f\n', alpha);
if PA >= alpha;
    disp('Data analyzed have a normal distribution.');
else
    disp('Data analyzed do not have a normal distribution.');
end
disp('-------------------------------------------------------------------')
fprintf('Omnibus Doornik-Hansen statistic: %3.4f\n', DH);
fprintf('P-value associated to the Omnibus Doornik-Hansen statistic: %3.4f\n', PO);
fprintf('With a given significance = %3.3f\n', alpha);
if PO >= alpha;
    disp('Data analyzed have a normal distribution.');
else
    disp('Data analyzed do not have a normal distribution.');
end
disp('-------------------------------------------------------------------')

return,