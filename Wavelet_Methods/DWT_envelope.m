function [recovered] = DWT_envelope(X,XN,T,Lo_D,Hi_D,Lo_R,Hi_R,plot_bool,wname,n,threshold_type,threshold_bool,offset,neigh,window)
	addpath(('/home/misha/Google Drive/Masters/Project/MATLAB_Test_Scripts/2018/Wavelet_Methods /'));
	[c_,d_] = afb(XN,Lo_D,Hi_D);
	c = {(c_)};
	d = {(d_)};
	entropies= [2^(entropy(d{1,:}))/length(d{1,:})];
	non_normalized_entropies= [entropy(d{1,:})];
	disp(['Mean of Level: 1 = ' ,num2str(mean(d{1,:}))])
	for i = 2:n
		[c{i,:},d{i,:}] = afb(cell2mat(c(i-1,:)),Lo_D,Hi_D);
		% disp(['Standard Deviation of Level: ',num2str(i),' = ' ,num2str(std(d{i,:}))])
		disp(['Mean of Level: ',num2str(i),' = ' ,num2str(mean(d{i,:}))])
		entropies = [entropies,2^(entropy(d{i,:}))/length(d{i,:})];
		non_normalized_entropies= [non_normalized_entropies entropy(d{i,:})];
	end


	
	T = [];
	[m,i]=min(entropies);
	entropies
	non_normalized_entropies
	if((threshold_bool) )
		d_t = {0};
		envelope = {0};
		for (i = 1:n)
			if (round(mean(d{i,:}),2) ~= 0 )
				T = [T max([abs(max(d{i,:})) abs(min(d{i,:}))])];
			else		
				T = [T sqrt(2)*(median(abs(d{i,:} - median(d{i,:}))))/(0.6745)];
			end
			if (threshold_type == 'soft')
				d_t{i,:} = (soft_thresh(d{i,:},T(end)));
				envelope{i,:} =  neighbours(d_t{i,:},neigh);
			else
				d_t{i,:} = (hard_thresh(d{i,:},T(end)));
				envelope{i,:} =  neighbours(d_t{i,:},neigh);
			end
		end
	else
		d_t = d;
		T = zeros(1,n);
	end

	

	if((threshold_bool) && (round(mean(d{i,:}),2) == 0 ))
	% get the ranges of the RFI and create a window
		[m,index] = min(entropies);
		len = length(d{index,:});
		indicies = []; count =1;
		temp = envelope{index,:};
		for i = 1:length(temp) -1
			if(abs(( temp(i) - temp(i+1) )) ==1 )
				indicies(count) = i;
				count = count +1;
			end 
		end
		envelopes = {0};
		for i = 1:n
			mult = (index-i);
			temp=ones(1,length(d{i,:}));
			for j = 1:2:(length(indicies)-1)
				% start = ceil(indicies(j)*2^mult)
				% stop = ceil((indicies(j+1))*2^mult)
				temp(ceil(indicies(j)*2^mult):ceil((indicies(j+1))*2^mult)) =0;
			end
			envelopes{i,:} = temp;

		end
		for i = 1:size(envelopes,1);
			% size_d = size(d{i,:})
			% size_env = size(envelopes{i,:})
			if (window)
				d_t{i,:} = d{i,:}.*window_fn(envelopes{i,:});
			else 
				d_t{i,:} = d{i,:}.*(envelopes{i,:});
			end

		end

	else
		[envelopes{1:n,1}] = deal(zeros(1,n));
	end
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
		

	if(plot_bool)
		figure(offset +1); 
		for (i = 1:n)
			subplot(n,1,i); hold on; plot(d{i,:});plot(window_fn(envelopes{i,:}));plot((envelopes{i,:})) ;  title(['Decomposition with detail coeficient ' , num2str(i)]); 
		end		%
	end



	if(plot_bool && threshold_bool)
		figure(offset +2);    
		for (i =1:n)
			subplot(n,1,i);plot(d_t{i,:}); title(['Decomposition with detail coeficient d', num2str(i), ' with a ',num2str(threshold_type),' threshold of ' , num2str(T(i))])
		end	  
    end

	recovered = sfb(c{n,:},d_t{n,:},Lo_R,Hi_R);
	for (i = n-1:-1:1)
		recovered =	sfb(recovered,d_t{i,:},Lo_R,Hi_R);
	end

	if(plot_bool )
		h =figure(offset +3); subplot(4,1,1); plot(((X))); title('Clean signal with scaled wavelets added')
				subplot(4,1,2); plot(((XN))); title('Noisey signal with scaled wavelets added')
				subplot(4,1,3); plot(((recovered))); title(['Denoised Reconstructed Signal using rigrsure with ', wname])
				subplot(4,1,4); plot(((XN - recovered))); title(['Denoised Reconstructed Signal using rigrsure with ', wname])
		h =figure(offset +4); hold on; plot(mag2db(abs(fft(recovered)))); plot(mag2db(abs(fft(XN)))); title('Frequency spectrum');
			    legend('RFI Supressed Signal','Origial')

		pause(1);
	
	end

end