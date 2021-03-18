function [Bbox]=DCCS(x0,y0,z0,a,b,c,T,Dim)
    %%  生成【维度×长度】的xyz轨道;初始化各项参数；
    x0=x0+rand()/10;
    y0=y0+rand()/10;
    z0=z0+rand()/10;
    aband=1000;

    P=6;
    I=10^16;
    MOD = 10 ^ P;

    %保留全局基准参量
    step=0.01;
%     ox=Ox;
%     oy=Oy;
%     oz=Oz;

    %初始化用于储存交叉信息的容器
    box=[];
    Bbox=[];


    
    %%  输入参数，开始混沌轨道的生成
    for D=1:1:Dim
            
%         %检查段1
%         checkX=[];
%         checkY=[];
%         checkZ=[];
        
        %从基准出发；随机扰动
        a=a+rand()/10;
        b=b+rand()/10;
        c=c+rand()/10;

        %计算定态点
        p1x=(c*(b-1))^0.5;
        p1y=(c*(b-1))^0.5;
        p1z=b+10;

        p2x=-(c*(b-1))^0.5;
        p2y=-(c*(b-1))^0.5;
        p2z=b+10;

        t=1;
        %碰撞循环
        while size(box,1)~=T
            %lorenz
            Ox = x0 + step * (a * (y0 - x0));
            Oy = y0 + step * (b * x0 - x0 * z0 - y0);
            Oz = z0 + step * (x0 *x0 - c * z0);

            %检验碰撞
            if (AxisL(p1z,p2z,p1x,p2x,x0)>=z0 && AxisL(p1z,p2z,p1x,p2x,Ox)<=Oz)||(AxisL(p1z,p2z,p1x,p2x,x0)<=z0 && AxisL(p1z,p2z,p1x,p2x,Ox)>=Oz)
                Xc=((x0*Oz-Ox*z0)*(p1x-p2x)-(p1x*p2z-p2x*p1z)*(x0-Ox))/((p1z-p2z)*(x0-Ox)-(z0-Oz)*(p1x-p2x));
                if Xc>=p2x && Xc<=p1x
                    box=[box;Xc];
                end
            end
    
% %             检查段2
%             checkX=[checkX,x0];
%             checkY=[checkY,y0];
%             checkZ=[checkZ,z0];
        
            %动力系统向量推进
            x0 = Ox;
            y0 = Oy;
            z0 = Oz;

            t=t+1;
        end
        Bbox=[Bbox,box];
        box=[];
    end
    
% %     检查段3
%     checkX(:,1:aband)=[];
%     checkY(:,1:aband)=[];
%     checkZ(:,1:aband)=[];
%     figure(3);
%     axis([-25,25,0,60]);
%     cla;
%     hold on
%     plot(checkX(1,:),checkZ(1,:));
%     scatter(p1x,p1z,'^');
%     scatter(p2x,p2z,'^');
%     l=-25:1:25;
%     f=AxisL(p1z,p2z,p1x,p2x,l);
%     plot(l,f,'-.');
%     scatter(Bbox(:,end),p1z*ones(T,1),'*','r');
%     hold off
%     pause(0.1);

end