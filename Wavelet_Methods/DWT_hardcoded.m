function [recovered] = DWT_hardcoded(X,XN,T,Lo_D,Hi_D,Lo_R,Hi_R,plot_bool,wname,n,threshold_type,threshold_bool,offset)
	addpath(('/home/misha/Google Drive/Masters/Project/MATLAB_Test_Scripts/2018/Wavelet_Methods /'));
	[c_,d_] = afb(XN,Lo_D,Hi_D);
	c = {(c_)};
	d = {(d_)};
	for i = 2:n
		[c{i,:},d{i,:}] = afb(cell2mat(c(i-1,:)),Lo_D,Hi_D);
	end

	
	T = [];

	if(threshold_bool)
		d_t = {0};
		for (i = 1:n)
			H_norm = 2^(entropy(d{i,:}))/length(d{i,:})
			% if (i <5)
				% disp('True')
				% T = thselect(d{i,:},'rigrsure') 
				% i
				% if i ==2 
				% 	T = 0.005
				% else
				T = [T sqrt(2)*(median(abs(d{i,:} - median(d{i,:}))))/(0.6745)]
				std(d{i,:})
				% MAD = median(abs(d{i,:} - median(d{i,:})))
				% T(end)

				% end
				temp = d{i,:};

				if (i ==1)
					%scale 1
					d_t{i,:} = [temp(1:207),zeros(1,290-207),temp(291:337),zeros(1,434-337),temp(435:end)] ;
				elseif (i==2)
					%scale 2
					d_t{i,:} = [temp(1:97),zeros(1,140-97),temp(141:172),zeros(1,222-172),temp(223:end)] ;
				elseif (i==3)
					%scale 3
					d_t{i,:} = [temp(1:49),zeros(1,70-49),temp(71:82),zeros(1,114-82),temp(115:end)] ;
				elseif (i==4)
					%scale 4
					d_t{i,:} = [temp(1:23),zeros(1,37-23),temp(38:44),zeros(1,55-44),temp(56:end)] ;
					% rigursure = thselect(d{i,:},'rigrsure')
					% heursure = thselect(d{i,:},'heursure')
					% sqtwolog = thselect(d{i,:},'sqtwolog')
					% minimaxi = thselect(d{i,:},'minimaxi')
				elseif (i==5)
					%scale 5
					d_t{i,:} = [temp(1:13),zeros(1,19-13),temp(20:24),zeros(1,27-24),temp(28:end)] ;
				else
					%scale 6
					d_t{i,:} = [temp(1:6),zeros(1,8-6),temp(9:12),zeros(1,14-12),temp(15:end)] ;
				end

						
					
					
						
					

			% else
			% 	% disp('False')
			% 	d_t{i,:} = cell2mat(d(i,:));
			% end
		end
	else
		d_t = d;
	end
	if(plot_bool)
		figure(offset +1); 
		for (i = 1:n)
			subplot(n,1,i); hold on; plot(abs(d{i,:})); plot(T(i)*ones(1,length(d{i,:}))); plot(-T(i)*ones(1,length(d{i,:}))); title(['Decomposition with detail coeficient ' , num2str(i)]); 
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
		h =figure(offset +3); subplot(4,1,1); plot(((X))); title('Clean signal with scaled wavelets added')
				subplot(4,1,2); plot(((XN))); title('Noisey signal with scaled wavelets added')
				subplot(4,1,3); plot(((recovered))); title(['Denoised Reconstructed Signal using rigrsure with ', wname])
				subplot(4,1,4); plot(((XN - recovered))); title(['Denoised Reconstructed Signal using rigrsure with ', wname])
		pause(1);
	
	end

end