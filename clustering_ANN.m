clear
close all

training_set = csvread('train.csv',1,1);    % read file and remove first row (labels) and first column (encounter_id)
test_set = csvread('test.csv',1,1);

% implementing k-means clustering for k = 4
[idx_train,C] = kmeans(training_set(:,1:end-1),4);

% organize dataset into 4 homogenous groups
combine = [idx_train training_set];   % map index values (idx) to corresponding training set values

% ANN for Group1 ----------------------------------------------------------
ind1 = combine(:,1) == 1;   % defining group 1, ind1 are boolean values used to determine which training set values belong to cluster C1
group1 = combine(ind1,:);   % extracting training set values that belong to cluster C1
group1 = group1(:, 2:end);  % removing first column (ind1)
train1 = group1(:,1:end-1)';    % group1 features
t1 = [(group1(:,end) == 0) (group1(:,end) == 1) (group1(:,end) == 2)]';     % group1 labels

net1 = linearlayer;
net1 = configure(net1, zeros(size(train1,1) , 1), zeros(size(t1,1) , 1));
net1.performFcn = 'sse';     % use sum squared error
net1.trainParam.epochs = 100;
net1.trainFcn = 'trainlm';   % use Levenberg-Marquardt backpropagation because it's the fastest backpropagation algorithm in the toolbox 

net1 = train(net1, train1, t1);     % train ANN

labels_train1 = net1(train1);       % predict labels
perf_train1 = perform(net1, t1, labels_train1);
prediction_train1 = round(labels_train1);     % round predicted values to nearest integer (either 1 or 0) 

figure(1)
plotconfusion(t1, prediction_train1, 'Training Group1')
% ------------------------------------------------------------------------

% ANN for Group2 ----------------------------------------------------------
ind2 = combine(:,1) == 2;   % defining group 2
group2 = combine(ind2,:);
group2 = group2(:, 2:end);
train2 = group2(:,1:end-1)';
t2 = [(group2(:,end) == 0) (group2(:,end) == 1) (group2(:,end) == 2)]';

net2 = linearlayer;
net2 = configure(net2, zeros(size(train2,1) , 1), zeros(size(t2,1) , 1));
net2.performFcn = 'sse';     % use sum squared error
net2.trainParam.epochs = 100;
net2.trainFcn = 'trainlm';   % use Levenberg-Marquardt backpropagation because it's the fastest backpropagation algorithm in the toolbox 

net2 = train(net2, train2, t2);

labels_train2 = net2(train2);
perf_train2 = perform(net2, t2, labels_train2);
prediction_train2 = round(labels_train2);     % round predicted values to nearest integer (either 1 or 0) 

figure(2)
plotconfusion(t2, prediction_train2, 'Training Group2')
% -------------------------------------------------------------------------

% ANN for Group3 ----------------------------------------------------------
ind3 = combine(:,1) == 3;   % defining group 3
group3 = combine(ind3,:);
group3 = group3(:, 2:end);
train3 = group3(:,1:end-1)';
t3 = [(group3(:,end) == 0) (group3(:,end) == 1) (group3(:,end) == 2)]';

net3 = linearlayer;
net3 = configure(net3, zeros(size(train3,1) , 1), zeros(size(t3,1) , 1));
net3.performFcn = 'sse';     % use sum squared error
net3.trainParam.epochs = 100;
net3.trainFcn = 'trainlm';   % use Levenberg-Marquardt backpropagation because it's the fastest backpropagation algorithm in the toolbox 

net3 = train(net3, train3, t3);

labels_train3 = net3(train3);
perf_train3 = perform(net3, t3, labels_train3);
prediction_train3 = round(labels_train3);     % round predicted values to nearest integer (either 1 or 0) 

figure(3)
plotconfusion(t3, prediction_train3, 'Training Group3')
% -------------------------------------------------------------------------

% ANN for Group4 ----------------------------------------------------------
ind4 = combine(:,1) == 4;   % defining group 4
group4 = combine(ind4,:);
group4 = group4(:, 2:end);
train4 = group4(:,1:end-1)';
t4 = [(group4(:,end) == 0) (group4(:,end) == 1) (group4(:,end) == 2)]';

net4 = linearlayer;
net4 = configure(net4, zeros(size(train4,1) , 1), zeros(size(t4,1) , 1));
net4.performFcn = 'sse';     % use sum squared error
net4.trainParam.epochs = 100;
net4.trainFcn = 'trainlm';   % use Levenberg-Marquardt backpropagation because it's the fastest backpropagation algorithm in the toolbox 

net4 = train(net4, train4, t4);

labels_train4 = net4(train4);
perf_train4 = perform(net4, t4, labels_train4);
prediction_train4 = round(labels_train4);     % round predicted values to nearest integer (either 1 or 0) 

figure(4)
plotconfusion(t4, prediction_train4, 'Training Group4')
% -------------------------------------------------------------------------

disp(size(group1))
disp(size(group2))
disp(size(group3))
disp(size(group4))

% Predicting testing set 
% classifying data points in test set into one of the four clusters based on closest centroid
idx_test = knnsearch(C, test_set(:,1:end-1));
test_combine = [idx_test test_set];

% Plotting confusion matrix for testing set 1 -----------------------------
test_group1_idx = test_combine(:,1) == 1;   
test_group1 = test_combine(test_group1_idx,:);
test_group1 = test_group1(:,2:end);
test_group1_features = test_group1(:,1:end-1)';
test_group1_labels = [(test_group1(:,end) == 0) (test_group1(:,end) == 1) (test_group1(:,end) == 2)]';     % test_group1 labels

labels_test1 = net1(test_group1_features);      % predict labels of testing point grouped into group1
prediction_test1 = round(labels_test1);

figure(5)
plotconfusion(test_group1_labels, prediction_test1, 'Testing group1')
% -------------------------------------------------------------------------

% Plotting confusion matrix for testing set 2 -----------------------------
test_group2_idx = test_combine(:,1) == 2;   
test_group2 = test_combine(test_group2_idx,:);
test_group2 = test_group2(:,2:end);
test_group2_features = test_group2(:,1:end-1)';
test_group2_labels = [(test_group2(:,end) == 0) (test_group2(:,end) == 1) (test_group2(:,end) == 2)]';     % test_group2 labels

labels_test2 = net2(test_group2_features);      % predict labels of testing point grouped into group2
prediction_test2 = round(labels_test2);

figure(6)
plotconfusion(test_group2_labels, prediction_test2, 'Testing group2')
% -------------------------------------------------------------------------

% Plotting confusion matrix for testing set 3 -----------------------------
test_group3_idx = test_combine(:,1) == 3;   
test_group3 = test_combine(test_group3_idx,:);
test_group3 = test_group3(:,2:end);
test_group3_features = test_group3(:,1:end-1)';
test_group3_labels = [(test_group3(:,end) == 0) (test_group3(:,end) == 1) (test_group3(:,end) == 2)]';     % test_group3 labels

labels_test3 = net3(test_group3_features);      % predict labels of testing point grouped into group3
prediction_test3 = round(labels_test3);

figure(7)
plotconfusion(test_group3_labels, prediction_test3, 'Testing group3')
% -------------------------------------------------------------------------

% Plotting confusion matrix for testing set 4 -----------------------------
test_group4_idx = test_combine(:,1) == 4;   
test_group4 = test_combine(test_group4_idx,:);
test_group4 = test_group4(:,2:end);
test_group4_features = test_group4(:,1:end-1)';
test_group4_labels = [(test_group4(:,end) == 0) (test_group4(:,end) == 1) (test_group4(:,end) == 2)]';     % test_group4 labels

labels_test4 = net4(test_group4_features);      % predict labels of testing point grouped into group4
prediction_test4 = round(labels_test4);

figure(8)
plotconfusion(test_group4_labels, prediction_test4, 'Testing group4')
% -------------------------------------------------------------------------

% Plotting confusion matrix for entire test set ---------------------------

% combine class labels of points in test set into one matrix 
% combine predicted class labels into another matrix
test_set_labels = [test_group1_labels test_group2_labels test_group3_labels test_group4_labels];
predicted_test_labels = [prediction_test1 prediction_test2 prediction_test3 prediction_test4];

figure(9)
plotconfusion(test_set_labels, predicted_test_labels, 'Testing Set')
% -------------------------------------------------------------------------

% Determine sensitivity and specificity -----------------------------------
num_correct_test = 0;
true_positive_test = 0;
true_negative_test = 0;
false_positive_test = 0;
false_negative_test = 0;
for i = 1:length(predicted_test_labels)
    if isequal(test_set_labels(:,i),predicted_test_labels(:,i))
        num_correct_test = num_correct_test + 1;
        
        if predicted_test_labels(1,i) == 1
            true_negative_test = true_negative_test + 1;
        else
            true_positive_test = true_positive_test + 1;
        end   
    else
        if (test_set_labels(1,i) == 0) && (predicted_test_labels(1,i) == 1)
            false_negative_test = false_negative_test + 1;
        else
            false_positive_test = false_positive_test + 1;
        end
    end
    
end

test_accuracy = (num_correct_test/length(test_set_labels))*100  

sensitivity_test = true_positive_test/(true_positive_test + false_positive_test)   % sensitivity of test set

specificity_test = true_negative_test/(true_negative_test + false_negative_test)   % specificity of test set
% -------------------------------------------------------------------------