#Primeiro passo para traduzir de numeracao arabe para numeracao romana
python scripts/compact2fst.py mini_romanos_1.txt > mini_romanos_1_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt mini_romanos_1_extend.txt | fstarcsort > mini_romanos_1.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait mini_romanos_1.fst | dot -Tpdf > mini_romanos_1.pdf

python scripts/compact2fst.py mini_romanos_2.txt > mini_romanos_2_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt mini_romanos_2_extend.txt | fstarcsort > mini_romanos_2.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait mini_romanos_2.fst | dot -Tpdf > mini_romanos_2.pdf

python scripts/compact2fst.py mini_romanos_3.txt > mini_romanos_3_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt mini_romanos_3_extend.txt | fstarcsort > mini_romanos_3.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait mini_romanos_3.fst | dot -Tpdf > mini_romanos_3.pdf


#Transdutor Romano
fstcompose mini_romanos_1.fst mini_romanos_3.fst > temp.fst
fstcompose temp.fst mini_romanos_2.fst > romanos.fst

#PDF Transdutor Romano
fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt romanos.fst | dot -Tpdf > romanos.pdf

# Transdutor 1
#
#
#

# Transdutor 2
python scripts/compact2fst.py t2.txt > t2_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt t2_extend.txt | fstarcsort > t2.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait t2.fst | dot -Tpdf > t2.pdf

# Transdutor 3
python scripts/compact2fst.py t3.txt > t3_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt t3_extend.txt | fstarcsort > t3.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait t3.fst | dot -Tpdf > t3.pdf