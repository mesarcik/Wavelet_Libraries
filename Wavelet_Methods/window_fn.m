%% window_fn: function description
function [out] = window_fn(vec)
	ones_vector = [];
	zeros_vector = [];
	out = [];
	change = NaN;
	for i = 1:length(vec)

		if (i == 1)
			if (vec(i) == 0)
				change = 0;
				zeros_vector = [zeros_vector -1];
			else 
				change = 1;
				ones_vector = [ones_vector 1];
			end
		else
			if (vec(i) == 0)
				 zeros_vector = [zeros_vector -1];
				 if change == 1
				 	change =0;
				 	out = [out ones_vector];
				 	ones_vector = [];
				 end
			else 
				ones_vector = [ones_vector 1];
				if change == 0
					change =1 ;
					% i 
					% length(zeros_vector)
					out = [out (1- kaiser(length(zeros_vector)))'];
					zeros_vector = [];
				end
			end
		end
	end
	% size_neg = length(zeros_vector)
	% size_neg_ham = size(hamming(length(zeros_vector))')
	% size_one = size(ones_vector)
	if length(zeros_vector)~=0,	out = [out (1- kaiser(length(zeros_vector)))'];,end;
 	out = [out ones_vector];

 	% for i = 1:length(out)
 	% 	if (out(i) < 0)
 	% 		out(i) = 0;
 	% 	end
 	% end


end



