myfolder={'DM07','DM09','DM11','DM13','DM16','DM27','DM29', 'DM31','DM34' };   % List of folder names


% Code to read the data
for folder=1:9
    myFolder=strcat('.\data\',myfolder{folder});
    if exist(myFolder, 'dir') ~= 7
        Message = sprintf('Error: The following folder does not exist:\n%s', myFolder);
        uiwait(warndlg(Message));
        return;
    end
    
    output={'About.csv','And.csv','Can.csv','Cop.csv','Deaf.csv','Decide.csv','Father.csv','Find.csv','GoOut.csv','Hearing.csv'};
    actions={'*about*.csv','*And*.csv','*can*.csv','*cop*.csv','*deaf*.csv','*decide*.csv','*father*.csv','*find*.csv','*go*out*.csv','*hearing*.csv'};
    
    for gesture=1:10
        filePattern = fullfile(myFolder, actions{gesture});
        disp(actions{1,gesture});
        srcFiles   = dir(filePattern);
        fclose('all');
        flag=1;
        for k = 1:length(srcFiles)
            baseFileName = srcFiles(k).name;
            fullFileName = fullfile(myFolder, baseFileName);
            
            delimiter = ',';
            startRow = 2;
            % Specify the format to read the data from the source files
            formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';
            fileID = fopen(fullFileName,'r');
            dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
            numOfElements=numel(dataArray);
            
            for n=1:numOfElements-1  % sensors
                if (folder==1 && k==1 && n==1)
                    flag=0;
                    
                    dlmwrite(strcat('.\op_task1\',output{1,gesture}),(dataArray{1,n})');    % Save the results to CSV
                else
                    dlmwrite(strcat('.\op_task1\',output{1,gesture}),(dataArray{1,n})','-append');
                    
                end
            end
            fclose('all');
            clearvars filename delimiter startRow formatSpec fileID dataArray ans;   % Clear the values of variables
        end
    end
end


