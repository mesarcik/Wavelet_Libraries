%% RMSE: function description
function [RMSE_recovered] = RMSE(v_clean,recovered)
	RMSE_recovered = sqrt(mean((v_clean - recovered).^2));
end