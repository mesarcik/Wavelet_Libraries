function [lo, hi] = afb(x, Lo_D,Hi_D)

% [lo, hi] = afb(x, af)
%
% Analysis filter bank
% x -- N-point vector (N even); the resolution should be 2x filter length
%
% af  -- analysis filters
% af(:, 1): lowpass filter (even length)
% af(:, 2): highpass filter (even length)
%
% lo: Low frequency
% hi: High frequency
%
	str = 'afb: This is the length of lo and hi %d';
	N = length(x);
	L = length(Lo_D)/2;
	x = cshift(x,-L);

	% lowpass filter
	lo = upfirdn(x, Lo_D, 1, 2);
	lo(1:L) = lo(N/2+[1:L]) + lo(1:L);
	lo = lo(1:N/2);
	% sprintf(str, length(lo))

	% highpass filter
	hi = upfirdn(x, Hi_D, 1, 2);
	hi(1:L) = hi(N/2+[1:L]) + hi(1:L);
	hi = hi(1:N/2);

end