%% INR: gets INR using inner product method for 2 signals s1 and s2
function [inr] = INR(noise,inteference,Fs)
	inr =  mean(periodogram(inteference,[],length(inteference),Fs))/mean(periodogram(noise,[],length(noise),Fs));
end
