function  chirp_pulse =  chirp(f0,t1,f1,fs)

	t = fs:fs:1;
	k = (f1-f0)/t1;

	chirp_pulse 	=				cos(2*pi*	(f0*t + 0.5*k*t.^2 )	);
	% size(chirp_pulse)
	% disp('fdsjfdsfsdfds sfds ')
end