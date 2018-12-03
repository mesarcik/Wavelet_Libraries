%% IC: gets IC using inner product method for 2 signals s1 and s2
function [IC_noise,IC_RFI] = IC(noise,RFI,noise_r,RFI_r)
	IC_noise = dot(noise,noise_r);
	IC_RFI   = dot(RFI,RFI_r);
end
