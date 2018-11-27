clear
close all

training_set = csvread('train.csv',1,1);    % read file and remove first row (labels) and first column (encounter_id)
full_matrix = training_set;
%t = [(full_matrix(1:10,end) == 0) (full_matrix(1:10,end) == 2) (full_matrix(1:10,end) == 3) (full_matrix(1:10,end) == 4)];
%features_labels = training_set(1,:);

% emergency_inpatient = training_set(:,[3:4 end]);
% not_readmitted_idx = emergency_inpatient(:,end) == 0;
% under30_idx = emergency_inpatient(:,end) == 1;
% over30_idx = emergency_inpatient(:,end) == 2;
% 
% not_readmitted = emergency_inpatient(not_readmitted_idx,:);
% under30 = emergency_inpatient(under30_idx,:);
% over30 = emergency_inpatient(over30_idx,:);
% 
% figure(1)
% scatter(not_readmitted(:,1), not_readmitted(:,2), 'gx')
% hold on
% scatter(under30(:,1), under30(:,2), 'bo')
% hold on
% scatter(over30(:,1), over30(:,2), 'r+')
% 
% 
% emergency_inpatient = training_set(:,[3:5 end]);
% not_readmitted_idx = emergency_inpatient(:,end) == 0;
% under30_idx = emergency_inpatient(:,end) == 1;
% over30_idx = emergency_inpatient(:,end) == 2;
% 
% not_readmitted = emergency_inpatient(not_readmitted_idx,:);
% under30 = emergency_inpatient(under30_idx,:);
% over30 = emergency_inpatient(over30_idx,:);
% 
% figure(2)
% scatter3(not_readmitted(:,1), not_readmitted(:,2), not_readmitted(:,3), 'gx')
% hold on
% scatter3(under30(:,1), under30(:,2), under30(:,3), 'bo')
% hold on
% scatter3(over30(:,1), over30(:,2), over30(:,3), 'r+')

training_set = training_set(:, 1:end-1);    % remove last column ('readmitted'), values in last column are class labels 
%validation_set = csvread('validation.csv',1,1);
%test_set = csvread('test.csv',1,1);

% % implementing k-means clustering for k = 4
[idx,C] = kmeans(training_set,20,'Distance','cityblock','Display','final','Replicates',100);
best_dist = [88165 2;75562 3;69648 4;65979 5;61760 6;58753 7; 55932 8; 54499 9;52268 10;44448 15;38430 20];
% silhouette plot
% figure
% [silh4,h] = silhouette(training_set,idx,'cityblock');
% h = gca;
% h.Children.EdgeColor = [.8 .8 1];
% xlabel 'Silhouette Value'
% ylabel 'Cluster'

% organize dataset into 6 homogenous groups
combine = [idx training_set];   % map index values (idx) to corresponding training set values

ind1 = combine(:,1) == 1;   % defining group 1, ind1 are boolean values used to determine which training set values belong to cluster C1
group1 = full_matrix(ind1,:);   % extracting training set values that belong to cluster C1
% group1 = group1(:, 2:end);  % removing first column (ind1)
% group1 = [group1 class_labels];
% group1 = [features_labels; group1];

ind2 = combine(:,1) == 2;   % defining group 2
group2 = full_matrix(ind2,:);
%group2 = group2(:, 2:end);

ind3 = combine(:,1) == 3;   % defining group 3
group3 = full_matrix(ind3,:);
%group3 = group3(:, 2:end);

ind4 = combine(:,1) == 4;   % defining group 4
group4 = full_matrix(ind4,:);
%group4 = group4(:, 2:end);

% disp(size(group1))
% disp(size(group2))
% disp(size(group3))
% disp(size(group4))

% csvwrite('training_group1.csv',group1)
% csvwrite('training_group2.csv',group2)
% csvwrite('training_group3.csv',group3)
% csvwrite('training_group4.csv',group4)

