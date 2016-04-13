function [TrainingTime,TestingTime,test_gmean,F_measure,test_acc] = ELM_regularized_NXN(TrainingData_File, TestingData_File, Elm_Type, NumberofHiddenNeurons, ActivationFunction,C,a)


%%%%%%%%%%% Macro definition
CLASSIFIER=1;

%%%%%%%%%%% Load training dataset
train_data = TrainingData_File;

P=train_data(:,2:size(train_data,2))';%9*n
T=P; %!
clear train_data;                                   %   Release raw training data array

%%%%%%%%%%% Load testing dataset
test_data =  TestingData_File;
TV.T=test_data(:,1)';%1*n
TV.P=test_data(:,2:size(test_data,2))';  %9*n
clear test_data;                                    %   Release raw testing data array

NumberofTrainingData=size(P,2);
NumberofTestingData=size(TV.P,2);
NumberofInputNeurons=size(P,1);


W = GetW(P,a); %自己求一个W矩阵,作为中间的一个权重 这里可以加一个参数用作调参
%%%%%%%%%%% Calculate weights & biases
tic;%计时开始
%%%%%%%%%%% Random generate input weights InputWeight (w_i) and biases BiasofHiddenNeurons (b_i) of hidden neurons
InputWeight=rand(NumberofHiddenNeurons,NumberofInputNeurons)*2-1;%[-1,1]
BiasofHiddenNeurons=rand(NumberofHiddenNeurons,1);
tempH=InputWeight*P;                                         %   Release input of training data 
ind=ones(1,NumberofTrainingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tempH=tempH+BiasMatrix;

%%%%%%%%%%% Calculate hidden neuron output matrix H
switch lower(ActivationFunction)
    case {'sig','sigmoid'}
        %%%%%%%% Sigmoid 
        H = 1 ./ (1 + exp(-tempH));
    case {'sin','sine'}
        %%%%%%%% Sine
        H = sin(tempH);    
    case {'hardlim'}
        %%%%%%%% Hard Limit
        H = double(hardlim(tempH));
    case {'tribas'}
        %%%%%%%% Triangular basis function
        H = tribas(tempH);
    case {'radbas'}
        %%%%%%%% Radial basis function
        H = radbas(tempH);
        %%%%%%%% More activation functions can be added here                
end
clear tempH;                                        %   Release the temparary array for calculation of hidden neuron output matrix H

n = size(T,2);
%%%%%%%%%%% Calculate output weights OutputWeight (beta_i)
% OutputWeight=pinv(H') * T';                        % slower implementation
temp1=(speye(n)/C);

%temp1=(speye(n) /C)';%0阵
temp2=W*(H)'*H;
OutputWeight=H*((temp2+temp1)\(W*T')); %C后面的'我自己改过 β

% n = NumberofHiddenNeurons;
% OutputWeight=((H*H'+speye(n)/C)\(H*T')); 

% OutputWeight=mtimesx(H,((mtimesx(H',H)+speye(n)/C)\T')); 
% OutputWeight=inv(H * H') * H * T';                         % faster implementation
% end_time_train=cputime;
% TrainingTime=end_time_train-start_time_train     ;   %   Calculate CPU time (seconds) spent for training ELM
TrainingTime=toc;
%%%%%%%%%%% Calculate the training accuracy
Y=(H' * OutputWeight)';                             %   Y: the actual output of the training data
%Y=T;

clear H;

%%%%%%%%%%% Calculate the output of testing input
start_time_test=cputime;
tempH_test=InputWeight*TV.P;
clear TV.P;             %   Release input of testing data             
ind=ones(1,NumberofTestingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tempH_test=tempH_test + BiasMatrix;
switch lower(ActivationFunction)
    case {'sig','sigmoid'}
        %%%%%%%% Sigmoid 
        H_test = 1 ./ (1 + exp(-tempH_test));
    case {'sin','sine'}
        %%%%%%%% Sine
        H_test = sin(tempH_test);        
    case {'hardlim'}
        %%%%%%%% Hard Limit
        H_test = hardlim(tempH_test);        
    case {'tribas'}
        %%%%%%%% Triangular basis function
        H_test = tribas(tempH_test);        
    case {'radbas'}
        %%%%%%%% Radial basis function
        H_test = radbas(tempH_test);        
        %%%%%%%% More activation functions can be added here        
end
TY=(H_test' * OutputWeight)';                       %   TY: the actual output of the testing data 9*n
%TY=TV.T;
end_time_test=cputime;
TestingTime=end_time_test-start_time_test      ;     %   Calculate CPU time (seconds) spent by ELM predicting the whole testing data

clear OutputWeight;
if Elm_Type == CLASSIFIER
    
    dis=zeros(1,NumberofTrainingData);
    for i=1:NumberofTrainingData
        dis(1,i)=norm(P(:,i)-Y(:,i));
    end
    sort(dis);
    threshold =dis(1,floor(NumberofTrainingData*0.9));%设置阈值  0.9是因数
    TP=0;
    TN=0;
    FP=0;
    FN=0;
    test_dis=zeros(1,NumberofTestingData);
    for i=1:NumberofTestingData
        test_dis(1,i)=norm(TV.P(:,i)-TY(:,i));
        if(test_dis(1,i)<=threshold)
            if(TV.T(1,i)==2)
              TP=TP+1;  
            else
              FP=FP+1;
            end
        else
            if(TV.T(1,i)==2)
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
   % [j,TrainingTime, TestingTime, test_sensitivity, test_specificity, test_gmean,F_measure,test_acc]
end