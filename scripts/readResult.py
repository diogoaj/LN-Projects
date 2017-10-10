with open("resultado.txt", "r") as f:
	lines = f.readlines()
	f.close()

lines = lines[2:] + [lines[0]]
print lines