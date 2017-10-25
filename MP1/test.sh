python scripts/word2fst.py $1 > number.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt number.txt | fstarcsort > number.fst

fstcompose number.fst codificador.fst | fstshortestpath | fstproject --project_output | fstrmepsilon | fstprint --acceptor --isymbols=./syms.txt > resultado.txt

python scripts/readResult.py