# -*- coding: utf-8 -*-

"""
Grupo 38
77974 - Joao Varandas
77999 - Diogo Jeronimo
"""


def final(f, word):
	file_input = open(f, "r")
	file_output = open(f.split(".")[0]+".final", "w")
	
	for line in file_input.readlines():
		row = line.split("\t")
		
		if "n-é-verbo" not in row[0] and line.count(word) == 1 and "#" not in row[0] and "?" not in row[0] :
			file_output.write(line.replace(word, row[0].lower())[(len(row[0])+len("\t")):])
	
	file_input.close()
	file_output.close()


if __name__ == "__main__":
	final("palavra1Anotado.out", "fomos")
	final("palavra2Anotado.out", "criam")