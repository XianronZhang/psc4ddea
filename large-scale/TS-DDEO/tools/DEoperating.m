%------------------------------------------------------------------------
% This code is part of the program that produces the results in the following paper:
% Huixiang Zhen, Wenyin Gong, Ling Wang, Fei Ming, and Zuowen Liao. "Two-stage Data-driven Evolutionary Optimization for High-dimensional Expensive Problems", IEEE Transactions on Cybernetics, accepted, 2021.
% You are free to use it for non-commercial purposes. However, we do not offer any forms of guanrantee or warranty associated with the code. We would appreciate your acknowledgement.
%----------------------------------------------------------------------------------------------------------------------------------------

% DEoperating consist of mutation and crossover
function [U] = DEoperating(P,NP,Dim,hisx,F,CR,UB,LB)
    for i=1:NP 
        % mutation
        k0=randi([1,NP]);
        while(k0==i)
            k0=randi([1,NP]);   
        end
        P1=P(k0,:);
        k1=randi([1,NP]);
        while(k1==i||k1==k0)
            k1=randi([1,NP]);
        end
        P2=P(k1,:);
        k2=randi([1,NP]);
        while(k2==i||k2==k1||k2==k0)
            k2=randi([1,NP]);
        end
        P3=P(k2,:);

        Xpbest = hisx(1,:);
        V(i,:)=P1+F.*(P2-P3); 

        % bound
        for j=1:Dim
          if (V(i,j)>UB(i,j)||V(i,j)<LB(i,j))
             V(i,j)=LB(i,j)+rand*(UB(i,j)-LB(i,j));         
          end
        end

        % crossover
        jrand=randi([1,Dim]); 
        for j=1:Dim
            k3=rand;
            if(k3<=CR||j==jrand)
                U(i,j)=V(i,j);
            else
                U(i,j)=P(i,j);      
            end
        end
    end
end