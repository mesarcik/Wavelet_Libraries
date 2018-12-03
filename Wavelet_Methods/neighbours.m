%% neighbours: function description
function [values] = neighbours(coef,n)
	values =[];
	for i = 1:length(coef)
		if(i<=n) || ( i >=(length(coef)-n)) %at the beginging or end
			if(coef(i) > 0)
				values = [values, 1];
			else 
				values = [values, 0];
			end
		else
			if(coef(i) == 0 )
				bool = 0;
				for j = -n:n
					if(coef(i+j) >0)
						bool = 1;
					end
				end
				if bool ==1
					values = [values,1];
				else 
					values = [values, 0];
				end
			else 
				values = [values,1];
			end

		end
	end
end
	
