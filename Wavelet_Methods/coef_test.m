function [sum_,fund_,orth_] = coef_test(h)
	sum_=[];fund_=[];orth_ =0;
	%%%%%%%%%%%%%%%%SUM_THEORM%%%%%%%%%%%%%%%%%%%%%%
	sum_ = sum(h);
	%%%%%%%%%%%%%%%%FUNDAMENTAL_THEORM%%%%%%%%%%%%%%
	h_odd 	=  h(1:2:end);          % Odd-Indexed Elements
	h_even 	=  h(2:2:end);         % Even-Indexed Elements
	fund_ 	=  [sum(h_odd) sum(h_even)];
	%%%%%%%%%%%%%%%%ORTHOGONALITY_THEROM%%%%%%%%%%%%
	for i = 1:length(h)
		orth_ = orth_ + abs(h(i))^2;
	end
end