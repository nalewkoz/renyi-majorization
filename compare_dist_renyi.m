function [rx, ry]=compare_dist_renyi(x,y,r,a,nr)
%     a=-10:0.1:10;
    Na=length(a);
    rx=zeros(1,Na);
    ry=zeros(1,Na);
    for i=1:Na
        rx(i)=renyi_entropy(x,a(i));
        ry(i)=renyi_entropy(y,a(i));
    end
%     strx='[';
%     for i=1:length(x)
%         strx=[strx sprintf('%.2f ',x(i))]; 
%     end
%     strx=[strx(1:end-1) ']'];
%     strx
%     rx2=zeros(1,Na);
%     ry2=zeros(1,Na);
    
    x2=kron(x,r);
    y2=kron(y,r);
    for i=1:Na
        rx2(i)=renyi_entropy(x2,a(i));
        ry2(i)=renyi_entropy(y2,a(i));
    end
    
    h=figure
    subplot(2,2,1);
    hold on
    plot(a,rx,'r');
    plot(a,ry);
   % xlabel('\alpha','Fontsize',12);
    ylabel('H_{\alpha}','Fontsize',12);
    title('R$\acute{e}$nyi entropies','interpreter','Latex');
    hl=legend(sprintf('p=%s',mat2str(x)),sprintf('q=%s',mat2str(y)));
    set(hl,'fontsize',8);
    
    subplot(2,2,2);
    hold on
    Nx=length(x);
    Ny=length(y);
    plot(0:1/Nx:1,[0 cumsum(sort(x,'descend'))],'r');
    plot(0:1/Ny:1,[0 cumsum(sort(y,'descend'))]);
    plot(0:1/Nx:1,[0 cumsum(sort(x,'descend'))],'r.');
    plot(0:1/Ny:1,[0 cumsum(sort(y,'descend'))],'.');
    title('Lorenz curves','interpreter','Latex');
   % xlabel('Cumulative uniform distribution');
    ylabel('Cumulative sorted distribution');
    axis([0 1 0 1]);
    
    
    subplot(2,2,3);
    hold on
    plot(a,rx2,'r');
    plot(a,ry2);
    xlabel('\alpha','Fontsize',12);
    ylabel('H_{\alpha}','Fontsize',12);
    %title('R$\acute{e}$nyi entropies','interpreter','Latex');
    hl=legend(sprintf('p\\otimes%s',mat2str(r)),sprintf('q\\otimes%s',mat2str(r)));
    set(hl,'fontsize',8);
    subplot(2,2,4);
    hold on
    Nx2=length(x2);
    Ny2=length(y2);
    plot(0:1/Nx2:1,[0 cumsum(sort(x2,'descend'))],'r');
    plot(0:1/Ny2:1,[0 cumsum(sort(y2,'descend'))]);
    plot(0:1/Nx2:1,[0 cumsum(sort(x2,'descend'))],'r.');
    plot(0:1/Ny2:1,[0 cumsum(sort(y2,'descend'))],'.');
    %title('Lorenz curves','interpreter','Latex');
    xlabel('Cumulative uniform distribution');
    ylabel('Cumulative sorted distribution');
    axis([0 1 0 1]);
    
    
    printpdf(h,sprintf('renyi_lorenz%d',nr));
    
    
end

function y=renyi_entropy(z,a)
    if(a==1)
        z2=z(z>0);
        y=-sum(z2.*log(z2));
    elseif(a==0)
        y=log(sum(z>0));
    elseif(a>10^5)
        y=-log(max(z));
    else
        y=sign(a)*log(sum(z.^a))/(1-a);
    end
end
