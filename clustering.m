clear
close all

training_set = csvread('train.csv',1,1);
size_train = size(training_set);
training_set = training_set(:, 1:end-1);
%validation_set = csvread('validation.csv',1,1);
%test_set = csvread('test.csv',1,1);

% % implementing k-means clustering for k = 6
[idx,C] = kmeans(training_set,6);

% organize dataset into 6 homogenous groups
combine = [idx training_set];

ind1 = combine(:,1) == 1;   % defining group 1
group1 = combine(ind1,:);
group1 = group1(:, 2:end);

ind2 = combine(:,1) == 2;   % defining group 2
group2 = combine(ind2,:);
group2 = group2(:, 2:end);

ind3 = combine(:,1) == 3;   % defining group 3
group3 = combine(ind3,:);
group3 = group3(:, 2:end);

ind4 = combine(:,1) == 4;   % defining group 4
group4 = combine(ind4,:);
group4 = group4(:, 2:end);

ind5 = combine(:,1) == 5;   % defining group 5
group5 = combine(ind5,:);
group5 = group5(:, 2:end);

ind6 = combine(:,1) == 6;   % defining group 6
group6 = combine(ind6,:);
group6 = group6(:, 2:end);