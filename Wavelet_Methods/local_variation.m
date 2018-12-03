%% local_variation: function description
function [V] = local_variation(wavelet)
	V = 0;
	for n = 1:length(wavelet)
			if (n == 1)
				V = V + abs(wavelet(n));
			elseif (n == 2)
				V = V + abs(wavelet(n) - 2*wavelet(n-1));
			else
				V = V + abs(wavelet(n) -2*wavelet(n-1) + wavelet(n-2));
			end
	end
end

	
