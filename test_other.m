function [An]=test_other(TrainingTime1,testing,w)
    t1=cputime;
    TrainingTime=TrainingTime1;
    [A,B]=size(testing);

    bb=testing(:,2:B)*w
    bb=bb*classc;
    labels=bb*labeld;
    TP=0;
    TN=0;
    FP=0;
    FN=0;
    
   
    for i=1:A
        if((strcmp(labels(i,:),'target ')))%strcmp有问题。。。比较
            if(testing(i,1)==2)
              TP=TP+1;  
            else
              FP=FP+1;
            end
        else
            if(testing(i,1)==2)
              FN=FN+1;  
            else
              TN=TN+1;
            end
        end
    end
    if(TP==0&&FN==0)
       test_sensitivity =0;
    else
       test_sensitivity = TP/(TP+FN);
    end
    if(TN==0&&FP==0)
      test_specificity = 0;
    else
      test_specificity = TN/(TN+FP);
    end
    if(TP==0&&FP==0)
        precision=0;
    else
        precision=TP/(TP+FP);
    end
    if(precision==0&&test_sensitivity==0)
       F_measure=0;
    else
       F_measure=(2*precision*test_sensitivity)/(precision+test_sensitivity);   
    end      
    test_gmean = sqrt(test_sensitivity * test_specificity);
    test_acc=(TP+TN)/(TP+TN+FP+FN);
    t2=cputime;
    TestingTime=t2-t1;
    An=[TrainingTime, TestingTime, test_gmean,F_measure,test_acc];
end

