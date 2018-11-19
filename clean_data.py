import csv
import math

# for age: 0 = '[0-10)', 1 = '[10-20)', 2 = '[20-30)', 3 = '[30-40)', 4 = '[40-50)', 5 = '[50-60)', 6 = '[60-70)', 7 = '[70-80)', 8 = '[80-90)', 9 = '[90-100)'
# for diabetesMed: 0 = 'No', 1 = 'Yes'
# for readmitted: 0 = 'No', 1 = '<30', 2 = '>30'

race = ['Caucasian', 'Asian', 'AfricanAmerican', 'Hispanic', 'Other']
gender = ['Male','Female','Unknown/Invalid']
age = ['[0-10)', '[10-20)', '[20-30)', '[30-40)', '[40-50)', '[50-60)', '[60-70)', '[70-80)', '[80-90)', '[90-100)']
diabetesMed = ['No', 'Yes']
readmitted = ['NO', '<30', '>30']

def rename(dict):

	if (dict['age'] in age) and (dict['race'] in race):
	
		return {'encounter_id': int(dict['encounter_id']),
				'race': race.index(dict['race']), 
				'gender': gender.index(dict['gender']), 
				'age': age.index(dict['age']), 
				'number_emergency': int(dict['number_emergency']),
				'number_inpatient': int(dict['number_inpatient']),
				'diabetesMed': diabetesMed.index(dict['diabetesMed']),
				'readmitted': readmitted.index(dict['readmitted'])}
	else: 
		return None
	
data = []
with open('diabetic_data.csv', newline = '') as csvfile:
	reader = csv.DictReader(csvfile)
	
	for row in reader:
		if rename(row) != None:
			data.append(rename(row))
			
print("size of dataset = %d" % len(data))

# splitting data up into equal parts to create the training_set, validation_set, and test_set
upper_limit_train = 34000
lower_limit_val = upper_limit_train + 1
upper_limit_val = (2 * upper_limit_train) + 1
lower_limit_test = upper_limit_val + 1

training_set = data[:upper_limit_train]
validation_set = data[lower_limit_val:upper_limit_val]
test_set = data[lower_limit_test:]

print("size of training set = %d" % len(training_set))
print("size of validation set = %d" % len(validation_set))
print("size of test set = %d" % len(test_set))


# creating the training dataset
with open('./cleaned.csv', 'w', newline = '') as trainfile:
	header = ['encounter_id','race','gender','age','number_emergency','number_inpatient','diabetesMed','readmitted']
	writer = csv.DictWriter(trainfile, fieldnames = header)
	
	writer.writeheader()
	
	for i in data:
		writer.writerow(i)

# creating the training dataset
with open('./train.csv', 'w', newline = '') as trainfile:
	header = ['encounter_id','race','gender','age','number_emergency','number_inpatient','diabetesMed','readmitted']
	writer = csv.DictWriter(trainfile, fieldnames = header)
	
	writer.writeheader()
	
	for i in training_set:
		writer.writerow(i)

# creating the validation dataset
with open('./validation.csv', 'w', newline = '') as validationfile:
	header = ['encounter_id','race','gender','age','number_emergency','number_inpatient','diabetesMed','readmitted']
	writer = csv.DictWriter(validationfile, fieldnames = header)
	
	writer.writeheader()
	
	for i in validation_set:
		writer.writerow(i)
		
# creating the validation dataset
with open('./test.csv', 'w', newline = '') as testfile:
	header = ['encounter_id','race','gender','age','number_emergency','number_inpatient','diabetesMed','readmitted']
	writer = csv.DictWriter(testfile, fieldnames = header)
	
	writer.writeheader()
	
	for i in test_set:
		writer.writerow(i)
