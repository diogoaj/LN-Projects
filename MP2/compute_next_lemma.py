# -*- coding: utf-8 -*-

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

def sentence_probability(uni_dic, bi_dic, sentence, v):
	aux = None

	for wrd in sentence:

			word = wrd.encode('utf8')

			if(aux == None):
				if(word in uni_dic):
					prob = prob_laplace(uni_dic[word], uni_dic[word], v)
				else:
					prob = prob_laplace(1, 1, v)

			else:
				str_aux = aux + " " + word

				if(str_aux in bi_dic and aux in uni_dic):
					prob *= prob_laplace(bi_dic[str_aux], uni_dic[aux], v)
				
				elif(str_aux not in bi_dic and aux in uni_dic):
					prob *= prob_laplace(1, uni_dic[aux], v)

				elif(str_aux not in bi_dic and aux not in uni_dic):
					prob *= prob_laplace(1, 1, v)

			aux = word

	return prob


def compute_lemma(unigram_file, bigram_file, param_file, sentences_file):

	param_words = process_param_file(param_file)
	v = vocabulary_size(unigram_file)
	unigram_values = ngram_dict(unigram_file)
	bigram_values = ngram_dict(bigram_file)
	res = {}

	sentences = open(sentences_file, "r")
	lines = sentences.readlines()

	for string in lines:
		str1 = string.replace(param_words[2], param_words[0]).split(" ")
		str2 = string.replace(param_words[2], param_words[1]).split(" ")

		p1 = sentence_probability(unigram_values, bigram_values, str1, v)
		p2 = sentence_probability(unigram_values, bigram_values, str2, v)


		
		if p1 > p2:	
			res[string] = param_words[0]
		else:
			res[string] = param_words[1] 

	return res


compute_lemma("palavra1Unigramas.txt", "palavra1Bigramas.txt", "fomosParametrizacao.txt", "fomos.txt")