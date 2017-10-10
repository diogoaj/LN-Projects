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
python scripts/compact2fst.py t1_temp1.txt > t1_temp1_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt t1_temp1_extend.txt | fstarcsort > t1_temp1.fst

python scripts/compact2fst.py t1_temp2.txt > t1_temp2_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt t1_temp2_extend.txt | fstarcsort > t1_temp2.fst

fstunion t1_temp1.fst romanos.fst > a.fst 
fstconcat a.fst t1_temp2.fst > b.fst  
fstclosure -closure_plus b.fst > transdutor1.fst


fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt transdutor1.fst | dot -Tpdf > transdutor1.pdf


# Transdutor 2
python scripts/compact2fst.py t2.txt > t2_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt t2_extend.txt | fstarcsort > t2.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait t2.fst | dot -Tpdf > t2.pdf

# Transdutor 3
python scripts/compact2fst.py t3.txt > t3_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt t3_extend.txt | fstarcsort > t3.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait t3.fst | dot -Tpdf > t3.pdf


# Transdutor codificador
fstcompose transdutor1.fst t2.fst > test1.fst 
fstcompose test1.fst t3.fst > codifica.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait codifica.fst | dot -Tpdf > codifica.pdf

# Transdutor descodifica
fstinvert codifica.fst > descodifica.fst