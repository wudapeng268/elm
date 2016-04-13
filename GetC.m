function [ C ] = GetC(training_file)%C为n*1的向量 目前没啥用!!!!
%GETC Summary of this function goes here
%   Detailed explanation goes here
C=zeros(size(training_file,1),1);
num_1=0;
num_2=0;
for i=1:size(training_file,1)
    if(training_file(i,1)==1)
        num_1=num_1+1;
    end
     if(training_file(i,1)==2)
        num_2=num_2+1;
     end         
end
if(num_1~=0)
    num_1=1/num_1;%算出惩罚因子
end
if(num_2~=0)
    num_2=1/num_2;
end

for i=1:size(training_file,1)
    if(training_file(i,1)==1)
        C(i,1)=num_2;
    end
    if(training_file(i,1)==2)
        C(i,1)=num_1;
    end         
end
C=C';%C为1*n的向量
end

