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
        
        