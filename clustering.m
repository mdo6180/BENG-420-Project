clear
close all

training_set = csvread('train.csv',1,1);    % read file and remove first row (labels) and first column (encounter_id)
training_class_labels = training_set(:,end);
training_features = training_set(:,1:end-1);

validation_set = csvread('validation.csv',1,1);
val_class_labels = validation_set(:,end);
over30_val = val_class_labels(:) == 2;
val_class_labels(over30_val) = 0;
val_features = validation_set(:,1:end-1);

mdl = fitcknn(training_features, training_class_labels,'NumNeighbors',3000);
predict_valid = predict(mdl, val_features);

num_correct_val = 0;
for i = 1:length(predict_valid)
    if val_class_labels(i) == predict_valid(i)
        num_correct_val = num_correct_val + 1;
    end
end

% validation accuracy = 83.7594%
validation_accuracy = (num_correct_val/length(val_class_labels))*100  

test_set = csvread('test.csv',1,1);
test_class_labels = test_set(:,end);
over30_test = test_class_labels(:) == 2;
test_class_labels(over30_test) = 0;
test_features = test_set(:,1:end-1);

predict_test = predict(mdl, test_features);

num_correct_test = 0;
for i = 1:length(predict_test)
    if test_class_labels(i) == predict_test(i)
        num_correct_test = num_correct_test + 1;
    end
end

% testing_accuracy = 83.3254
testing_accuracy = (num_correct_test/length(test_features))*100  % validation accuracy = 73.1735%

% i was trying something new so i split the training set into groups
% according to the class labels
% doing this also helped decrease runtime for hierarchical clustering
% and displaying the dendrogram and silhouette plot

% not_readmitted_idx = training_set(:,end) == 0;
% under30_idx = training_set(:,end) == 1;
% over30_idx = training_set(:,end) == 2;
% 
% not_readmitted = training_set(not_readmitted_idx, 1:end-1);
% under30 = training_set(under30_idx, 1:end-1);
% over30 = training_set(over30_idx, 1:end-1);
% 
% training_set = training_set(:, 1:end-1);    % remove last column ('readmitted'), values in last column are class labels 
% %validation_set = csvread('validation.csv',1,1);
% %test_set = csvread('test.csv',1,1);
% 
% % implementing k-means clustering
% %[idx,C] = kmeans(under30,5,'Distance','sqeuclidean','Display','final','Replicates',100);
% [idx,C_under30] = kmeans(under30,2);
% [idx1,C_over30] = kmeans(over30,4);
% [idx2,C_not] = kmeans(not_readmitted,7);
% 
% % silhouette plot
% current_test = under30;     %this will output a silhouette plot only for the data of patients readmitted within 30 days
% index = idx;
% figure(1)
% [silh,h] = silhouette(current_test,index,'sqEuclidean');
% h = gca;
% h.Children.EdgeColor = [.8 .8 1];
% xlabel 'Silhouette Value'
% ylabel 'Cluster'
% title('<30 Days Readmittance Silhouette Plot')
% 
% X = current_test;
% Y = pdist(X);
% Z = linkage(Y,'average');
% 
% figure(2)   % displaying the dendrogram
% dendrogram(Z)
% xlabel('Groups')
% ylabel('Link Distance')
% title('<30 Days Readmittance Dendrogram')
% 
% c = cophenet(Z,Y);
% T = clusterdata(Z, 'maxclust', 5);
% 
% disp(mean(silh))
