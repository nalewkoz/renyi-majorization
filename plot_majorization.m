function h=plot_majorization(x0,y0,a_tab,Nmesh)
    %a_tab=[0:da:1000 10^6];
    Na=length(a_tab);
    v0=[x0,y0,1-x0-y0];
    re0=zeros(Na,1);
    re=zeros(Na,1);
    for i=1:Na
        re0(i)=renyi_entropy(v0,a_tab(i));
    end
    dx=1/Nmesh;
    h=figure;
    hold on;
    for x=0:dx:1
        for y=0:dx:1-x
            v=[x,y,1-x-y];
            for i=1:Na
               re(i)=renyi_entropy(v,a_tab(i));
            end
            Nlarger=sum(re0>=re);
            Nsmaller=sum(re0<=re);
            
            if( Nlarger==Na && Nsmaller==Na) % they majorize each other
                plot(x,y,'y.','MarkerFaceColor','y');
            elseif(Nlarger==Na) % v0 is majorized by v
                plot(x,y,'r.','MarkerFaceColor','r');
            elseif(Nsmaller==Na) % v0 majorizes v
                plot(x,y,'g.','MarkerFaceColor','g');
            else
                plot(x,y,'k.','MarkerFaceColor','k');  %incomparable
            end
        end
    end
    plot(x0,y0,'.','MarkerSize',18);
    title('Renyi entropies inequalities');
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