%%  hard_thresh(coef,T): Input vector to be hard thresholdeed to threshold T.

function vals = hard_thresh(coef,T)
	vals = [];
	for i = 1:length(coef)
		if(abs(coef(i)) <= T)
			vals = [vals 0];
		end
		if(coef(i) > T)
			vals =  [vals coef(i)];
		end
		if(coef(i) < -T)
			vals =  [vals coef(i)];
		end
	end
	% vals = max(abs(coef) - T, 0);
	% vals = vals./(vals+T) .* coef;
end