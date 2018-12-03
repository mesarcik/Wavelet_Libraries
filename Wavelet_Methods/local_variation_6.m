%% local_variation: function description
function [V] = local_variation_5(wavelet)
	V = 0;
	for n = 1:length(wavelet)
			if (n == 1)
				V = V + abs(wavelet(n));
			elseif (n == 2)
				V = V + abs(wavelet(n)- 6*wavelet(n-1));
			elseif (n == 3)
				V = V + abs(wavelet(n) -6*wavelet(n-1) + 15* wavelet(n-2));
			elseif (n == 4)
				V = V + abs(wavelet(n) -6*wavelet(n-1) + 15*wavelet(n-2) - 20*wavelet(n-3));
			elseif (n == 5)
				V = V + abs(wavelet(n) -6*wavelet(n-1) + 15*wavelet(n-2) - 20*wavelet(n-3) + 15*wavelet(n-4))  ;
			elseif (n == 6)
				V = V + abs(wavelet(n) -6*wavelet(n-1) + 15*wavelet(n-2) - 20*wavelet(n-3) + 15*wavelet(n-4) - 6*wavelet(n-5)) ;
			else
				V = V + abs(wavelet(n) -6*wavelet(n-1) + 15*wavelet(n-2) - 20*wavelet(n-3) + 15*wavelet(n-4) - 6*wavelet(n-5) + wavelet(n-6)) ;
			end
	end
end

	
