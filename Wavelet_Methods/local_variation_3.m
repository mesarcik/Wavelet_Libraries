%% local_variation: function description
function [V] = local_variation_3(wavelet)
	V = 0;
	for n = 1:length(wavelet)
			if (n == 1)
				V = V + abs(wavelet(n));
			elseif (n == 2)
				V = V + abs(wavelet(n) - 3*wavelet(n-1));
			elseif (n == 3)
				V = V + abs(wavelet(n) -3*wavelet(n-1) +3* wavelet(n-2));
			else
				V = V + abs(wavelet(n) -3*wavelet(n-1) + 3*wavelet(n-2) - wavelet(n-3));
			end
	end
end

	
