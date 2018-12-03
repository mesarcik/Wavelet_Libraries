function [ret] = coef16_o(a,b,c)
	d = pi/4 - a -b -c;
	o = 16;
	temp 	 = [];
	temp(1)  =  cos(a) * cos(b) * cos(c) * cos(d);
	temp(2)  =	sin(a) * cos(b) * cos(c) * cos(d);
	temp(3)  = -cos(a) * cos(b) * sin(c) * sin(d);
	temp(4)  = -sin(a) * cos(b) * sin(c) * sin(d);
	temp(5)  = -cos(a) * sin(b) * sin(c) * cos(d);
	temp(6)  = -sin(a) * sin(b) * sin(c) * cos(d);
	temp(7)  = -cos(a) * sin(b) * cos(c) * sin(d);
	temp(8)  = -sin(a) * sin(b) * cos(c) * sin(d);
	temp(9)  = -sin(a) * sin(b) * cos(c) * cos(d);
	temp(10) =  cos(a) * sin(b) * cos(c) * cos(d);
	temp(11) =  sin(a) * sin(b) * sin(c) * sin(d);
	temp(12) = -cos(a) * sin(b) * sin(c) * sin(d);
	temp(13) = -sin(a) * cos(b) * sin(c) * cos(d);
	temp(14) =  cos(a) * cos(b) * sin(c) * cos(d);
	temp(15) = -sin(a) * cos(b) * cos(c) * sin(d);
	temp(16) =  cos(a) * cos(b) * cos(c) * sin(d);

	h0 		 =  temp;
	h1 		 =  (-((-1).^(1:o)).*(fliplr(h0(end,:))));
	f0 		 =  sqrt(2)*(-((-1).^(1:o)).*(h1(end,:)));
	f1 		 =  sqrt(2)*(((-1).^(1:o)).*(h0(end,:)));
	ret = [f0;f1];
end