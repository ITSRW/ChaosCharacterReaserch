function [track]=arcsinLogistic(x,L,u,dim)
    track=zeros(L,dim);
    X_next=x;

    for D=1:1:dim
        for T=1:1:L
            X_next=X_next*u*(1-X_next);
            track(T,D)=acos(X_next^0.5);
        end
    end
end