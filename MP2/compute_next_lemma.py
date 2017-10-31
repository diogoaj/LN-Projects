from nltk.corpus import brown
from nltk.probability import LidstoneProbDist, WittenBellProbDist

estimator = lambda fdist, bins: LidstoneProbDist(fdist, 0.2)
lm = NgramModel(3, brown.words(categories='news'), estimator)

print lm.prob("word", ["This is a context which generates a word"])