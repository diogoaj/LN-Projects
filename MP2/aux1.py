# -*- coding: utf-8 -*-

def final(f, word):
	file_input = open(f, "r")
	output = f.split(".")
	file_output = open(output+".final", "w")
	
	
	for line in file_input.readlines():
		row = line.split("\t")
		
		if "n-é-verbo" not in row[0] and line.count(word) == 1 and "#" not in row[0] and "?" not in row[0] :
			file_output.write(line.replace(word, row[0])[(len(word)+len("\t")):])
	
	file_input.close()
	file_output.close()