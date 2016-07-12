function Q=blocklocmax(S,E,ORV)
%BLOCKLOCMAX Columnwise local maximum search. 
%   Q = BLOCKLOCMAX(A,E) returns a matrix Q with the same size as matrix A.
%   Q contains ones where A has a local column maximum and has zeros otherwise.
%   A local column maximum is given by an element of A that is larger than or
%   equal to the E neighboring elements above and the E neighboring elements
%   below. The integer number E (with E >= 0) is called the observation horizon 
%   of the local maximum. The parameter E is optional. If E is omitted then
%   E = 1 is used. Note that BLOCKLOCMAX will mark all adjacent values in regions
%   that are locally maximal and flat (i.e. if neighboring values are the same).
%
%   Q = BLOCKLOCMAX(A,E,V) defines hypothetical elements before the first element
%   in each column and after the last element in each column to be of scalar value
%   V. An explicit definition of V influences the search for local maxima at the
%   beginning and at the end of each column (depending on the size of the obser-
%   vation horizon E). Parameter V is optional and defaults to NAN (i.e. ignores
%   outside elements) if omitted.
%
%   EXAMPLE: Z=abs(peaks(100)); Z=Z/max(abs(Z(:)));
%            Z=Z+blocklocmax(Z); imagesc(Z);
%            title('Local Column Extrema in the PEAKS Matrix');
%   
%   See also BLOCKCORR and BLOCKCONV.

%   Copyright (c) 2005 by Robert M. Nickel
%   $Revision: 1.0 $
%   $Date: 14-Apr-2005 $

%   File History/Comments:
%   created   14-Apr-2005 13:41:35 on MATLAB 5.3.1.29215a (R11.1) for PCWIN
%   modified  (N/A)

% check for optional arguments
if nargin<2; E=1; end
if nargin<3; ORV=nan; end;

% check for empty cases
if isempty(S); Q=[]; return; end

% check for single row case
if size(S,1)==1;
   if E<1;
      Q=ones(size(S));
   else
      Q=(S==max([ S ; repmat(ORV,1,length(S)) ],[],1));
   end
   return;
end

% extend horizon in both directions
EE=2*E+1; L=size(S,1); M=size(S,2);

% repeat entries and append outside elements
Q=cat(1,repmat(S,[1 1 EE]),repmat(ORV,[ EE M EE ]));

% string out the repetitions
Q=reshape(permute(Q,[ 1 3 2 ]),[ (L+EE)*EE M ]);

% reorder repetitions with a one sample offset
Q=reshape(Q(1:end-EE,:),[ L+EE-1 EE M ]);

% find maximum element in each interval and compare with current value
Q=(S==squeeze(max(Q(E+1:end-E,:,:),[],2)));
