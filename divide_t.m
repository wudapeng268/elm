function [target,outliner]=divide_t()%����������(bootstrapping)��һ�����Ϸֳɲ��Լ���ѵ���� %glass0146_vs_2.m
test_data;
id = (data(:,1)==1);
outliner=data(id,:);          
target=setdiff(data,outliner,'rows');
end