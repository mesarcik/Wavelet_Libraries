%% moving_median: This fucntion returns a moving median of the input data (x) and window size (n)
function [output] = moving_median(x,n)
	output = [];
	if(length(x) > n)
		for i = 1:(length(x)+n-1)
			if (i -n <= 0) %Start Border
				output = [output median(x(1:i))];
			elseif (i > length(x)) %End border
				output = [output median(x(i-n+1:end))];	
			elseif (i>n) %In the middle
				output = [output median(x(i-n+1:i))];
			end
		end
	end
end
