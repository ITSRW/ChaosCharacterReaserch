function [Bbox]=Tent(x0,miu,T,dim)
Bbox=zeros(T,dim);
%%  输入参数，开始混沌轨道的生成
x=x0+rand()/10;
for d=1:1:dim
    for t=1:1:T
        if x>0.5
            x=miu*(1-x);
        elseif x<=0.5
            x=miu*x;
        end
        Bbox(t,d)=x;
    end
end
end