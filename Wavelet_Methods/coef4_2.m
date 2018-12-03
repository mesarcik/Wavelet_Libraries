%% 4_coef: function description
function [ret] = coef4_2(a)
	temp 			   =		[];
	b  				   =		pi/4 -a;
	o 				   =		4;
	temp(1) 		   =		 cos(a)*cos(b);
	temp(2) 		   =		 sin(a)*cos(b);
	temp(3) 		   =		-sin(a)*sin(b);
	temp(4) 		   =		 cos(a)*sin(b);

	h0 		 =  fliplr(temp);
	h1 		 =  (-((-1).^(1:o)).*(fliplr(h0(end,:))));
	f0 		 =  (-((-1).^(1:o)).*(h1(end,:)));
	f1 		 =  (((-1).^(1:o)).*(h0(end,:)));
	ret = [h0;h1;f0;f1];
end		