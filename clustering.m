clear
close all

training_set = csvread('train.csv',1,1);
%validation_set = csvread('validation.csv',1,0);
%test_set = csvread('test.csv',1,0);

points = [0 0;
          0 1;
          .5 .5;
          5 0;
          5.5 .5;
          6 0;
          3 5;
          3 6;
          3.5 5.5];

% % implementing k-means clustering for k = 3
% ci = [randi([0 8], 3, 1) randi([0 8], 3, 1)];       % initial centroids
% movement = [];
% 
% % cluster assignment step
% a = knnsearch(ci,points, 'IncludeTies',true,'Distance','Euclidean');
% a = cell2mat(a);
% closest = ci(a,:);

[idx,C] = kmeans(training_set,10)

% for i = 1:100
%     current = ci;
%     
%     
% end

figure;
scatter(points(:,1), points(:,2))
hold on 
%scatter(ci(:,1), ci(:,2), 'r+')
scatter(C(:,1), C(:,2), 'r+')