%% local_variation: function description
function [V] = local_variation_4(wavelet)
	V = 0;
	for n = 1:length(wavelet)
			if (n == 1)
				V = V + abs(wavelet(n));
			elseif (n == 2)
				V = V + abs(wavelet(n) - 4*wavelet(n-1));
			elseif (n == 3)
				V = V + abs(wavelet(n) -4*wavelet(n-1) + 6* wavelet(n-2));
			elseif (n == 4)
				V = V + abs(wavelet(n) -4*wavelet(n-1) + 6*wavelet(n-2) - 4*wavelet(n-3));
			else
				V = V + abs(wavelet(n) -4*wavelet(n-1) + 6*wavelet(n-2) - 4*wavelet(n-3) + wavelet(n-4))  ;
			end
	end
end

	
