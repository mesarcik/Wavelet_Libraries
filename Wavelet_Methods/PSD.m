%% PSD: gets PSD of a signal s with length L and sampling frequency F
function [s_f,s_PSD] = PSD(s,Fs)
	NFFT = length(s);
	L=length(s);                      % series length
	s_f = Fs/2*linspace(0,1,NFFT/2+1);  % single-sided positive frequency   
	X = fft(s);                     % normalized fft
	s_PSD=abs(X(1:L/2+1)); 	
end
