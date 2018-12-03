function [d] = DWT_anal(XN,Lo_D,Hi_D,Lo_R,Hi_R,n)
	addpath(('/home/misha/Google Drive/Masters/Project/MATLAB_Test_Scripts/2018/Wavelet_Methods'));
	[c_,d_] = afb(XN,Lo_D,Hi_D);
	c = {(c_)};
	d = {(d_)};
	for i = 2:n
		[c{i,:},d{i,:}] = afb(cell2mat(c(i-1,:)),Lo_D,Hi_D);
	end
	r = {d,c{end,:}};
	
		
end