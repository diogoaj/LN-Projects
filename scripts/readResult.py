with open("resultado.txt", "r") as f:
	lines = f.readlines()
	f.close()

lines = lines[2:] + [lines[0]]

sol = ""

for line in lines:
	l = line.split("\t")
	sol += l[2].replace("\n", "")

print sol[::-1]