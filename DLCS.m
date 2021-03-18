function [ChaoticPoiintsx,ChaoticPoiintsy,ChaoticPoiintsz]=DLCS(x0,y0,z0,a,b,c,T,Dim)
    %%  ���ɡ�ά�ȡ����ȡ���xyz���;��ʼ�����������    
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
    
    %����ȫ�ֻ�׼����
    step=0.001;
    ox=Ox;
    oy=Oy;
    oz=Oz;

    %%  �����������ʼ������������
    for D=1:1:Dim
        %�ӻ�׼����������Ŷ�
        x0=ox;
        y0=oy;
        z0=oz;
        a=a+rand()/10;
        b=b+rand()/10;
        c=c+rand()/10;
        %ÿ��ά�ȸ�����ͬ�Ŷ�
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
            %�����������ɵ�
            if t>aband
                ChaoticPoiintsx(D,t-aband)=mod(x0*I,MOD);
                ChaoticPoiintsy(D,t-aband)=mod(y0*I,MOD);
                ChaoticPoiintsz(D,t-aband)=mod(z0*I,MOD);
                
%                 ChaoticPoiintsx(D,t-aband)=x0;%mod(x0*I,MOD);
%                 ChaoticPoiintsy(D,t-aband)=y0;%mod(y0*I,MOD);
%                 ChaoticPoiintsz(D,t-aband)=z0;%mod(z0*I,MOD);
            end
        end
       %% ����ÿһ���������һ��ά�ȣ�����Ҫ���һ�ֺ���ķ���������������ת��Ϊ��ɢ��������
        %Ŀǰʹ�õ�һ��lorenz��rossler�����������ͻ���������0��������������⣬
        %��һ�����������ɸ�ά�޷��������ĸ�Դ����Ҫ������ƻ��緽����
        %�˴��д��Ľ�
    end
end