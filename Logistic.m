function [track]=Logistic(x,L,u,dim)
    track=zeros(L,dim);
    X_next=x;

    for D=1:1:dim
        for T=1:1:L
            X_next=X_next*u*(1-X_next);
            track(T,D)=X_next;
        end
    end
end