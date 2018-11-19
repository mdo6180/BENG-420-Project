clear
close all

training_set = csvread('train.csv',1,1);    % read file and remove first row (labels) and first column (encounter_id)
training_set = training_set(:, 1:end-1);    % remove last column ('readmitted'), values in last column are class labels 
%validation_set = csvread('validation.csv',1,1);
%test_set = csvread('test.csv',1,1);

% % implementing k-means clustering for k = 4
[idx,C] = kmeans(training_set,4);

% organize dataset into 6 homogenous groups
combine = [idx training_set];   % map index values (idx) to corresponding training set values

ind1 = combine(:,1) == 1;   % defining group 1, ind1 are boolean values used to determine which training set values belong to cluster C1
group1 = combine(ind1,:);   % extracting training set values that belong to cluster C1
group1 = group1(:, 2:end);  % removing first column (ind1)

ind2 = combine(:,1) == 2;   % defining group 2
group2 = combine(ind2,:);
group2 = group2(:, 2:end);

ind3 = combine(:,1) == 3;   % defining group 3
group3 = combine(ind3,:);
group3 = group3(:, 2:end);

ind4 = combine(:,1) == 4;   % defining group 4
group4 = combine(ind4,:);
group4 = group4(:, 2:end);

disp(size(group1))
disp(size(group2))
disp(size(group3))
disp(size(group4))
