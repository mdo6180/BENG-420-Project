clear
close all

training_set = csvread('train.csv',1,1);    % read file and remove first row (labels) and first column (encounter_id)
training_class_labels = training_set(:,end);
training_features = training_set(:,1:end-1);

mdl = fitcknn(training_features, training_class_labels,'NumNeighbors',1);

% predicting validation set -----------------------------------------------

validation_set = csvread('validation.csv',1,1);
validation_class_labels = validation_set(:,end);
validation_features = validation_set(:,1:end-1);

predict_valid = predict(mdl, validation_features);

num_correct_validation = 0;
true_positive_validation = 0;
true_negative_validation = 0;
false_positive_validation = 0;
false_negative_validation = 0;
for i = 1:length(predict_valid)
    if validation_class_labels(i) == predict_valid(i)
        num_correct_validation = num_correct_validation + 1;
        
        if predict_valid(i) == 1
            true_positive_validation = true_positive_validation + 1;
        else
            true_negative_validation = true_negative_validation + 1;
        end  
    else
        if (validation_class_labels(i) == 0) && (predict_valid(i) == 1)
            false_positive_validation = false_positive_validation + 1;
        else
            false_negative_validation = false_negative_validation + 1;
        end
    end
    
end

% validation accuracy = 88.6176%
validation_accuracy = (num_correct_validation/length(validation_class_labels))*100  

num_positive_validation = sum(validation_class_labels(:) == 1);
sensitivity_validation = true_positive_validation/(num_positive_validation)

num_negative_validation = sum(validation_class_labels(:) == 0);
specificity_validation = true_negative_validation/(num_negative_validation)

% predicting test set -----------------------------------------------------

test_set = csvread('test.csv',1,1);
test_class_labels = test_set(:,end);
test_features = test_set(:,1:end-1);

predict_test = predict(mdl, test_features);

num_correct_test = 0;
true_positive_test = 0;
true_negative_test = 0;
false_positive_test = 0;
false_negative_test = 0;
for i = 1:length(predict_test)
    if test_class_labels(i) == predict_test(i)
        num_correct_test = num_correct_test + 1;
        
        if predict_test(i) == 1
            true_positive_test = true_positive_test + 1;
        else
            true_negative_test = true_negative_test + 1;
        end   
    else
        if (test_class_labels(i) == 0) && (predict_test(i) == 1)
            false_positive_test = false_positive_test + 1;
        else
            false_negative_test = false_negative_test + 1;
        end
    end
    
end

% test accuracy = 88.6176%
test_accuracy = (num_correct_test/length(test_class_labels))*100  

num_positive_test = sum(test_class_labels(:) == 1);
sensitivity_test = true_positive_test/(num_positive_test)

num_negative_test = sum(test_class_labels(:) == 0);
specificity_test = true_negative_test/(num_negative_test)

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
