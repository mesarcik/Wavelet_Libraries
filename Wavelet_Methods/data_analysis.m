function [s_f_smooth] = avg(RTI)
		s_f 				= 		[];
		s_f_smooth 			= 		[];
				
		for i = 1:size(RTI,2)-9
			s_f 			=		[s_f;abs(((RTI(:,i))))];
		end

		for j = 1:size(s_f,2)
			s_f_smooth(j) 	=		mean(s_f(:,j));
		end
end