import csv

# for max_glu_serum: 2 = '>200', 1 = '>300', 0 = normal
# for A1Cresult: 2 = '>8', 1 = '>7', 0 = 'normal'
# for diabetesMed: 1 = 'Yes', 0 = 'No' 
# for readmitted: 2 = '<30', 1 = '>30', 0 = 'No'

# catch weight = '?'

race = ['Caucasian', 'Asian', 'AfricanAmerican', 'Hispanic', 'Other']
gender = ['Male','Female','unknown/invalid']
age = ['[0-10)', '[10-20)', '[20-30)', '[30-40)', '[40-50)', '[50-60)', '[60-70)', '[70-80)', '[80-90)', '[90-100)']
weight = ['[0-25)', '[25-50)', '[50-75)', '[75-100)', '[100-125)', '[125-150)', '[150-175)', '[175-200)', '>200']
	
def rename(dict):

	if dict['age'] != '?' and dict['race'] != '?' and dict['weight'] != '?' and dict['max_glu_serum'] != 'None' and dict['A1Cresult'] != 'None':
	
		return {'encounter_id': dict['encounter_id'],
				'race': dict['race'], 
				'gender': dict['gender'], 
				'age': dict['age'], 
				'weight': dict['weight'], 
				'number_emergency': int(dict['number_emergency']),
				'number_inpatient': int(dict['number_inpatient']),
				'max_glu_serum': dict['max_glu_serum'],
				'A1Cresult': dict['A1Cresult'],
				'diabetesMed': dict['diabetesMed'],
				'readmitted': dict['readmitted']}
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
	header = ['encounter_id', 'race', 'gender','age','weight','number_emergency','number_inpatient','max_glu_serum','A1Cresult','diabetesMed','readmitted']
	writer = csv.DictWriter(myfile, fieldnames = header)
	
	writer.writeheader()
	
	for i in data:
		writer.writerow(i)
