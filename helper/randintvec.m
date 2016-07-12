function randnumber = randintvec(n,symsize)
% written by: Okhtay Azarmanesh
% A simple code to generate random integer vectors to be used in feeds for
% different modulators using different schemes
% randnumber = floor(rand(n,1)*symsize);
randnumber = randi(symsize,n,1)-1;