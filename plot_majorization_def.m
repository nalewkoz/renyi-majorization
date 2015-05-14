function h=plot_majorization_def(x0,y0,Nmesh)
    %a_tab=[0:da:1000 10^6];
    Na=2;
    v0=[x0,y0,1-x0-y0];
    S0=cumsum(sort(v0,'descend'));
    dx=1/Nmesh;
    h=figure;
    hold on;
    for x=0:dx:1
        for y=0:dx:1-x
            v=[x,y,1-x-y];
            S=cumsum(sort(v,'descend'));
            Nlarger=sum(S0(1:2)<=S(1:2));
            Nsmaller=sum(S0(1:2)>=S(1:2));
            
            if( Nlarger==Na && Nsmaller==Na) % they majorize each other
                plot(x,y,'y.','MarkerFaceColor','y');
            elseif(Nlarger==Na) % v0 is majorized by v
                plot(x,y,'r.','MarkerFaceColor','r');
            elseif(Nsmaller==Na) % v0 majorizes v
                plot(x,y,'g.','MarkerFaceColor','g');
            else
                plot(x,y,'k.','MarkerFaceColor','k');  %noncomparable
            end
        end
    end
    plot(x0,y0,'.','MarkerSize',18);
    title('Majorization');
end
