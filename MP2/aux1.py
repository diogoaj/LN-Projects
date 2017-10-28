# -*- coding: utf-8 -*-

def final(f, word):
	file_input = open(f, "r")
	file_output = open("criamCrerCriar.final", "w")
	matrix = []
	
	for line in file_input.readlines():
		row = line.split("\t")
		
		if "n-é-verbo" not in row[0] and line.count("criam") == 1 and "#" not in row[0] and "?" not in row[0] :
			file_output.write(line.replace("criam", "criar")[(len(word)+len("\t")):])
	
	file_input.close()
	file_output.close()