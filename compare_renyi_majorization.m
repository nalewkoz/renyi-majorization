nr=4;
x=0.8;
y=0.2;
Np=200;
disp('Zaczynam!');
tic
h1=plot_majorization_def(x,y,Np);
h2=plot_majorization(x,y,[-100 -10:0.5:10 10^6],Np);
h3=plot_majorization(x,y,[0:0.5:10 100 10^6],Np);
figure(h3);
title('Renyi entropies inequalities (only positive \alpha)');
h4=plot_majorization(x,y,[-100,0,100],Np);
figure(h4);
title('Renyi entropies inequalities (only 3 values of \alpha:-100,0,\infty)');
h5=plot_majorization(x,y,[-100,10^6],Np);
figure(h5);
title('Renyi entropies inequalities (only 2 extreme values of \alpha)');
h6=plot_majorization(x,y,[-100],Np);
figure(h6);
title('Renyi entropies inequalities (\alpha=-100)');
h7=plot_majorization(x,y,[10^6],Np);
figure(h7);
title('Renyi entropies inequalities (\alpha=\infty)');

printpdf(h1,sprintf('majorization_def%d',nr));
printpdf(h2,sprintf('renyi_inequalities%d',nr));
printpdf(h3,sprintf('renyi_inequalities_positive%d',nr));
printpdf(h4,sprintf('renyi_inequalities_3points%d',nr));
printpdf(h5,sprintf('renyi_inequalities_extreme%d',nr));
printpdf(h6,sprintf('renyi_inequalities_logmin%d',nr));
printpdf(h7,sprintf('renyi_inequalities_logmax%d',nr));

toc