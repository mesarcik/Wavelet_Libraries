function vals = soft_thresh(coef,T)
	vals = [];
	for i = 1:length(coef)
		if(abs(coef(i)) <= T)
			vals = [vals 1e-10];
		end
		if(coef(i) > T)
			vals =  [vals coef(i)-T];
		end
		if(coef(i) < -T)
			vals =  [vals coef(i)+T];
		end
	end
	% vals = max(abs(coef) - T, 0);
	% vals = vals./(vals+T) .* coef;
end