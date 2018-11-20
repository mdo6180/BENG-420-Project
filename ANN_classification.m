clear
close all

training_group1 = csvread('training_group1.csv');
train1 = training_group1(:,1:end-1)';
t1 = [(training_group1(:,end) == 0) (training_group1(:,end) == 1) (training_group1(:,end) == 2)]';

training_group2 = csvread('training_group2.csv');
train2 = training_group2(:,1:end-1)';
t2 = [(training_group2(:,end) == 0) (training_group2(:,end) == 1) (training_group2(:,end) == 2)]';

training_group3 = csvread('training_group3.csv');
train3 = training_group3(:,1:end-1)';
t3 = [(training_group3(:,end) == 0) (training_group3(:,end) == 1) (training_group3(:,end) == 2)]';

training_group4 = csvread('training_group4.csv');
train4 = training_group4(:,1:end-1)';
t4 = [(training_group4(:,end) == 0) (training_group4(:,end) == 1) (training_group4(:,end) == 2)]';

% ANN for Group1 ----------------------------------------------------------
net1 = linearlayer;
net1 = configure(net1, zeros(size(train1,1) , 1), zeros(size(t1,1) , 1));
net1.performFcn = 'sse';     % use sum squared error
net1.trainParam.epochs = 100;
net1.trainFcn = 'trainlm';   % use Levenberg-Marquardt backpropagation because it's the fastest backpropagation algorithm in the toolbox 

net1 = train(net1, train1, t1);

labels_train1 = net1(train1);
perf_train1 = perform(net1, t1, labels_train1)
prediction_train1 = round(labels_train1);     % round predicted values to nearest integer (either 1 or 0) 

figure(1)
plotconfusion(t1, prediction_train1, 'Training Group1')
% -------------------------------------------------------------------------

% ANN for Group2 ----------------------------------------------------------
net2 = linearlayer;
net2 = configure(net2, zeros(size(train2,1) , 1), zeros(size(t2,1) , 1));
net2.performFcn = 'sse';     % use sum squared error
net2.trainParam.epochs = 100;
net2.trainFcn = 'trainlm';   % use Levenberg-Marquardt backpropagation because it's the fastest backpropagation algorithm in the toolbox 

net2 = train(net2, train2, t2);

labels_train2 = net2(train2);
perf_train2 = perform(net2, t2, labels_train2)
prediction_train2 = round(labels_train2);     % round predicted values to nearest integer (either 1 or 0) 

figure(2)
plotconfusion(t2, prediction_train2, 'Training Group2')
% -------------------------------------------------------------------------

% ANN for Group3 ----------------------------------------------------------
net3 = linearlayer;
net3 = configure(net3, zeros(size(train3,1) , 1), zeros(size(t3,1) , 1));
net3.performFcn = 'sse';     % use sum squared error
net3.trainParam.epochs = 100;
net3.trainFcn = 'trainlm';   % use Levenberg-Marquardt backpropagation because it's the fastest backpropagation algorithm in the toolbox 

net3 = train(net3, train3, t3);

labels_train3 = net3(train3);
perf_train3 = perform(net3, t3, labels_train3)
prediction_train3 = round(labels_train3);     % round predicted values to nearest integer (either 1 or 0) 

figure(3)
plotconfusion(t3, prediction_train3, 'Training Group3')
% -------------------------------------------------------------------------

% ANN for Group4 ----------------------------------------------------------
net4 = linearlayer;
net4 = configure(net4, zeros(size(train4,1) , 1), zeros(size(t4,1) , 1));
net4.performFcn = 'sse';     % use sum squared error
net4.trainParam.epochs = 100;
net4.trainFcn = 'trainlm';   % use Levenberg-Marquardt backpropagation because it's the fastest backpropagation algorithm in the toolbox 

net4 = train(net4, train4, t4);

labels_train4 = net4(train4);
perf_train4 = perform(net4, t4, labels_train4)
prediction_train4 = round(labels_train4);     % round predicted values to nearest integer (either 1 or 0) 

figure(4)
plotconfusion(t4, prediction_train4, 'Training Group4')
% -------------------------------------------------------------------------

disp(size(training_group1,1))
disp(size(training_group2,1))
disp(size(training_group3,1))
disp(size(training_group4,1))