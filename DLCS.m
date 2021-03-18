function [ChaoticPoiintsx,ChaoticPoiintsy,ChaoticPoiintsz]=DLCS(x0,y0,z0,a,b,c,T,Dim)
    %%  生成【维度×长度】的xyz轨道;初始化各项参数；    
    ChaoticPoiintsx=zeros(Dim,T);
    ChaoticPoiintsy=zeros(Dim,T);
    ChaoticPoiintsz=zeros(Dim,T);
    Ox=x0;
    Oy=y0;
    Oz=z0;
    aband=100;
    
    P=6;
    I=10^16;
    MOD = 10 ^ P;
    
    %保留全局基准参量
    step=0.001;
    ox=Ox;
    oy=Oy;
    oz=Oz;

    %%  输入参数，开始混沌轨道的生成
    for D=1:1:Dim
        %从基准出发；随机扰动
        x0=ox;
        y0=oy;
        z0=oz;
        a=a+rand()/10;
        b=b+rand()/10;
        c=c+rand()/10;
        %每个维度给出不同扰动
        for t=1:1:T+aband
            %lorenz            
            Ox = x0 + step * (a * (y0 - x0));
            Oy = y0 + step * (b * x0 - x0 * z0 - y0);
            Oz = z0 + step * (x0^2 - c * z0);
            
            %rossler
%             Ox = x0 - step * (y0 + z0);
%             Oy = y0 + step * (x0 + a * y0);
%             Oz = z0 + step * (b + z0 * (x0 - c));
            
            x0 = Ox;
            y0 = Oy;
            z0 = Oz;
            %抛弃吸引过渡点
            if t>aband
                ChaoticPoiintsx(D,t-aband)=mod(x0*I,MOD);
                ChaoticPoiintsy(D,t-aband)=mod(y0*I,MOD);
                ChaoticPoiintsz(D,t-aband)=mod(z0*I,MOD);
                
%                 ChaoticPoiintsx(D,t-aband)=x0;%mod(x0*I,MOD);
%                 ChaoticPoiintsy(D,t-aband)=y0;%mod(y0*I,MOD);
%                 ChaoticPoiintsz(D,t-aband)=z0;%mod(z0*I,MOD);
            end
        end
       %% 对于每一条轨道（即一个维度），需要设计一种合理的方案将连续混沌轨道转化为离散混沌轨道，
        %目前使用的一种lorenz、rossler连续混沌整型化方案存在0线搜索不足的问题，
        %这一问题可能是造成高维无法求解情况的根源。需要重新设计混沌方案；
        %此处有待改进
    end
end