%% corr_coef: function description
function [r] = corr_coef(a,b)
	if (length(a) ~= length(b))
		r = -1
		return
	else
		temp_0 = 0;
		temp_1 = 0;
		temp_2 = 0;
		for i = 1:length(a)
			temp_0 = temp_0 + ((a(i) - mean(a))*(b(i) - mean(b)));
			temp_1 = temp_1 + (a(i) - mean(a))^2;
			temp_2 = temp_2 + (b(i) - mean(b))^2;
		end
		temp_1 = sqrt(temp_1);
		temp_2 = sqrt(temp_2);

		r = temp_0/(temp_1 *temp_2);
	end

end
