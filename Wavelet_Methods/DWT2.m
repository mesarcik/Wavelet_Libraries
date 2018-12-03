function [recovered] = DWT2(X,XN,T,Lo_D,Hi_D,Lo_R,Hi_R,plot_bool,wname)
	% if(plot_bool)
	% 	figure;  subplot(2,1,1); plot((X)); xlabel('Samples'); ylabel('Amplitude'); title('Clean signal');
	% 			    subplot(2,1,2); plot(mag2db((abs(fft(X))))); xlabel('Frequency'); ylabel('|Magnitude|'); 
	% 			    % subplot(4,1,3); plot(XN); xlabel('Samples'); ylabel('Amplitude'); title('Noisy signal');
	% 			    % subplot(4,1,4); plot(real(fftshift(fft(XN)))); xlabel('Frequency'); ylabel('|Magnitude|');
	% end

	[c1,d1]		=				afb(XN,Lo_D,Hi_D);
	[c2,d2] 	=				afb(c1,Lo_D,Hi_D);
	[c3,d3]		=				afb(c2,Lo_D,Hi_D);
	[c4,d4]		=				afb(c3,Lo_D,Hi_D);
	[c5,d5]		=				afb(c4,Lo_D,Hi_D);

	if(plot_bool)
		figure   ; subplot(5,1,1); plot(d1); title('Decomposition with detail coeficient d1'); 
				   subplot(5,1,2); plot(d2); title('Decomposition with detail coeficient d2'); 
				   subplot(5,1,3); plot(d3); title('Decomposition with detail coeficient d3');
				   subplot(5,1,4); plot(d4); title('Decomposition with detail coeficient d4');
				   subplot(5,1,5); plot(d5); title('Decomposition with detail coeficient d5');
		% figure   ; subplot(5,1,1); plot(mag2db(abs(d1))); title('Decomposition with detail coeficient d1'); 
		% 		   subplot(5,1,2); plot(mag2db(abs(d2))); title('Decomposition with detail coeficient d2'); 
		% 		   subplot(5,1,3); plot(mag2db(abs(d3))); title('Decomposition with detail coeficient d3');
		% 		   subplot(5,1,4); plot(mag2db(abs(d4))); title('Decomposition with detail coeficient d4');
		% 		   subplot(5,1,5); plot(mag2db(abs(d5))); title('Decomposition with detail coeficient d5');
	end
	
	% temp			=				sfb2(c5  ,d5,Lo_R,Hi_R);
	% temp			=				sfb2(temp,d4,Lo_R,Hi_R);
	% temp			=				sfb2(temp,d3,Lo_R,Hi_R);
	% temp			=				sfb2(temp,d2,Lo_R,Hi_R);
	% temp			=				sfb2(temp,d1,Lo_R,Hi_R);
	% if(plot_bool)	
	% 	figure(7); plot(temp); title('Reconstructed Signal')
	% end

	d1_t 		= 			soft_thresh(d1,T);
	d2_t 		= 			soft_thresh(d2,T);
	d3_t		= 			soft_thresh(d3,T);
	d4_t 		= 			soft_thresh(d4,T);
	d5_t		= 			soft_thresh(d5,T);
	if(plot_bool)
		figure; subplot(5,1,1);    plot(d1_t); title('Decomposition with detail coeficient d1 Thresholded')
				   subplot(5,1,2); plot(d2_t); title('Decomposition with detail coeficient d2 Thresholded')
				   subplot(5,1,3); plot(d3_t); title('Decomposition with detail coeficient d3 Thresholded')
				   subplot(5,1,4); plot(d4_t); title('Decomposition with detail coeficient d4 Thresholded')
				   subplot(5,1,5); plot(d5_t); title('Decomposition with detail coeficient d5 Thresholded')
    end

	recovered		    =				sfb(c5,  d5_t,Lo_R,Hi_R);
	recovered			=				sfb(recovered,d4_t,Lo_R,Hi_R);
	recovered			=				sfb(recovered,d3_t,Lo_R,Hi_R);
	recovered			=				sfb(recovered,d2_t,Lo_R,Hi_R);
	recovered			=				sfb(recovered,d1_t,Lo_R,Hi_R);

	if(plot_bool)
		h =figure; subplot(3,1,1); plot(((X))); title('Clean signal with scaled wavelets added')
				subplot(3,1,2); plot(((XN))); title('Noisey signal with scaled wavelets added')
				subplot(3,1,3); plot(((recovered))); title(['Denoised Reconstructed Signal using rigrsure with ', wname])
		% pause(1);
		% close(h)
				
				   % subplot(2,1,2); plot(real(fftshift(fft(recovered)))); title('Denoised Reconstructed Signal using threshold_1'); xlim([1 512])
	end

end