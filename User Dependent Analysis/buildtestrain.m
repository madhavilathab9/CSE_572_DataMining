%build train and test sets
file_names = {'About.csv','And.csv','Can.csv','Cop.csv','Deaf.csv','Decide.csv','Father.csv','Find.csv','GoOut.csv','Hearing.csv'};

for d=1:10
    delete(strcat('./trained_set_Data/',file_names{d}));
     delete(strcat('./test_Set_Data/',file_names{d}));
end

train_notActionCount = 17;
test_notActionCount=27;
round={train_notActionCount,test_notActionCount};
round_name={'trained_set' ,'test_set'};
count={153,238};
for r=1:2 % train and test round
for curr_action=1:10
    
                     %build path
        path=strcat('./',round_name{r});
        path=strcat(path,"_Data");
        path=strcat(path,'/');
        path=strcat(path,file_names{curr_action});
        
    for i=1:10
        %Read the file
            filename = strcat('.\',round_name{r});
            filename=strcat(filename,'\');
            filename = strcat(filename,file_names{i});
            delimiter = ',';
            formatSpec = '%f%f%f%f%[^\n\r]';
            fileID = fopen(filename,'r');
            dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
            fclose(fileID);
            action = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3','VarName4'});
            

        
        if(i==curr_action)
            %read everything
            content=table2array(action);
            content(:,5:5)=1;
            dlmwrite(path,content,'-append');
        else
            %pick n random actions based on train or test round
            row=randi([1 count{r}],round{r},1);
            for k=1:numel(row)
            content=table2array(action(row(k),1:4));
            content(:,5:5)=0;
            dlmwrite(path,content,'-append');
            end
        end
   
        
    end
    
end    
end