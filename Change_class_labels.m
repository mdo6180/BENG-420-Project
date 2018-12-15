clear
close all

training_set = csvread('train.csv',1,1);    % read file and remove first row (labels) and first column (encounter_id)
training_class_labels = training_set(:,end);
training_features = training_set(:,1:end-1);

mdl = fitcknn(training_features, training_class_labels,'NumNeighbors',1);   % knn model

% predicting validation set -----------------------------------------------
validation_set = csvread('validation.csv',1,1);
validation_class_labels = validation_set(:,end);
validation_features = validation_set(:,1:end-1);

predict_valid = predict(mdl, validation_features);  % predict labels of validation set

num_correct_validation = 0;
true_positive_validation = 0;
true_negative_validation = 0;
false_positive_validation = 0;
false_negative_validation = 0;
for i = 1:length(predict_valid)
    if validation_class_labels(i) == predict_valid(i)   % determine number of correct predictions
        num_correct_validation = num_correct_validation + 1;
        
        if predict_valid(i) == 1    % if correct...   
            true_positive_validation = true_positive_validation + 1;    % determine true positives
        else
            true_negative_validation = true_negative_validation + 1;    % determine true negatives
        end  
    else
        if (validation_class_labels(i) == 0) && (predict_valid(i) == 1) % determine false positives
            false_positive_validation = false_positive_validation + 1;  
        else
            false_negative_validation = false_negative_validation + 1;  % determine false negatives
        end
    end
    
end

% validation accuracy = 88.6176%
validation_accuracy = (num_correct_validation/length(validation_class_labels))*100  

num_positive_validation = sum(validation_class_labels(:) == 1);
sensitivity_validation = true_positive_validation/(num_positive_validation)     % sensitivity of validation

num_negative_validation = sum(validation_class_labels(:) == 0);
specificity_validation = true_negative_validation/(num_negative_validation)     % specificity of validation

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
sensitivity_test = true_positive_test/(num_positive_test)   % sensitivity of test set

num_negative_test = sum(test_class_labels(:) == 0);
specificity_test = true_negative_test/(num_negative_test)   % specificity of test set

