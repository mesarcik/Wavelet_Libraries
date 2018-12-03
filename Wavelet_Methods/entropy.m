%% entropy: function description
% function [E] = entropy(C)
% 	E = 0;
% 	for i = 1:length(C)
% 		E = E + (abs(C(i))^2/energy(C))*log2(abs(C(i))^2/(energy(C)));
% 	end
% 	E = -E;
% end

%According to masters
% entropy: function description
function [E] = entropy(b)
	E = 0;
	for i = 1:length(b)
		temp =  (abs(b(i))^2/(norm(b)^2))*log2(abs(b(i))^2/(norm(b)^2));
		if isnan(temp)
			temp = 0;
		end
		E = E +temp;
	end
	E = -E;
end


