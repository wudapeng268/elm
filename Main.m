[target,outliner]=divide_t();
[A,B]=size(target);
    answer=zeros(8,5);
    k=5;
    for i=1:k
        a=randperm(A);
        target=target(a,:);
        answer=answer+Once(target,outliner,110,16,1/7);
    end
    answer=answer./k;
