
line = 0;
Actionfile_name = {'About','And','Can','Cop','Deaf','Decide','Father','Find','GoOut','Hearing'};
fulldata=csvread('./transformed_fulltest/train.csv');
train_name = {'About_train.csv','And_train.csv','Can_train.csv','Cop_train.csv','Deaf_train.csv','Decide_train.csv','Father_train.csv','Find_train.csv','GoOut_train.csv','Hearing_train.csv'};
test_name = {'About.csv','And.csv','Can.csv','Cop.csv','Deaf.csv','Decide.csv','Father.csv','Find.csv','GoOut.csv','Hearing.csv'};


% To delete the existing files before creating new files
for i=1:10
     delete(strcat('./TrainData/',train_name{i}));
     delete(strcat('./TestData/1Group/',test_name{i}));
     delete(strcat('./TestData/2Group/',test_name{i}));
     delete(strcat('./TestData/3Group/',test_name{i}));
     delete(strcat('./TestData/4Group/',test_name{i}));
     delete(strcat('./TestData/5Group/',test_name{i}));
     delete(strcat('./TestData/6Group/',test_name{i}));
     delete(strcat('./TestData/7Group/',test_name{i}));
     delete(strcat('./TestData/8Group/',test_name{i}));
     delete(strcat('./TestData/9Group/',test_name{i}));
     delete(strcat('./TestData/10Group/',test_name{i}));
end

%TRAINING DATA
for i=1:10                                                             
    %for every action
    fname= strcat(Actionfile_name{i},'_train.csv');
    %until full_traindata file is completely traversed
    while(line < 1200)                                                 
    %if given row corresponds to current action under consideration
    if(fulldata(line+1,5)==i)                                             
        
        train_set=fulldata(line+1:line+120,:);
        %set label to 1  
        train_set(:,5)=1;      
        %append current action data to file
        
        dlmwrite(strcat('./TrainData/',fname),train_set,'-append'); 
        
    else
        %non-action data
        %pick 40 random non action entries from each group
        r = randi([line+1 line+120],1,40);                                 
        for idx = 1:numel(r)
            non_action_instance = fulldata(r(idx),1:5);
            %set label to 0
            non_action_instance(:,5)=0;                                 
            %append non-action to file
            dlmwrite(strcat('./TrainData/',fname),non_action_instance,'-append');
        end
    end
    line = line+120;
    end
    line =0;
end





fulldata=csvread('./transformed_fulltest/test.csv');

%for test file grp1
base = 0;

%%for grp1 i value
i=0;
grp1 = NaN(1,5);
while(base<800)
start = base+(i*8)+1;
append_data=fulldata(start:start+7,:);
grp1 = [grp1; append_data];
base = base+80;
end
grp1= grp1(2:81,:);

%for test file grp2
base = 0;

%%for and i value
i=1;
grp2 = NaN(1,5);
while(base<800)
start = base+(i*8)+1;
append_data=fulldata(start:start+7,:);
grp2 = [grp2; append_data];
base = base+80;
end
grp2= grp2(2:81,:);

%for test file grp3
base = 0;

%%for grp3 i value
i=2;
grp3 = NaN(1,5);
while(base<800)
start = base+(i*8)+1;
append_data=fulldata(start:start+7,:);
grp3 = [grp3; append_data];
base = base+80;
end
grp3= grp3(2:81,:);

%for test file grp4
base = 0;

%%for grp4 i value
i=3;
grp4 = NaN(1,5);
while(base<800)
start = base+(i*8)+1;
append_data=fulldata(start:start+7,:);
grp4 = [grp4; append_data];
base = base+80;
end
grp4= grp4(2:81,:);

%for test file grp5
base = 0;

%%for grp5 i value
i=4;
grp5 = NaN(1,5);
while(base<800)
start = base+(i*8)+1;
append_data=fulldata(start:start+7,:);
grp5 = [grp5; append_data];
base = base+80;
end
grp5= grp5(2:81,:);

%for test file grp6
base = 0;

%%for grp6 i value
i=5;
grp6 = NaN(1,5);
while(base<800)
start = base+(i*8)+1;
append_data=fulldata(start:start+7,:);
grp6 = [grp6; append_data];
base = base+80;
end
grp6= grp6(2:81,:);

%for test file grp7
base = 0;

%%for grp7 i value
i=6;
grp7 = NaN(1,5);
while(base<800)
start = base+(i*8)+1;
append_data=fulldata(start:start+7,:);
grp7 = [grp7; append_data];
base = base+80;
end
grp7= grp7(2:81,:);

%for test file grp8
base = 0;

%%for grp8 i value
i=7;
grp8 = NaN(1,5);
while(base<800)
start = base+(i*8)+1;
append_data=fulldata(start:start+7,:);
grp8 = [grp8; append_data];
base = base+80;
end
grp8= grp8(2:81,:);

%for test file grp9
base = 0;

%%for grp9 i value
i=8;
grp9 = NaN(1,5);
while(base<800)
start = base+(i*8)+1;
append_data=fulldata(start:start+7,:);
grp9 = [grp9; append_data];
base = base+80;
end
grp9= grp9(2:81,:);

%for test file grp10
base = 0;

%%for grp10 i value
i=9;
grp10 = NaN(1,5);
while(base<800)
start = base+(i*8)+1;
append_data=fulldata(start:start+7,:);
grp10 = [grp10; append_data];
base = base+80;
end
grp10= grp10(2:81,:);


line=0;

groups={grp1,grp2,grp3,grp4,grp5,grp6,grp7,grp8,grp9,grp10};
for idx = 1:10 % looping thro every group
    folder=strcat(num2str(idx),'Group/');
    
    %path=strcat(folder,fname);
    group_data = groups(idx);
    group_data = group_data{1,1};
    
    for i= 1:10 % for every action within a group (8 instances per action)
        fname= strcat(Actionfile_name{i},'');%%,num2str(idx));
        fname= strcat(fname,'.csv');
        path = strcat(folder,fname);
        while(line < 80)
        tot_path = strcat('./TestData/',path);
        if (group_data(line+1,5)==i)
         test_set=group_data(line+1:line+8,:);
        %set label to 1  
        test_set(:,5)=1;      
        %append current action data to file
        
        dlmwrite(tot_path,test_set,'-append');    
        else
        %non-action data
        %pick 3 random non action entries from each group
        r = randi([line+1 line+8],1,3);                                 
        for idx1 = 1:numel(r)
            non_action_instance = group_data(r(idx1),1:5);
            %set label to 0
            non_action_instance(:,5)=0;                                 
            %append non-action to file
            dlmwrite(tot_path,non_action_instance,'-append');
        end    
        end
        line = line + 8;
        end
        line=0;
    end
end





