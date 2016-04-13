function [TrainingTime, TestingTime, test_sensitivity, test_specificity, test_gmean,F_measure,test_acc]=test_gauss(testing,w)
    TrainingTime=0;
    TestingTime=0;
    TP=0;
    TN=0;
    FP=0;
    FN=0;
    [A,B]=size(testing);
    test_dis=pdist2(testing(:,2:B),w.data.m(1,:),'mahalanobis').^2;
    %threshold is too big !!
    for i=1:A
        if(test_dis(i,1)<=w.data.threshold)
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
end

