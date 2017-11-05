#!/bin/bash

# Processa os ficheiros anotados e guarda em ficheiros com a extensão ".final"
echo "[*] Converting .out to .final..."
python process_files.py

echo "[*] Computing unigrams and bigrams..."
# Calcula os unigramas e os bigramas de cada ficheiro
python calculate_ngrams.py

# Calcula as probabilidades de cada frase de teste e imprime no ecra o lema mais provavel
echo "[*] Computing probabilities for word 1..."
python compute_probabilities.py palavra1Unigramas.txt palavra1Bigramas.txt palavra1Parametrizacao.txt palavra1Frases.txt

echo "[*] Computing probabilities for word 2..."
python compute_probabilities.py palavra2Unigramas.txt palavra2Bigramas.txt palavra2Parametrizacao.txt palavra2Frases.txt

echo "[*] Done"