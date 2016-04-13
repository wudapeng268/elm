function [ W ] = GetW( P,a )%P为9*n
%GETW Summary of this function goes here
%   Detailed explanation goes here
%改a 1/3 1/4 平方 立方 目的是让w阵的差异显著
len=pdist(P');%得到距离
avg=mean(len)*a;%取平均距离的0.2倍
z=squareform(len);%i和j的距离
temp_w=zeros(length(z),length(z));

for i=1:size(z,1)
    for j=1:size(z,2)
        if(z(i,j)<=avg)
            temp_w(i,i)=temp_w(i,i)+1;
        end
    end
end
W=temp_w.^3;
clear z;
clear temp_w;
end

