
%% Generate_Signal: function description
function [v_noisey,v_clean] = Generate_Signal(wname,n,plot_bool,leng)
	Folder=pwd;
	[PathStr,FolderName]=fileparts(Folder);
	DataFolder=(['Nested_Wavlet_Signal']);
	mkdir(DataFolder);

	[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(wname);
	[phi,psi,xval] = wavefun(wname,n);

	% Test Coefficients:
	[sum_,fund_,orth_] = coef_test(Lo_D);
	disp(['This is the sum of the coef: ', num2str(sum_)])
	disp(['This is the result of the fundamental condition test: ', num2str(fund_)])
	disp(['This is the result of the orthogonality test: ', num2str(fund_)])

	%Check if cascade method works
	% [s,w] = cascade(n-1,Lo_R,Hi_R);
	% if(plot_bool)
	% 	figure(1); subplot(2,2,1); plot(phi); title(['Orignal  ', wname , ' scaling function' ])
	% 			   subplot(2,2,2); plot(psi); title(['Orignal  ', wname , ' wavelet function' ])
	% 			   subplot(2,2,3); plot(s);   title(['Recovered ',wname ' scaling function'])
	% 			   subplot(2,2,4); plot(w);   title(['Recovered ',wname ' wavelet function'])
	% end

	%Bury 2 versions of psi in noise
	v_noisey = wgn(1,2^leng,0.0001,'linear');
	v_clean  = zeros(1,2^leng);

	s1 = psi(1:4:end);
	s1 = [s1 zeros(1,length(psi) -length(s1))];

	% if(plot_bool)
	% 	figure(2); subplot(2,1,1); plot(psi); title('Original wavelet')
	% 		   	   subplot(2,1,2); plot(s1); title('Scaled Wavelet')
	% end

	in1 = ceil(2^leng/40);
	in2 = ceil(2^leng/2);
	v_noisey(in1 + 1:in1+length(psi)) = v_noisey(in1 + 1:in1+length(psi)) + 1*psi;
	v_noisey(in2 + 1:in2+length(s1))  = v_noisey(in2 + 1:in2+length(psi)) + 1*s1;
	v_clean(in1 + 1:in1+length(psi))  = 1*psi;
	v_clean(in2 + 1:in2+length(s1))   = 1*s1;

	if(plot_bool)
		figure(3);  subplot(2,1,1); plot(v_clean); title('Clean signal with scaled wavelets added')
					% subplot(2,2,2); plot(abs(fftshift(fft(v_clean)))); title('PSD of Clean signal with wavelets added')	
					subplot(2,1,2); plot(v_noisey); title('Noisey signal with scaled wavelets added')
					% subplot(2,2,4); plot(abs(fftshift(fft(v_noisey)))); title('PSD of Noisey signal with wavelets added')
	end
	% save([DataFolder,'/',datestr(datetime('now'))],'wname','Lo_D','Hi_D','Lo_R','Hi_R','phi','psi','v_noisey','v_clean','leng');
end