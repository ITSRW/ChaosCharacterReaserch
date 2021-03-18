clear;
clc;

%% 初始参数设定
staticsMat=[];
logmeanmat=[];
%% 多轮实验
for index=1:1:10
    %% 混沌轨道生成与归一化
    [Bbox]=arcsinLogistic(rand(),1000,4,2);
    track=zeros(size(Bbox,1),size(Bbox,2));
    for j=1:1:size(Bbox,2)
        for i=1:1:size(Bbox,1)
            track(i,j)=(Bbox(i,j)-min(Bbox(:,j)))/(max(Bbox(:,j))-min(Bbox(:,j)));
        end
    end
    
    %% 分段演化收敛分析
    staticsMat=zeros(10,size(track,1));
    counter=zeros(10,1);
    for dynamic=1:1:size(track,1)
        if track(dynamic,1)<=0.1
            counter(1)=counter(1)+1;
        end
        if 0.1<track(dynamic,1) && track(dynamic,1)<=0.2
            counter(2)=counter(2)+1;
        end
        if 0.2<track(dynamic,1) && track(dynamic,1)<=0.3
            counter(3)=counter(3)+1;
        end
        if 0.3<track(dynamic,1) && track(dynamic,1)<=0.4
            counter(4)=counter(4)+1;
        end
        if 0.4<track(dynamic,1) && track(dynamic,1)<=0.5
            counter(5)=counter(5)+1;
        end
        if 0.5<track(dynamic,1) && track(dynamic,1)<=0.6
            counter(6)=counter(6)+1;
        end
        if 0.6<track(dynamic,1) && track(dynamic,1)<=0.7
            counter(7)=counter(7)+1;
        end
        if 0.7<track(dynamic,1) && track(dynamic,1)<=0.8
            counter(8)=counter(8)+1;
        end
        if 0.8<track(dynamic,1) && track(dynamic,1)<=0.9
            counter(9)=counter(9)+1;
        end
        if 0.9<track(dynamic,1) && track(dynamic,1)<=1.0
            counter(10)=counter(10)+1;
        end
        for p=1:1:10
            staticsMat(p,dynamic)=counter(p)/sum(counter);
        end
    end
    
    %% 平面均匀度分析
    chesscount=0;
    chesslog=[];
    K=10;
    for S=1:1:K
        for p=1:1:size(track,1)
            if (track(p,1)<=(0.5+(((S)/K)^0.5)/2) && track(p,1)>=(0.5-(((S)/K)^0.5)/2)) && (track(p,2)<=(0.5+(((S)/K)^0.5)/2) && track(p,2)>=(0.5-(((S)/K)^0.5)/2))
                chesscount=chesscount+1;
            end
        end
        chesslog=[chesslog;chesscount];
        chesscount=0;
    end
    
    %% 实验结果绘图
    %混沌平面散布棋盘统计图
    figure(1);
    scatter(track(:,1),track(:,2),'.');
    title('arcsin-Logistic distribution');
    hold on
    axisL=0.1:0.1:1;
    for S=1:1:K
        plot((0.5+(((S)/K)^0.5)/2)*ones(2,1),[(0.5+(((S)/K)^0.5)/2),(0.5-(((S)/K)^0.5)/2)]);
        plot((0.5-(((S)/K)^0.5)/2)*ones(2,1),[(0.5+(((S)/K)^0.5)/2),(0.5-(((S)/K)^0.5)/2)]);
        plot([(0.5+(((S)/K)^0.5)/2),(0.5-(((S)/K)^0.5)/2)],(0.5+(((S)/K)^0.5)/2)*ones(2,1));
        plot([(0.5+(((S)/K)^0.5)/2),(0.5-(((S)/K)^0.5)/2)],(0.5-(((S)/K)^0.5)/2)*ones(2,1));
    end
    hold off
    %混沌平面分布均匀分析曲线
    figure(2)
    plot(chesslog);
    title('arcsin-Logistic dis-Line');
    grid on
    grid minor
%     %演化收敛分析曲线
%     figure(3);
%     plot(staticsMat','-.','LineWidth',0.8);
%     hold on;
%     plot(0.1*ones(size(track,1)),'--r','LineWidth',2);
%     hold off;
%     grid on;
%     grid minor;

    pause(0.1);
    
    %计算平面均匀度分析曲线平均斜率
    minusmat=chesslog(2:end)-chesslog(1:end-1);
    minusmat=minusmat(2:end)./minusmat(1:end-1);
    disp(mean(minusmat));
    logmeanmat=[logmeanmat;mean(minusmat)];
end
    disp(['平均均匀度=',num2str(mean(logmeanmat))]);