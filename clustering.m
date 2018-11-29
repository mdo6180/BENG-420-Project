clear
close all

training_set = csvread('train.csv',1,1);    % read file and remove first row (labels) and first column (encounter_id)
full_matrix = training_set;
%t = [(full_matrix(1:10,end) == 0) (full_matrix(1:10,end) == 2) (full_matrix(1:10,end) == 3) (full_matrix(1:10,end) == 4)];
features_labels = training_set(:,end);

not_readmitted_idx = full_matrix(:,end) == 0;
under30_idx = full_matrix(:,end) == 1;
over30_idx = full_matrix(:,end) == 2;

not_readmitted = full_matrix(not_readmitted_idx, 1:end-1);
under30 = full_matrix(under30_idx, 1:end-1);
over30 = full_matrix(over30_idx, 1:end-1);

training_set = training_set(:, 1:end-1);    % remove last column ('readmitted'), values in last column are class labels 
%validation_set = csvread('validation.csv',1,1);
%test_set = csvread('test.csv',1,1);

% implementing k-means clustering for <30 days hospital readmittance
%[idx,C] = kmeans(under30,5,'Distance','sqeuclidean','Display','final','Replicates',100);
[idx,C_under30] = kmeans(under30,2);
[idx1,C_over30] = kmeans(over30,4);
[idx2,C_not] = kmeans(not_readmitted,7);

C_not_readmitted = [C_not zeros(size(C_not,1), 1)];
C_under30days = [C_under30 ones(size(C_under30,1), 1)];

ax = zeros(size(C_over30,1), 1);
ax(:) = 2;

C_over30days = [C_over30 ax];

downsample = [C_not_readmitted; C_under30days; C_over30days];
downsample_features = downsample(:, 1:end-1);
downsample_labels = downsample(:, end);

mdl = fitcknn(downsample_features, downsample_labels);
prediction_labels = predict(mdl,training_set);

num_correct = 0;
for i = 1:length(prediction_labels)
    if prediction_labels(i) == features_labels(i)
        num_correct = num_correct + 1;
    end
end

training_accuracy = (num_correct/size(features_labels,1))*100
% silhouette plot
% current_test = not_readmitted;
% index = idx2;
% figure(1)
% [silh,h] = silhouette(current_test,index,'sqEuclidean');
% h = gca;
% h.Children.EdgeColor = [.8 .8 1];
% xlabel 'Silhouette Value'
% ylabel 'Cluster'
% title('<30 Days Readmittance Silhouette Plot')

% X = current_test;
% Y = pdist(X);
% Z = linkage(Y,'average');
% 
% figure(2)
% dendrogram(Z)
% xlabel('Groups')
% ylabel('Link Distance')
% title('<30 Days Readmittance Dendrogram')
% 
% c = cophenet(Z,Y)
% T = clusterdata(Z, 'maxclust', 5);
% 
% disp(mean(silh))

% organize dataset into 6 homogenous groups
% combine = [idx training_set];   % map index values (idx) to corresponding training set values
% 
% ind1 = combine(:,1) == 1;   % defining group 1, ind1 are boolean values used to determine which training set values belong to cluster C1
% group1 = full_matrix(ind1,:);   % extracting training set values that belong to cluster C1
% % group1 = group1(:, 2:end);  % removing first column (ind1)
% % group1 = [group1 class_labels];
% % group1 = [features_labels; group1];
% 
% ind2 = combine(:,1) == 2;   % defining group 2
% group2 = full_matrix(ind2,:);
% %group2 = group2(:, 2:end);
% 
% ind3 = combine(:,1) == 3;   % defining group 3
% group3 = full_matrix(ind3,:);
% %group3 = group3(:, 2:end);
% 
% ind4 = combine(:,1) == 4;   % defining group 4
% group4 = full_matrix(ind4,:);
% %group4 = group4(:, 2:end);
% 
% % disp(size(group1))
% % disp(size(group2))
% % disp(size(group3))
% % disp(size(group4))
% 
% % csvwrite('training_group1.csv',group1)
% % csvwrite('training_group2.csv',group2)
% % csvwrite('training_group3.csv',group3)
% % csvwrite('training_group4.csv',group4)
% 
