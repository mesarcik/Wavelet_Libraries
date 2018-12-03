%% RMSE: function description
function [PRD] = PRD(s1,s2)
	% s1 = abs(s1); s2 = abs(s2);

	if (length(s1) ~= length(s2))
		PRD = -1e6
	else
		PRD = sqrt(sum((s1 - s2).^2)/sum((s1).^2));
	end
end