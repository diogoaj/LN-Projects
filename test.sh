python scripts/word2fst.py $1 > number.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt number.txt | fstarcsort > number.fst

fstcompose number.fst descodifica.fst | fstshortestpath | fstproject --project_output | fstrmepsilon | fstprint --acceptor --isymbols=./syms.txt > resultado.txt

cat resultado.txt
