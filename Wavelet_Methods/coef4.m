%% 4_coef: function description
function [temp] = coef4(a)
	temp 			   =		[];
	b  				   =		pi/4 -a;
	temp(1) 		   =		 cos(a)*cos(b);
	temp(2) 		   =		 sin(a)*cos(b);
	temp(3) 		   =		-sin(a)*sin(b);
	temp(4) 		   =		 cos(a)*sin(b);
end		