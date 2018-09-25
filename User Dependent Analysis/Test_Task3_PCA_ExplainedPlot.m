
file = {'About.csv','And.csv','Can.csv','Cop.csv','Deaf.csv','Decide.csv','Father.csv','Find.csv','GoOut.csv','Hearing.csv'};

filename={'About.csv','And.csv','Can.csv','Cop.csv','Deaf.csv','Decide.csv','Father.csv','Find.csv','GoOut.csv','Hearing.csv'};
myFolder = { '.\op_group2\','.\op_group4\','.\op_group5\','.\op_group10\','.\op_group12\','.\op_group15\','.\op_group18\','.\op_group21\','.\op_group22\','.\op_group23\','.\op_group24\','.\op_group30\','.\op_group35\','.\op_group37\'};

action_name={'About','And','Can','Cop','Deaf','Decide','Father','Find','Go out','Hearing'};





for actions=1:10
    
    
    MaxMatrix=zeros(17*numel(myFolder),6);    % Matrix to hold the final result
    
     % Variable to keep track of the 1st line number of each selected sensor
     
    LineALZ=3;
    LineARZ=6;              
    LineGLX=23;
    LineOPR=33;
    LineOYR=34;
    
    
    for fol=1:numel(myFolder)
        delimiter = ',';
        fullFileName = fullfile(myFolder{fol},file{actions});
        fileID = fopen(fullFileName,'r');
        formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
        dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
        T{fol} = table(dataArray{1,1},dataArray{1,2},dataArray{1,3},dataArray{1,4},dataArray{1,5},dataArray{1,6},dataArray{1,7},dataArray{1,8},dataArray{1,9},dataArray{1,10},dataArray{1,11},dataArray{1,12},dataArray{1,13},dataArray{1,14},dataArray{1,15},dataArray{1,16},dataArray{1,17},dataArray{1,18},dataArray{1,19},dataArray{1,20},dataArray{1,21},dataArray{1,22},dataArray{1,23},dataArray{1,24},dataArray{1,2},dataArray{1,26},dataArray{1,27},dataArray{1,28},dataArray{1,29},dataArray{1,30},dataArray{1,31},dataArray{1,32},dataArray{1,33},dataArray{1,34},dataArray{1,35},dataArray{1,36},dataArray{1,37},dataArray{1,38},dataArray{1,39},dataArray{1,40});
    end
    
    % T{1}   - myFolder{1} data , T{2}   - myFolder{2} data , T{3}   - myFolder{3} data ,
    
    
    track=1;
    for fol=1:numel(myFolder)
        A = table2array(T{1,fol});
        for i=1:15                                  % Loop to read 17 instances
            
            
            %Feature 1
            str = A(LineALZ:LineALZ,1:40);
            str = arrayfun(@(x) str2double(x),str);
            MaxMatrix(track,1) = max(str);                              %  1 represent 1st column
            LineALZ=LineALZ+34;      
            
            %Feature 2
            str = A(LineARZ:LineARZ,1:40);
            str = arrayfun(@(x) str2double(x),str);
            MaxMatrix(track,2) = max(str);                              %  2 represent 2nd column
            LineARZ=LineARZ+34;      %change variable name
            
            
            
            %Feature 3
            str = A(LineGLX:LineGLX,1:40);
            str = arrayfun(@(x) str2double(x),str);
            MaxMatrix(track,3) = nanstd(str);                           %  3rd column
            LineGLX=LineGLX+34;      %change variable name
            
            %Feature 4 and 5
            str = A(LineOPR:LineOPR,1:40);
            str = arrayfun(@(x) str2double(x),str);
            MaxMatrix(track,4) = var(fft(str));                         % 4th and 5th columns
            MaxMatrix(track,5) = var(str);
            LineOPR=LineOPR+34;       %change variable name
            
            
            
            %Feature 6
            str = A(LineOYR:LineOYR,1:40);
            str = arrayfun(@(x) str2double(x),str);
            MaxMatrix(track,6) = var(fft(str));                       %  6th column
            LineOYR=LineOYR+34;      %change variable name
            
            track=track+1;
            
        end
        
        LineALZ=3;    % Re-initialize the line numbers
        LineARZ=6;
        LineGLX=23;
        LineOPR=33;
        LineOYR=34;
        
        
    end
    
    
    fclose('all');
    
    
    % Normalize the data
    X1=MaxMatrix(:,1);
    norm_X1= (X1-min(X1)/max(X1)-min(X1));
    
    X2=MaxMatrix(:,2);
    norm_X2= (X2-min(X2)/max(X2)-min(X2));
    
    X3=MaxMatrix(:,3);
    norm_X3= ((X3-min(X3))/(max(X3)-min(X3)));
    
    X4=MaxMatrix(:,4);
    norm_X4= ((X4-min(X4))/(max(X4)-min(X4)));
    
    X5=MaxMatrix(:,5);
    norm_X5= ((X5-min(X5))/(max(X5)-min(X5)));
        
    X6=MaxMatrix(:,6);
    norm_X6= ((X6-min(X6))/(max(X6)-min(X6)));
    
    norm_data = [norm_X1 norm_X2 norm_X3 norm_X4 norm_X5 norm_X6];
 
    
   
    %[wcoeff,score,latent,tsquared,explained] = pca(norm_data,'Algorithm','eig','NumComponents',6);
    
    
    filename_1 = strcat('.\PCA_Explained\',file{actions});
    delimiter_1 = ',';
    formatSpec_1 = '%f%f%f%f%f%f%[^\n\r]';
    fileID_1 = fopen(filename_1,'r');
    dataArray_1 = textscan(fileID_1, formatSpec_1, 'Delimiter', delimiter_1, 'TextType', 'string',  'ReturnOnError', false);
    fclose(fileID_1);
    res_1 = table(dataArray_1{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3','VarName4','VarName5','VarName6'});
    res_1=table2array(res_1);
    reduced_feature_matrix = res_1(:,1:4);
    trans_matrix = norm_data*reduced_feature_matrix;
   
    
       
 
    dlmwrite(strcat('./test_set/',file{actions}),trans_matrix);
    
    
    
    
    

    
end




