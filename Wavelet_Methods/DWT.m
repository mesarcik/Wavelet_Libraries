%[recovered] = DWT(X,XN,Thresh,Lo_D,Hi_D,Lo_R,Hi_R,plot_bool,wname,n,threshold_type,threshold_bool,offset)
function [recovered] = DWT(X,XN,Thresh,Lo_D,Hi_D,Lo_R,Hi_R,plot_bool,wname,n,threshold_type,threshold_bool,offset)
	[c_,d_] = afb(XN,Lo_D,Hi_D);
	c = {(c_)};
	d = {(d_)};
	H = [2^(entropy(d{1,:}))/length(d{1,:})];
	E = [sum(abs(d{1,:}).^2)];
	M = [mean((d{1,:}))];
	S = [std((d{1,:}))];
	for i = 2:n
		[c{i,:},d{i,:}] = afb(cell2mat(c(i-1,:)),Lo_D,Hi_D);
		H = [H 2^(entropy(d{i,:}))/length(d{i,:})];
		E = [E sum(abs(d{i,:}).^2)];
		M = [M mean((d{i,:}))];
		S = [S mean((d{i,:}))];
	end

	T 			   = [];
	Tc 			   = 0;

	if(threshold_bool)
		d_t = {0};
		c_t = {0};
		for (i = 1:n)
			if Thresh == -1 
				T = [T sqrt(2*log10(length(d{i,:})))*(median(abs(d{i,:} - median(d{i,:}))))/(0.6745)]; %*log10(length(d{i,:}))
				Tc = sqrt(2)*(median(abs(c{n,:} - median(c{n,:}))))/(0.6745);
			else
				t				= 		thselect(d{i,:},Thresh);
				T = [T t];
			end

			if (threshold_type == 'soft')
				d_t{i,:} = (soft_thresh(d{i,:},T(end)));
			else
				d_t{i,:} = (hard_thresh(d{i,:},T(end)));
			end
		end
	else
		d_t = d;
		T = zeros(1,n);
	end
		   
	if(plot_bool)
		figure(offset +1); 
		for (i = 1:n)
			subplot(n,1,i); hold on; plot(d{i,:}); plot(-(T(i))*ones(1,length(d{i,:})));plot((T(i))*ones(1,length(d{i,:}))); title(['Decomposition with detail coeficient ' , num2str(i)]); 
		end	
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

	if(plot_bool && threshold_bool)
		h =figure(offset +3); 
				temp = fft(XN - recovered);
				subplot(2,2,1); plot(((X))); title('Original Interfernce Waveform');
				subplot(2,2,2); plot(((XN-X))); title('Original Signal Waveform');
				subplot(2,2,3); plot(((XN - recovered))); title(['Denoised Reconstructed Signal with ', wname])
				subplot(2,2,4); plot(((recovered))); title(['Denoised Reconstructed Inteference with ', wname])
		pause(1);
	
	end

end