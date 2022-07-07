pos=[5];
hgt=[5];
wdt=[5];
[f, yf1, yf01]=Gaussian_signal_generation(pos,hgt,wdt,0);
yf1=yf1-min(yf1);
[yscsa ,Nh,eig_v,eig_f] = scsa_build(6,yf1);
plot(yf1,'b--','linewidth',4)
hold on
plot(yscsa,'k','linewidth',2)
hold on
plot(eig_f,'linewidth',1)
set(gca,'visible','off')
