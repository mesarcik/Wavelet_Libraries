function [inde,hh,d,recovered] = DWT_3rd(X,XN,T,Lo_D,Hi_D,Lo_R,Hi_R,plot_bool,wname,n,threshold_type,threshold_bool,offset)
	addpath(('/home/misha/Google Drive/Masters/Project/MATLAB_Test_Scripts/2018/Wavelet_Methods /'));
	[c_,d_] = afb(XN,Lo_D,Hi_D);
	c = {(c_)};
	d = {(d_)};
	H = [2^(entropy(d{1,:}))/length(d{1,:})];
	E = [sum(abs(d{1,:}).^2)];
	for i = 2:n
		[c{i,:},d{i,:}] = afb(cell2mat(c(i-1,:)),Lo_D,Hi_D);
		H = [H 2^(entropy(d{i,:}))/length(d{i,:})];
		E = [E sum(abs(d{i,:}).^2)];
	end


	% E
	% H
	[m,inde] = max(E);
	hh =H(inde);
% return

	T = [];
	if(threshold_bool)
		d_t = {0};
		for (i = 1:n)
			T = [T sqrt(2)*(median(abs(d{i,:} - median(d{i,:}))))/(0.6745)];
			% if i ==1 || i ==2 || i ==3
			% 	d_t{i,:} = d{i,:};
			% else 
			% 	d_t{i,:} = zeros(1,length(d{i,:}));
				
			% end
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
			subplot(n,1,i); hold on; plot(d{i,:}); plot(-T(i)*ones(1,length(d{i,:})));plot(T(i)*ones(1,length(d{i,:}))); title(['Decomposition with detail coeficient ' , num2str(i)]); 
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
				subplot(4,1,1); plot(mag2db(abs(XN))); title('Noisey signal with scaled wavelets added')
				subplot(4,1,2); plot(mag2db(abs(recovered))); title(['Denoised Reconstructed Signal using rigrsure with ', wname])
				subplot(4,1,3); plot(mag2db(abs(XN - recovered))); title(['Denoised Reconstructed Signal using rigrsure with ', wname])
				subplot(4,1,4); plot(abs(fft(recovered))); title(['Denoised Reconstructed Signal using rigrsure with ', wname ,' that is in the frequency domina.'])
		pause(1);
	
	end

end