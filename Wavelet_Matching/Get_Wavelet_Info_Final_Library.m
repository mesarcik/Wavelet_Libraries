%% Get_Wavelet_Info: a fucntion that takes in a signal and noise and gets respective entropy, SIR, rmse for each wavelet in libraries
function [wavelets] = Get_Wavelet_Info_Final_Library(model,noise,Fs,n,threshold_type,data_path)

	load([data_path,'/Final_Library.mat']);

	%Simulation Parameters
	
	% n = 3;
	threshold_bool = 1; 
	plot_bool = 0;
	% threshold_type = 'hard';
	offset = 1010101;

	H_signal_ 						=	[];
	H_signal3D 						= 	[];
	inr_temp						=	[];
	rmse_temp						=	[];
	signal_noise = noise+model;
	for j = 1:length(perfect_wavelets_V)
		coef 	 					=   coef16_2(perfect_wavelets_a(j),perfect_wavelets_b(j),perfect_wavelets_c(j));
		d_signal 					= 	DWT_anal(model,coef(1,:),coef(2,:),coef(3,:),coef(4,:),n);
		[recovered] 				= 	DWT(model,(model+noise),1,coef(1,:),coef(2,:),coef(3,:),coef(4,:),plot_bool,'custom',n,threshold_type,threshold_bool,1234+offset);
    	% recovered 					=   (model+noise) - recovered;
    	[IC_noise,IC_RFI] 			= 	IC(noise,model,signal_noise - recovered,recovered);
    	inr_temp 					=   [inr_temp IC_RFI];
    	rmse_temp 					=   [rmse_temp RMSE(noise,(model+noise) - recovered)];
		
		for j = 1:length(d_signal)
			H_signal_ 				= 	[H_signal_,d_signal{j,:}];%
		end		
		H_signal3D 					= 	[H_signal3D,(2^(entropy(H_signal_))/length(H_signal_))];%2^(entropy(H_signal_))/length(H_signal_)
		H_signal_ 					=	[];;

	end	
	[b_signal,i_signal] 			= 	min(H_signal3D);
	wavelets.H						=	b_signal;
	wavelets.Ha						= 	perfect_wavelets_a(i_signal);
	wavelets.Hb						= 	perfect_wavelets_b(i_signal);
	wavelets.Hc						= 	perfect_wavelets_c(i_signal);
	[b_signal,i_signal] 			= 	min(rmse_temp);
	wavelets.RMSE					= 	b_signal;
	wavelets.RMSEa					= 	perfect_wavelets_a(i_signal);
	wavelets.RMSEb					= 	perfect_wavelets_b(i_signal);
	wavelets.RMSEc					= 	perfect_wavelets_c(i_signal);
	[b_signal,i_signal] 			= 	max(inr_temp);
	wavelets.INR					= 	b_signal;
	wavelets.INRa					= 	perfect_wavelets_a(i_signal);
	wavelets.INRb					= 	perfect_wavelets_b(i_signal);
	wavelets.INRc					= 	perfect_wavelets_c(i_signal);
			
	

end