# -*- coding: utf-8 -*-

"""
Grupo 38
77974 - João Varandas
77999 - Diogo Jerónimo
"""


import string
import nltk
import locale
from nltk import word_tokenize
from nltk.util import ngrams

def read_file(filename):
	f = open(filename, "r")
	lines = f.readlines()
	f.close()
	return lines


def pre_process(line):
	line = line.lower()
	return line.translate(None, string.punctuation)


def calculate_ngrams(line):
	unigrams = word_tokenize(line)
	for unigram in unigrams:
		if unigram in unigram_dict:
			unigram_dict[unigram] += 1
		else:
			unigram_dict[unigram] = 1

	bigrams = ngrams(unigrams, 2)
	for bigram in bigrams:
		b = bigram[0] + " " + bigram[1]
		if b in bigram_dict:
			bigram_dict[b] += 1
		else:
			bigram_dict[b] = 1


def save_output(filename, d):
	f = open(filename, "w+")
	text = ""
	for key in sorted(d, cmp=locale.strcoll):
		text += "%s\t%s\n" % (key, d[key])
	f.write(text.encode("utf8"))
	f.close()


if __name__ == "__main__":
	locale.setlocale(locale.LC_ALL, "")

	unigram_dict = {}
	bigram_dict = {}

	index = 1
	files = ["palavra1Anotado.final", "palavra2Anotado.final"]

	for filename in files:	
		lines = read_file(filename)
		for line in lines:
			l = pre_process(line)
			calculate_ngrams(l.decode("utf8"))
		save_output("palavra"+str(index)+"Unigramas.txt", unigram_dict)
		save_output("palavra"+str(index)+"Bigramas.txt", bigram_dict)

		index += 1
		unigram_dict = {}
		bigram_dict = {}