actionlist = {'About.csv','And.csv','Can.csv','Cop.csv','Deaf.csv','Decide.csv','Father.csv','Find.csv','GoOut.csv','Hearing.csv'};
sensors={'ALX','ALY','ALZ','ARX','ARY','ARZ','EMG0L','EMG1L','EMG2L','EMG3L','EMG4L','EMG5L','EMG6L','EMG7L','EMG0R','EMG1R','EMG2R','EMG3R','EMG4R','EMG5R','EMG6R','EMG7R','GLX','GLY','GLZ','GRX','GRY','GRZ','ORL','OPL','OYL','ORR','OPR','OYR'};
action_name = {'About','And','Can','Cop','Deaf','Decide','Father','Find','GoOut','Hearing'};



% To read the collected data and to store in table T
for actions=1:10
    myFolder = '.\op_task1\';
    delimiter = ',';
    fullFileName = fullfile(myFolder,actionlist{actions});
    fileID = fopen(fullFileName,'r');
    formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
    T{actions} = table(dataArray{1,1},dataArray{1,2},dataArray{1,3},dataArray{1,4},dataArray{1,5},dataArray{1,6},dataArray{1,7},dataArray{1,8},dataArray{1,9},dataArray{1,10},dataArray{1,11},dataArray{1,12},dataArray{1,13},dataArray{1,14},dataArray{1,15},dataArray{1,16},dataArray{1,17},dataArray{1,18},dataArray{1,19},dataArray{1,20},dataArray{1,21},dataArray{1,22},dataArray{1,23},dataArray{1,24},dataArray{1,2},dataArray{1,26},dataArray{1,27},dataArray{1,28},dataArray{1,29},dataArray{1,30},dataArray{1,31},dataArray{1,32},dataArray{1,33},dataArray{1,34},dataArray{1,35},dataArray{1,36},dataArray{1,37},dataArray{1,38},dataArray{1,39},dataArray{1,40});
    
end

% Plot sub graphs for comparision
for i=1:34
    figure1 = figure('Name',sensors{i},'NumberTitle','off');
    for ac=1:10
        
        
        subplot(2,5,ac);
        line=i;          % for every Accelerometer X of given action
        j=1;
        while j<=3
            
            
            y = T{1,ac}(line,1:40);
            
            y=double(table2array(y));
            
            x=1:40;
            plot(x,y)
            
            hold on;
            line=line+34;     % To keep track of the row number of sensors
            j=j+1;
        end
        title(action_name(ac));
        
    end
    
    
    figuresdir = '.\SubPlot\';
    saveas(gcf,strcat(figuresdir, strcat('Plot_',sensors{i})), 'jpeg');   % Save the plots
    
    
end