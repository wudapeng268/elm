function [target,outliner]=divide_t()%采用自助法(bootstrapping)将一个集合分成测试集和训练集 %glass0146_vs_2.m
test_data;
id = (data(:,1)==1);
outliner=data(id,:);          
target=setdiff(data,outliner,'rows');
end