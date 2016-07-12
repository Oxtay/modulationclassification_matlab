function [] = progress(varargin)

persistent t;
if t,
	prog_sym = ['-', '\', '|', '/'];
	p = varargin{1};
	if p > 100,
		p = 100;
	end
	fprintf('\b\b\b\b\b\b%3d%% %c', p, prog_sym(t));
	t = mod(t, 4) + 1;
else
	t = 1;
end

