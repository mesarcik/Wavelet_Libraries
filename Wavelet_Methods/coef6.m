
%% 6_coef: function description
function [temp] = coef6(a,b)
	c = pi/4 -a -b;
	temp = [];
	temp(1)  =   cos(a) * cos(b) * cos(c);
	temp(2)  =   sin(c) * cos(b) * cos(a);
	temp(3)  =  -sin(a+c) * sin(b);
	temp(4)  =   cos(a+c) * sin(b);
	temp(5)  =  -sin(a) * cos(b) * sin(c);
	temp(6)  =   cos(c) * cos(b) * sin(a);
end