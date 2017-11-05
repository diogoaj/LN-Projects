"""
Grupo 38
77974 - Joao Varandas
77999 - Diogo Jeronimo
"""

from nltk import word_tokenize
from nltk.util import ngrams
import sys

def prob_laplace(wn, wnminusone, v):
	return (float(wn)+1)/(float(wnminusone)+v)

def process_param_file(file_param):
	f = open(file_param, "r")
	lines = f.readlines()
	words = lines[1].split(" ")[0:2]
	words.append(lines[0].replace("\n", ""))
	return words

def vocabulary_size(unigramfile):
	f = open(unigramfile, "r")
	return len(f.readlines())

def ngram_dict(ngramfile):
	res = {}
	f = open(ngramfile, "r")
	lines = f.readlines()

	for sentence in lines:
		row = sentence.split("\t")
		res[row[0]] = row[1][0]

	return res

def unigram_prob(unigram, uni_dic, v):
	if unigram in uni_dic:
		return prob_laplace(uni_dic[unigram], uni_dic[unigram], v)
	else:
		return prob_laplace(1, 1, v)

def bigram_prob(bigram, unigram, uni_dic, bi_dic, v):
	if bigram in bi_dic and unigram in uni_dic :
		return prob_laplace(bi_dic[bigram], uni_dic[unigram], v)
				
	elif bigram not in bi_dic and unigram in uni_dic:
		return prob_laplace(1, uni_dic[unigram], v)

	elif bigram not in bi_dic and unigram not in uni_dic:
		return prob_laplace(1, 1, v)

def sentence_probability(uni_dic, bi_dic, sentence, v):
	tokens = word_tokenize(sentence)
	unigram1 = tokens[0]
	unigram2 = tokens[-1]

	bigrams = ngrams(tokens, 2)

	prob = 1

	prob *= unigram_prob(unigram1, uni_dic, v)
	prob *= unigram_prob(unigram1, uni_dic, v)

	for b in bigrams:
		bigram = b[0] + " " + b[1]
		prob *= bigram_prob(bigram, b[0], uni_dic, bi_dic, v)

	return prob

def generate_output(res, param):
	
	for string in res:
		aux = res[string].split(";")
		print string.replace("\r\n", "") + ":" + " " + aux[0] + " " + "-> " + "prob." + param[0] + "=" + aux[1] + "; " + "prob." + param[1] + "=" + aux[2]
	
def compute_lemma(unigram_file, bigram_file, param_file, sentences_file):

	param_words = process_param_file(param_file)
	v = vocabulary_size(unigram_file)
	unigram_values = ngram_dict(unigram_file)
	bigram_values = ngram_dict(bigram_file)
	res = {}

	sentences = open(sentences_file, "r")
	lines = sentences.readlines()

	for string in lines:
		str1 = string.replace(param_words[2], param_words[0]).replace("\n", "")
		str2 = string.replace(param_words[2], param_words[1]).replace("\n", "")

		p1 = sentence_probability(unigram_values, bigram_values, str1, v)
		p2 = sentence_probability(unigram_values, bigram_values, str2, v)

		if p1 > p2:	
			res[string] = param_words[0]+";"+str(p1)+";"+str(p2)
		else:
			res[string] = param_words[1]+";"+str(p1)+";"+str(p2) 
	
	generate_output(res, param_words)
	return res



unigrama = sys.argv[1]
bigrama = sys.argv[2]
parametrizacao = sys.argv[3]
ficheiro_exemplo = sys.argv[4]

compute_lemma(unigrama, bigrama, parametrizacao, ficheiro_exemplo)