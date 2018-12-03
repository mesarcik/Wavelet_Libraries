%% scale_to_wave: function description
function w = scale_to_wave(s,HI_R)
	w = [];
	for t = 1:length(s)
		temp = 0;
		% t
		for n = 1: length(HI_R)
			try 
				temp = temp + HI_R(n)*sqrt(2)*s((2*t) -n);
			catch 
				continue
			end
			
		end
		w = [w temp];
		% t
	end
end
	
