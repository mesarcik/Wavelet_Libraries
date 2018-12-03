%% adaptive_threshold: function description
function [thresh] = adaptive_threshold(coef)
	if(max(abs(coef)) < (rms(abs(coef))+ mean(abs(coef))))
		thresh = max(abs(coef))/2;
	elseif ((rms(abs(coef)) + mean(abs(coef))) <=max(abs(coef)) )&&(max(abs(coef)) < 10e3) 
		thresh = max(abs(coef))/5;
	elseif 10e3 <= max(abs(coef))
		thresh = max(abs(coef))/10;
	end
end
			
