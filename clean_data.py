import csv

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
