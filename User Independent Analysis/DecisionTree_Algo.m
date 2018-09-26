

% Code for training
folderpath = '.\TrainData';
folderpath1 = '.\TestData';
Train_names = {'About_train.csv','And_train.csv','Can_train.csv','Cop_train.csv','Deaf_train.csv','Decide_train.csv','Father_train.csv','Find_train.csv','GoOut_train.csv','Hearing_train.csv'};
test_names = {'About.csv','And.csv','Can.csv','Cop.csv','Deaf.csv','Decide.csv','Father.csv','Find.csv','GoOut.csv','Hearing.csv'};
Group_names = {'1Group','2Group','3Group','4Group','5Group','6Group','7Group','8Group','9Group','10Group'};
end_line = 8;
count=1;

for i=1:10
    
    % Reading Train Data
    filename_train = fullfile(folderpath,Train_names{i});
    delimiter = ',';
    formatSpec = '%f%f%f%f%f%[^\n\r]';
    fileID = fopen(filename_train,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
    fclose(fileID);
    
    
    % Training the data
    Total_Train_data = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3','VarName4','VarName5'});
    Total_Train_data_dt =  Total_Train_data{1:size(Total_Train_data,1),1:4} ;          % without last column
    result = zeros(size(Total_Train_data,1),1);
    result(1:120,1)=1;
    % Call fitctree to train Decision tree model.
    decision_model =  fitctree(Total_Train_data_dt,result,'PruneCriterion','impurity','SplitCriterion','deviance');
    
    
    for j=1:10
        
        % To read Test data
        filename_test = fullfile(folderpath1,Group_names{j},test_names{i});
        delimiter = ',';
        formatSpec = '%f%f%f%f%f%[^\n\r]';
        fileID = fopen(filename_test,'r');
        dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
        fclose(fileID);
        
        
        Total_Test_data = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3','VarName4','VarName5'});
        Total_Test_data_svm =  Total_Test_data{1:size(Total_Test_data,1),1:4} ;          % without last column
        [prediction] = predict(decision_model,Total_Test_data_svm);
        About_Prediction = prediction (1:end_line,1);
        Not_About_Prediction = prediction (end_line+1:size(Total_Test_data),1);
        
        % Calculate TP, FN, FP and TN
        
        TP = About_Prediction ( About_Prediction == 1 );
        FN = About_Prediction ( About_Prediction ==0);
        FP = Not_About_Prediction ( Not_About_Prediction ==1);
        TN = Not_About_Prediction ( Not_About_Prediction ==0 );
        
        % Formaulas
        % Precision = TP / (TP+FP)
        % Recall = TP / (TP+FN)
        % Accuracy = (TP + TN) / (TP + TN + FP + FN)
        
        Precision = length(TP)/(length(TP) + length(FP));
        Recall = length(TP)/(length(TP) + length(FN));
        f1 = (2 * Precision * Recall)/(Precision+ Recall);
        Accuracy = ((length(TP) + length(TN)) / (length(TP) + length(TN) + length(FP) + length(FN)) ) *100;
        
        
        
        matrix1(count,1)=length(TP);
        matrix1(count,2)=length(FN);
        matrix1(count,3)=length(FP);
        matrix1(count,4)=length(TN);
        matrix1(count,5)=Precision;
        matrix1(count,6)=Recall;
        matrix1(count,7)=f1;
        matrix1(count,8)=Accuracy;
        
        count= count+1;
        %===================================Results=======================================
    end
    
    count= count+2;
end

csvwrite('Performance_Decision.csv', matrix1);

% clearvars filename delimiter formatSpec fileID dataArray ans;