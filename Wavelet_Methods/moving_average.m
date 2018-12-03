%% moving_average: This fucntion returns a moving average of the input data (x) and window size (n)
% function [output] = moving_average(x,n)
% 	output = [];
% 	if(length(x) > n)
% 		for i = 1:(length(x)+n-1)
% 			if (i -n <= 0) %Start Border
% 				output = [output mean(x(1:i))];
% 			elseif (i > length(x)) %End border
% 				output = [output mean(x(i-n+1:end))];	
% 			elseif (i>n) %In the middle
% 				output = [output mean(x(i-n+1:i))];
% 			end
% 		end
% 	end
% end
% moving_average: This fucntion returns a moving average of the input data (x) and window size (n)
function [output] = moving_average(x,n)
	output = [];
	if(length(x) > n)
		for i = 1:(length(x)+n-1)
			if (i -n <= 0) %Start Border
				% output = [output mean(x(1:i))];
			elseif (i > length(x)) %End border
				% output = [output mean(x(i-n+1:end))];	
			elseif (i>n+1) %In the middle
				output(i - n/2 +1) = mean(x(i-n:i));
			end
		end
	end
end
