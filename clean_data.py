import csv

'''
file = open('diabetic_data.csv')
lines = file.readlines()

labels = lines[0].split(",")

print(len(lines[1].split(",")))
print(labels[2])
print(labels[3])
print(labels[4])
print(labels[5])
print(labels[16])
print(labels[17])
print(labels[22])
print(labels[23])
print(labels[48])
'''

# for max_glu_serum: 2 = '>200', 1 = '>300', 0 = normal
# for A1Cresult: 2 = '>8', 1 = '>7', 0 = 'normal'
# for diabetesMed: 1 = 'Yes', 0 = 'No' 
# for readmitted: 2 = '<30', 1 = '>30', 0 = 'No'

# catch weight = '?'

race = ['Caucasian', 'Asian', 'AfricanAmerican', 'Hispanic', 'other']
gender = ['male','female','unknown/invalid']
#age = ['[0-10)', '[10-20)', '[20-30)', '[30-40)', '[40-50)', '[50-60)', '[60-70)', '[70-80)', '[80-90)', '[90-100)']
age = []
weight = []
	
def rename(dict):

	if dict['race'] in race:
		if dict['gender'] in gender: 
			if dict['age'] != '?' and dict['weight'] != '?' and dict['max_glu_serum'] != 'none' and dict['A1Cresult'] != 'none':
			
				if dict['age'] not in age:
					age.append(dict['age'])
			
				if dict['weight'] not in weight:
					weight.append(dict['weight'])
					
				return {'encounter_id': dict['encounter_id'],
						'race': race.index(dict['race']), 
						'gender': gender.index(dict['gender']), 
						'age': age.index(dict['age']), 
						'weight': weight.index(dict['weight']), 
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
		print(row['age'])
		stop = row['age'].index('-')
		print(row['age'][1:stop])
		break
		# if rename(row) != None:
			# data.append(rename(row))
		

'''
with open('./cleaned.csv', 'w', newline = '') as myfile:
	header = ['encounter_id', 'race', 'gender','age','weight','number_emergency','number_inpatient','max_glu_serum','A1Cresult','diabetesMed','readmitted']
	writer = csv.DictWriter(csvfile, fieldnames = header)

    writer.writeheader()
	for i in data:
		writer.writerow({'race': i['race'], 'gender':i['gender'], 'age':i['age'], 'weight':i['weight'], 'number_emergency':i['number_emergency'] ,'number_inpatient','max_glu_serum','A1Cresult','diabetesMed'})
'''