import csv

# fro age: 0 = '[0-10)', 1 = '[10-20)', 2 = '[20-30)', 3 = '[30-40)', 4 = '[40-50)', 5 = '[50-60)', 6 = '[60-70)', 7 = '[70-80)', 8 = '[80-90)', 9 = '[90-100)'
# for weight: 0 = '[0-25)', 1 = '[25-50)', 2 = '[50-75)', 3 = '[75-100)', 4 = '[100-125)', 5 = '[125-150)', 6 = '[150-175)', 7 = '[175-200)', 8 = '>200'
# for diabetesMed: 0 = 'No', 1 = 'Yes'
# for readmitted: 0 = 'No', 1 = '<30', 2 = '>30'

race = ['Caucasian', 'Asian', 'AfricanAmerican', 'Hispanic', 'Other']
gender = ['Male','Female','unknown/invalid']
age = ['[0-10)', '[10-20)', '[20-30)', '[30-40)', '[40-50)', '[50-60)', '[60-70)', '[70-80)', '[80-90)', '[90-100)']
weight = ['[0-25)', '[25-50)', '[50-75)', '[75-100)', '[100-125)', '[125-150)', '[150-175)', '[175-200)', '>200']
diabetesMed = ['No', 'Yes']
readmitted = ['NO', '<30', '>30']

def rename(dict):

	if (dict['age'] in age) and (dict['race'] in race) and (dict['weight'] in weight):
	
		return {'encounter_id': dict['encounter_id'],
				'race': race.index(dict['race']), 
				'gender': gender.index(dict['gender']), 
				'age': age.index(dict['age']), 
				'weight': weight.index(dict['weight']), 
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
			
print(len(data))


with open('./cleaned.csv', 'w', newline = '') as myfile:
	header = ['encounter_id', 'race', 'gender','age','weight','number_emergency','number_inpatient','diabetesMed','readmitted']
	writer = csv.DictWriter(myfile, fieldnames = header)
	
	writer.writeheader()
	
	for i in data:
		writer.writerow(i)
