
'''
from nltk.corpus import brown
from nltk.probability import LidstoneProbDist, WittenBellProbDist
from nltk.model.ngram import NgramModel

estimator = lambda fdist, bins: LidstoneProbDist(fdist, 0.2)
lm = NgramModel(3, brown.words(categories='news'), estimator)

# https://stackoverflow.com/questions/6462709/nltk-language-model-ngram-calculate-the-prob-of-a-word-from-context

print lm.prob("word", ["This is a context which generates a word"])
'''

def prob_laplace(wn, wnminusone, v):
	return (wn+1)/(wnminusone+v)

def process_param_file(file_param):
	f = open(file_param, "r")
	words = f.readlines()[1].split(" ")[0:2]
	return words

def vocabulary_size(unigramfile):
	f = open(unigramfile, "r")
	print len(f.readlines())

def compute_prob(unigram_file, bigram_file, param_file, sentences_file):

	param_words = process_param_file(param_file)
	v = vocabulary_size(unigram_file)
