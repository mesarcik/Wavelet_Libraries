%% RMSE: function description
function [rmse] = RMSE_1(s1,s2)
	% s1 = abs(s1); s2 = abs(s2);

	if (length(s1) ~= length(s2))
		rmse = -1e6
	else
		rmse = sqrt(mean((s1 - s2).^2));
	end
end