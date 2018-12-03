%% 4_coef: function description
function [ret] = coef4_o(a)
	temp 			   =		 [];
	b  				   =		 pi/4 -a;
	o 				   = 		 4;
	temp(1) 		   =		 cos(a)*cos(b);
	temp(2) 		   =		 sin(a)*cos(b);
	temp(3) 		   =		-sin(a)*sin(b);
	temp(4) 		   =		 cos(a)*sin(b);

	h0 		 =  temp;
	h1 		 =  (-((-1).^(1:o)).*(fliplr(h0(end,:))));
	f0 		 =  sqrt(2)*(-((-1).^(1:o)).*(h1(end,:)));
	f1 		 =  sqrt(2)*(((-1).^(1:o)).*(h0(end,:)));
	ret = [f0;f1];
end		