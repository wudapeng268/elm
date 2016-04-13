function [myanswer]=Once(target,outliner,NumberofHiddenNeurons,C,a)%ans 有trainingTime TestingTime gmean F_measure acc
    [A,B]=size(target);
    k=5;%k折
    temp=floor(A/k);
    myanswer=zeros(8,5);
    
    for i=1:k
        if(i==k)
        testing=[target((temp*(i-1)+1:A),:);outliner];
        else
        testing=[target((temp*(i-1)+1:temp*i),:);outliner];
        end
        training=setdiff(target,testing,'rows');
        
        [TrainingTime,TestingTime,test_gmean,F_measure,test_acc]=ELM_regularized_NXN(training,testing,1,NumberofHiddenNeurons,'sig',C,1/4);%亲测10最好
        myanswer(1,:)=myanswer(1,:)+[TrainingTime,TestingTime,test_gmean,F_measure,test_acc];
        
        %其他的比较代码在temp.m里直接copy到此处就可以用了
        t1=cputime;
        w=gauss_dd(training(:,2:B),0.1);
        t2=cputime;
        myanswer(2,:)=myanswer(2,:)+test_other(t2-t1,testing,w);

        
        t1=cputime;
        w=parzen_dd(training(:,2:B),0.1);
        t2=cputime;
        myanswer(3,:)=myanswer(3,:)+test_other(t2-t1,testing,w);

        t1=cputime;
        w=autoenc_dd(training(:,2:B),0.1);
        t2=cputime;
        myanswer(4,:)=myanswer(4,:)+test_other(t2-t1,testing,w);

        t1=cputime;
        w=kmeans_dd(training(:,2:B),0.1);
        t2=cputime;
        myanswer(5,:)=myanswer(5,:)+test_other(t2-t1,testing,w);

    
        t1=cputime;
        w=nndd(training(:,2:B),0.1);
        t2=cputime;
        myanswer(6,:)=myanswer(6,:)+test_other(t2-t1,testing,w);

        t1=cputime;
        w=knndd(training(:,2:B),0.1);
        t2=cputime;
        myanswer(7,:)=myanswer(7,:)+test_other(t2-t1,testing,w);

        t1=cputime;
        w=svdd(training(:,2:B),0.1);
        t2=cputime;
        myanswer(8,:)=myanswer(8,:)+test_other(t2-t1,testing,w);
        
        
       
        
    end
    myanswer=myanswer./k;
    

end