function w = get_wavelet(n,c)
  cs = c(1,:);
  cw = c(2,:);
  s = cs;
  w = cw;

  for i = 1:n
    x2(1:2:length(w)*2) = w;
    x2(2:2:length(x2)-1)=0;
    x(1:2:length(s)*2) = s;
    x(2:2:length(x)-1)=0;
    s = conv((x), (cs));
    w = conv((x2),(cs));
  end
  % w = -w;
end