myfolder={'DM02','DM04','DM05','DM06','DM10','DM12','DM14','DM15','DM17','DM18','DM21','DM22','DM23','DM24','DM26','DM30','DM35','DM37'}; % List of folder names
myFolder_op = { '.\op_group2\','.\op_group4\','.\op_group5\','.\op_group6\','.\op_group10\','.\op_group12\','.\op_group14\','.\op_group15\','.\op_group17\' ,'.\op_group18\','.\op_group21\','.\op_group22\','.\op_group23\','.\op_group24\','.\op_group26\','.\op_group30\','.\op_group35\','.\op_group37\'};


% Code to read the data
for folder=1:18 % Read from 18 groups
    myFolder=strcat('.\data_test\',myfolder{folder});
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
                    
                    dlmwrite(strcat(myFolder_op{folder},output{1,gesture}),(dataArray{1,n})');    % Save the results to CSV
                else
                    dlmwrite(strcat(myFolder_op{folder},output{1,gesture}),(dataArray{1,n})','-append');
                    
                end
            end
            fclose('all');
            clearvars filename delimiter startRow formatSpec fileID dataArray ans;   % Clear the values of variables
        end
    end
end


