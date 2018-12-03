%% Comparison: Compare the Standard library of wavelets to matched wavelet.
function [inr,rmse,H_signal,H_matched] = Comparison(model,wname,criteria,Fs,n,threshold_type,offset,data_path)
     inr = []; rmse = []; 
     matched_inr=[];matched_rmse = [];
     matched_IC_noise=[];matched_IC_RFI = [];
     IC_noise_ = []; IC_RFI_ = []; 
     plot_bool = 0;
     % n = 3;
     % threshold_type = 'soft';
     threshold_bool = 1;
     wnames  =   {'haar'                                       ...
              ,'db1','db2','db3','db4','db5','db6','db7','db8','db9','db10'           ...
              ,'coif1','coif2','coif3','coif4','coif5'                      ...
              ,'sym1','sym2','sym3','sym4','sym5','sym6','sym7','sym8','sym9','sym10'       ...
              ,'dmey' ...
              ,'custom'};

  for j = 1:5
      noise = wgn(1,length(model),-40);
      signal_noise = model + noise; 
      INR_temp = []; rmse_temp = []; 
      IC_noise_temp = []; IC_RFI_temp = []; 
     
      H_signal_  = []; H_signal = [];
      H_matched = [];
      
      for i = 1:length(wnames)-1
        	[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(char(wnames(i)));
        	[recovered]       = DWT(model,signal_noise,1,Lo_D,Hi_D,Lo_R,Hi_R,plot_bool,'custom',n,threshold_type,threshold_bool,1234+offset);
        	% recovered = signal_noise - recovered;
          [IC_noise,IC_RFI] = IC(noise,model,signal_noise - recovered,recovered);
          IC_noise_temp     = [IC_noise_temp IC_noise]; 
          IC_RFI_temp       = [IC_RFI_temp IC_RFI];

        	INR_temp          = [INR_temp IC_RFI];

        	rmse_temp         = [rmse_temp RMSE(noise,signal_noise - recovered)];
        	% psd = [psd;PSD(recovered)];
          d_signal          = DWT_anal(model,Lo_D,Hi_D,Lo_R,Hi_R,n);
          for j = 1:length(d_signal)
            H_signal_       = [H_signal_,d_signal{j,:}];%
          end   
          H_signal          = [H_signal,(2^(entropy(H_signal_))/length(H_signal_))];%2^(entropy(H_signal_))/length(H_signal_)
          H_signal_         = [];
      end
      load([data_path,wname,'_Matched_Wavelet_',criteria]);

      [recovered] = DWT(noise,signal_noise,1,Lo_D,Hi_D,Lo_R,Hi_R,plot_bool,'custom',n,threshold_type,threshold_bool,4141+offset);
      % recovered = signal_noise - recovered;
      [IC_noise,IC_RFI] = IC(noise,model,signal_noise - recovered,recovered);
      
      matched_IC_noise=[matched_IC_noise   IC_noise];
      matched_IC_RFI=[matched_IC_RFI   IC_RFI];

      matched_inr=[matched_inr   IC_RFI];
      matched_rmse = [matched_rmse RMSE(noise,signal_noise - recovered)]; 
      inr = [inr;INR_temp];
      rmse = [rmse;rmse_temp];
      IC_noise_ = [IC_noise_; IC_noise_temp]; 
      IC_RFI_ = [IC_RFI_; IC_RFI_temp]; 

      d_signal          = DWT_anal(model,Lo_D,Hi_D,Lo_R,Hi_R,n);
      for j = 1:length(d_signal)
        H_signal_       = [H_signal_,d_signal{j,:}];%
      end   
      H_matched          = [H_matched,(2^(entropy(H_signal_))/length(H_signal_))];

    end
    disp(['This is the size of the INR Vector: ' num2str(size(inr))])
    disp(['This is the size of the Match INR Vector: ' num2str(size(matched_inr))])
    inr               = mean(inr,1);
    rmse              = mean(rmse,1);
    IC_noise_         = mean(IC_noise_,1);
    IC_RFI_           = mean(IC_RFI_,1); 
    matched_inr       = mean(matched_inr);
    matched_rmse      = mean(matched_rmse);
    matched_IC_noise  = mean(matched_IC_noise);
    matched_IC_RFI    = mean(matched_IC_RFI);
    disp(['This is the size of the AVG INR Vector: ' num2str(size(inr))])
    disp(['This is the size of the AVG Match INR Vector: ' num2str(size(matched_inr))])

    [s,w] = cascade(n,sqrt(2)*Lo_R,sqrt(2)*Hi_R); 
    figure; subplot(2,1,1); plot(w); subplot(2,1,2); plot(abs(fft(w))); xlim([0 length(w)/2+1]);



    figure;[hAx,hLine1,hLine2] = plotyy(1:length(wnames),[IC_noise_ matched_IC_noise],1:length(wnames),[IC_RFI_ matched_IC_RFI]); xlabel('Wavelet'); grid on;
    set(gca, 'Xtick',1:length(wnames),'XTickLabel',wnames);
    ylabel(hAx(1),'Noise Correlation After Thresholding') % left y-axis 
    ylabel(hAx(2),'RFI Correlation After Thresholding') % right y-axis
    title(criteria)

    figure; plot([rmse matched_rmse]); xlabel('Wavelet'); grid on;
    set(gca, 'Xtick',1:length(wnames),'XTickLabel',wnames);
    ylabel('Root Mean Square Error') % left y-axis 
    title(criteria)

    figure; plot([H_signal H_matched]); grid on;ylabel('Normalized Entropy'); xlabel('Wavelet Type')
    set(gca, 'Xtick',1:length(wnames),'XTickLabel',wnames);
    title(criteria)

   
    [m,i] = max(inr);
    [Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(char(wnames(i)));
    [recovered] = DWT(model,signal_noise,1,Lo_D,Hi_D,Lo_R,Hi_R,1,char(wnames(i)),n,threshold_type,threshold_bool,1010+offset);
    load([Comparison,wname,'_Matched_Wavelet_',criteria]);
    [recovered] = DWT(model,signal_noise,1,Lo_D,Hi_D,Lo_R,Hi_R,1,criteria,n,threshold_type,threshold_bool,101010+offset);

