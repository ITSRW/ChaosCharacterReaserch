function [Bbox]=DCCS(x0,y0,z0,a,b,c,T,Dim)
    %%  ���ɡ�ά�ȡ����ȡ���xyz���;��ʼ�����������
    x0=x0+rand()/10;
    y0=y0+rand()/10;
    z0=z0+rand()/10;
    aband=1000;

    P=6;
    I=10^16;
    MOD = 10 ^ P;

    %����ȫ�ֻ�׼����
    step=0.01;
%     ox=Ox;
%     oy=Oy;
%     oz=Oz;

    %��ʼ�����ڴ��潻����Ϣ������
    box=[];
    Bbox=[];


    
    %%  �����������ʼ������������
    for D=1:1:Dim
            
%         %����1
%         checkX=[];
%         checkY=[];
%         checkZ=[];
        
        %�ӻ�׼����������Ŷ�
        a=a+rand()/10;
        b=b+rand()/10;
        c=c+rand()/10;

        %���㶨̬��
        p1x=(c*(b-1))^0.5;
        p1y=(c*(b-1))^0.5;
        p1z=b+10;

        p2x=-(c*(b-1))^0.5;
        p2y=-(c*(b-1))^0.5;
        p2z=b+10;

        t=1;
        %��ײѭ��
        while size(box,1)~=T
            %lorenz
            Ox = x0 + step * (a * (y0 - x0));
            Oy = y0 + step * (b * x0 - x0 * z0 - y0);
            Oz = z0 + step * (x0 *x0 - c * z0);

            %������ײ
            if (AxisL(p1z,p2z,p1x,p2x,x0)>=z0 && AxisL(p1z,p2z,p1x,p2x,Ox)<=Oz)||(AxisL(p1z,p2z,p1x,p2x,x0)<=z0 && AxisL(p1z,p2z,p1x,p2x,Ox)>=Oz)
                Xc=((x0*Oz-Ox*z0)*(p1x-p2x)-(p1x*p2z-p2x*p1z)*(x0-Ox))/((p1z-p2z)*(x0-Ox)-(z0-Oz)*(p1x-p2x));
                if Xc>=p2x && Xc<=p1x
                    box=[box;Xc];
                end
            end
    
% %             ����2
%             checkX=[checkX,x0];
%             checkY=[checkY,y0];
%             checkZ=[checkZ,z0];
        
            %����ϵͳ�����ƽ�
            x0 = Ox;
            y0 = Oy;
            z0 = Oz;

            t=t+1;
        end
        Bbox=[Bbox,box];
        box=[];
    end
    
% %     ����3
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