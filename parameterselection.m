%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[target,outliner]=divide_t();
[A,B]=size(target);
    k=5;%kÕÛ
    temp=floor(A/k);

for i=1:k
   if(i==k)
        testing=[target((temp*(i-1)+1:A),:);outliner];
   else
        testing=[target((temp*(i-1)+1:temp*i),:);outliner];
   end
   training=setdiff(target,testing,'rows');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   for j=1:20
      for k=1:5
          for a=1:10
         [T1,T2,test_gmean,F_measure,test_acc]=ELM_regularized_NXN(training,testing,1,10*j,'sig',2^(2*k),1/a);
         y(j,k,a,i)=test_gmean;
      
          end
      end
   end
   clear testing;
   clear training;
end


w1=mean(y,4);




maxacc=0;
for i=1:20
  for j=1:5
      for a=1:10
         if(w1(i,j,a)>=maxacc)
            maxacc=w1(i,j,a);
            a1=i;
            a2=j;
            a3=a;
         end
      end
  end
end
bestL=10*a1
bestC=2^(2*a2)
besta=1/a
w1(a1,a2)
