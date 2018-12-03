%% 4_coef: function description
function [ret] = coef6(a,b)
	temp    =	 [];
	c 		=	 pi/4 -a -b;
	o 		=	 6;
	temp(1)  =   cos(a) * cos(b) * cos(c);
	temp(2)  =   sin(c) * cos(b) * cos(a);
	temp(3)  =  -sin(a+c) * sin(b);
	temp(4)  =   cos(a+c) * sin(b);
	temp(5)  =  -sin(a) * cos(b) * sin(c);
	temp(6)  =   cos(c) * cos(b) * sin(a);

	h0 		 =  temp;
	h1 		 =  (-((-1).^(1:o)).*(fliplr(h0(end,:))));
	f0 		 =  sqrt(2)*(-((-1).^(1:o)).*(h1(end,:)));
	f1 		 =  sqrt(2)*(((-1).^(1:o)).*(h0(end,:)));
	ret = [f0;f1];
end		