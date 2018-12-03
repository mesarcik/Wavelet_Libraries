%Get_Wavelet_Final_Library: Define a data path to associate wavelets with some signals matched using entropy based methods
clear all; close all; clc;
addpath(('../Wavelet_Methods'));

%Params
data_path = ''; % Where data is stored
Fs = 1800000000;
n =8;
threshold_type = 'soft';

%GET Models 
RFI_files = dir(fullfile([data_path, '*.mat']));
MF_files  = dir(fullfile([data_path, '*.mat']));
mfs  = {}; MFs  = {}; MFs_f  = {};  mfs_noise ={};  MFs_noise ={};  MFs_noise_f ={};  
rfis = {}; RFIs = {}; RFIs_f = {}; 
for i = 1:length(MF_files)
	load([data_path, RFI_files(i).name])
	load([data_path, MF_files(i).name])
	n_ceil = pow2(ceil(log2(length(mf))));
	mf = transpose([zeros(1,(n_ceil/2)) mf' zeros(1,(n_ceil/2))]);
	mfs{i} = mf'; rfis{i} = rfi;
	[f,psd] = PSD(mf,Fs);
	MFs{i}  =psd ; MFs_f{i}  =f ;
	[f,psd] = PSD(rfi,Fs);
	RFIs{i} =psd ; RFIs_f{i} = f;
	%determine the noise
	mfs_noise{i} = wgn(1,length(mf),-5);
	[f,psd] = PSD((mfs_noise{i} + mfs{i}),Fs);
	MFs_noise{i} = psd;  MFs_noise_f{i} = f;
end	


wavelets = {};

for i = 1:length(RFIs)
	figure(i); %subplot(3,2,1); plot(rfis{i}); title(['RFI ',num2str(i),' in the Time Domain'],'Interpreter','latex');
			   %subplot(3,2,2); plot(RFIs_f{i},RFIs{i}); title(['RFI ',num2str(i),' in the Frequency Domain'],'Interpreter','latex');
   			   subplot(2,2,1); plot(mfs{i}); title(['MF ',num2str(i),' in the Time Domain'],'Interpreter','latex');
			   subplot(2,2,2); plot(MFs_f{i},MFs{i}); title(['MF ',num2str(i),' in the Frequency Domain'],'Interpreter','latex');
			   subplot(2,2,3); plot((mfs_noise{i} + mfs{i})); title(['MF ',num2str(i),' with -30dB of Noise in the Time Domain'],'Interpreter','latex');
			   subplot(2,2,4); plot(MFs_noise_f{i},MFs_noise{i}); title(['MF ',num2str(i),' with -30dB of Noise in the Frequency Domain'],'Interpreter','latex');
    pause(1);
	disp(['Getting ', num2str(i),' Wavelet'])
	wavelet = Get_Wavelet_Info_Final_Library(mfs{i},mfs_noise{i},Fs,n,threshold_type,data_path);
	wavelets{i} = wavelet;
	[ARC_wavelet_INR,ARC_wavelet_RMSE,ARC_wavelet_H,ARC_INR_wavelet_INR,ARC_INR_wavelet_RMSE,ARC_RMSE_wavelet_INR,ARC_RMSE_wavelet_RMSE,ARC_H_wavelet_INR,ARC_H_wavelet_RMSE] ...
	 = Get_Measurements(num2str(i),mfs_noise{i},mfs{i},Fs,wavelets{i}.Ha,wavelets{i}.Hb,wavelets{i}.Hc,wavelets{i}.RMSEa,wavelets{i}.RMSEb,wavelets{i}.RMSEc,wavelets{i}.INRa,wavelets{i}.INRb,wavelets{i}.INRc,n,10,mfs{i},mfs{i},mfs{i},threshold_type,data_path);
	close all;
end

