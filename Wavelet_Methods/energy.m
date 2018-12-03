%% energy: function description
function [E] = energy(C)
	% C is the 2D matrix of the wvelet coefficients
	E = 0;
	for i = 1:length(C)
		E = E + abs(C(i))^2;
	end
end
