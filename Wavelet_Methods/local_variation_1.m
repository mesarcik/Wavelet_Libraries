%% local_variation: function description
function [V] = local_variation_1(wavelet)
	V = 0;
	for n = 1:length(wavelet)
			if (n == 1)
				V = V + abs(wavelet(n));
			else 
				V = V + abs(wavelet(n) - wavelet(n-1));
			end
	end
end

	
