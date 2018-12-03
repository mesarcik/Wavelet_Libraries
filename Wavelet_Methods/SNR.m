%% SNR: function description
function [SNR_recovered,SNR_orig,SNR_gain] = SNR(v_clean,v_noisey,recovered)
	SNR_recovered				=	(mean(PSD(v_clean))/mean(PSD(v_clean - recovered)))^2;
	SNR_orig					=	(mean(PSD(v_clean))/mean(PSD(v_clean - v_noisey)))^2;
	SNR_gain 					= 	( (SNR_recovered) - (SNR_orig));
end
