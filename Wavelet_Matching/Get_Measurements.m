%% Get_Measurements: Gets RMSE and INR of each wavelet
function [wavelet_INR,wavelet_RMSE,wavelet_H,INR_wavelet_INR,INR_wavelet_RMSE,RMSE_wavelet_INR,RMSE_wavelet_RMSE,H_wavelet_INR,H_wavelet_RMSE] ...
		 = Get_Measurements(name,signal,noise,Fs,Ha,Hb,Hc,RMSEa,RMSEb,RMSEc,INRa,INRb,INRc,n,offset,MF_ARC,MF_SSR,MF_DME,threshold_type,data_path)


%in this case signal is the noise and noise is the inteference
signal_noise = noise+signal;
threshold_bool 		= 	false;
coef 	 			=   coef16_2(INRa,INRb,INRc);
[s,wavelet_INR]  	= 	cascade(n,sqrt(2)*coef(3,:),sqrt(2)*coef(4,:));	
% figure; plot(wavelet_INR); title([name, ' INR Wavelet'])
Lo_D 				=   coef(1,:);
Hi_D 				=   coef(2,:);
Lo_R 				=   coef(3,:);
Hi_R 				=   coef(4,:);
[recovered] 		= 	DWT(signal,signal+noise,1,Lo_D,Hi_D,Lo_R,Hi_R,threshold_bool,name,n,threshold_type,1,offset+60);
[IC_noise,IC_RFI] 	= 	IC(signal,noise,signal_noise - recovered,recovered);
INR_wavelet_INR 	=	IC_RFI; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
INR_wavelet_RMSE	=   RMSE(signal,recovered);		
save([data_path,num2str(name),'_Matched_Wavelet_Similarity'],'Lo_D','Hi_D','Lo_R','Hi_R');

coef 	 			=   coef16_2(RMSEa,RMSEb,RMSEc);
[s,wavelet_RMSE]  	= 	cascade(n,sqrt(2)*coef(3,:),sqrt(2)*coef(4,:));	
% figure; plot(wavelet_RMSE); title([name, ' RMSE Wavelet'])
Lo_D 				=   coef(1,:);
Hi_D 				=   coef(2,:);
Lo_R 				=   coef(3,:);
Hi_R 				=   coef(4,:);
[recovered] 		= 	DWT(signal,signal+noise,1,Lo_D,Hi_D,Lo_R,Hi_R,threshold_bool,name,n,threshold_type,1,offset+40);
[IC_noise,IC_RFI] 	= 	IC(signal,noise,signal_noise - recovered,recovered);
RMSE_wavelet_INR 	=	IC_RFI;
RMSE_wavelet_RMSE	=   RMSE(signal,recovered);		
save([data_path,num2str(name),'_Matched_Wavelet_RMSE'],'Lo_D','Hi_D','Lo_R','Hi_R');

coef 	 			=   coef16_2(Ha,Hb,Hc);
[s,wavelet_H]  		= 	cascade(n,sqrt(2)*coef(3,:),sqrt(2)*coef(4,:));	
% figure; plot(wavelet_H); title([name, ' H Wavelet'])
Lo_D 				=   coef(1,:);
Hi_D 				=   coef(2,:);
Lo_R 				=   coef(3,:);
Hi_R 				=   coef(4,:);
[recovered] 		= 	DWT(signal,signal+noise,1,Lo_D,Hi_D,Lo_R,Hi_R,threshold_bool,name,n,threshold_type,1,offset+20);
[IC_noise,IC_RFI] 	= 	IC(signal,noise,signal_noise - recovered,recovered);
H_wavelet_INR 		=	IC_RFI;
H_wavelet_RMSE		=   RMSE(signal,recovered);	

disp(sprintf('%s INR Wavelet INR = \t %d RMSE = \t %d ',num2str(name),INR_wavelet_INR,INR_wavelet_RMSE))
disp(sprintf('%s RMSE Wavelet INR = \t %d RMSE = \t %d ',num2str(name),RMSE_wavelet_INR,RMSE_wavelet_RMSE))
disp(sprintf('%s H Wavelet INR = \t %d RMSE = \t %d ',num2str(name),H_wavelet_INR,H_wavelet_RMSE))

save([data_path,num2str(name),'_Matched_Wavelet_H'],'Lo_D','Hi_D','Lo_R','Hi_R');

[inr,rmse,H_signal_Similarity,H_matched_Similarity] = Best_Wavelet(MF_ARC,num2str(name),'Similarity',Fs,n,threshold_type,101012,0)
[inr,rmse,H_signal_RMSE,H_matched_RMSE] = Best_Wavelet(MF_ARC,num2str(name),'RMSE',Fs,n,threshold_type,1010123,0)
[inr,rmse,H_signal_H,H_matched_H] = Best_Wavelet(MF_ARC,num2str(name),'H',Fs,n,threshold_type,10101234,0)

wnames  =   {'haar'                                       ...
              ,'db1','db2','db3','db4','db5','db6','db7','db8','db9','db10'           ...
              ,'coif1','coif2','coif3','coif4','coif5'                      ...
              ,'sym1','sym2','sym3','sym4','sym5','sym6','sym7','sym8','sym9','sym10'       ...
              ,'dmey' ...
              ,'custom'};
H_names = {'Similarity', 'RMSE', 'H'};

[H_matched_min_m,H_matched_min_i]  = min([H_matched_Similarity H_matched_RMSE H_matched_H]);
[H_min_m,H_min_i]  = min(H_signal_H);

[H_min_temp_m,H_min_temp_i] = min([H_min_m H_matched_min_m]);
if min(H_min_temp_i == 1)% normal library wavelets
	[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(char(wnames(H_min_i)));
	[s,w] = cascade(n,sqrt(2)*Lo_R,sqrt(2)*Hi_R); 
	figure; plot(w); title('Final Wavelet')
	save([data_path,num2str(name),'_Wavelet'],'Lo_D','Hi_D','Lo_R','Hi_R');
else %MAtched wavetls 
	load([data_path,num2str(name),'_Matched_Wavelet_',num2str(char(H_names(H_matched_min_i)))])
	save([data_path,num2str(name),'_Wavelet'],'Lo_D','Hi_D','Lo_R','Hi_R');
	[s,w] = cascade(n,sqrt(2)*Lo_R,sqrt(2)*Hi_R); 
	figure; plot(w); title('Final Wavelet')
end

