function [ W ] = GetW( P,a )%PΪ9*n
%GETW Summary of this function goes here
%   Detailed explanation goes here
%��a 1/3 1/4 ƽ�� ���� Ŀ������w��Ĳ�������
len=pdist(P');%�õ�����
avg=mean(len)*a;%ȡƽ�������0.2��
z=squareform(len);%i��j�ľ���
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

