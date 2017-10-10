# Transdutores auxiliares do Transdutor Romanos
python scripts/compact2fst.py transdutor_romanos_auxiliar1.txt > transdutor_romanos_auxiliar1_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt transdutor_romanos_auxiliar1_extend.txt | fstarcsort > transdutor_romanos_auxiliar1.fst

python scripts/compact2fst.py transdutor_romanos_auxiliar2.txt > transdutor_romanos_auxiliar2_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt transdutor_romanos_auxiliar2_extend.txt | fstarcsort > transdutor_romanos_auxiliar2.fst

python scripts/compact2fst.py transdutor_romanos_auxiliar3.txt > transdutor_romanos_auxiliar3_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt transdutor_romanos_auxiliar3_extend.txt | fstarcsort > transdutor_romanos_auxiliar3.fst

# Transdutor Romanos
fstcompose transdutor_romanos_auxiliar1.fst transdutor_romanos_auxiliar2.fst > romanos_temp.fst
fstcompose romanos_temp.fst transdutor_romanos_auxiliar3.fst > transdutorRomanos.fst
fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt transdutorRomanos.fst | dot -Tpdf > transdutorRomanos.pdf

# Transdutor 1
python scripts/compact2fst.py transdutor1_auxiliar1.txt > transdutor1_auxiliar1_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt transdutor1_auxiliar1_extend.txt | fstarcsort > transdutor1_temp1.fst

python scripts/compact2fst.py transdutor1_auxiliar2.txt > transdutor1_auxiliar2_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt transdutor1_auxiliar2_extend.txt | fstarcsort > transdutor1_temp2.fst

fstunion transdutor1_temp1.fst transdutorRomanos.fst > union.fst 
fstconcat union.fst transdutor1_temp2.fst > concat.fst  
fstclosure -closure_plus concat.fst > transdutor1.fst

fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt transdutor1.fst | dot -Tpdf > transdutor1.pdf


# Transdutor 2
python scripts/compact2fst.py transdutor2.txt > transdutor2_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt transdutor2_extend.txt | fstarcsort > transdutor2.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait transdutor2.fst | dot -Tpdf > transdutor2.pdf

# Transdutor 3
python scripts/compact2fst.py transdutor3.txt > transdutor3_extend.txt
fstcompile --isymbols=syms.txt --osymbols=syms.txt transdutor3_extend.txt | fstarcsort > transdutor3.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait transdutor3.fst | dot -Tpdf > transdutor3.pdf


# Transdutor codificador
fstcompose transdutor1.fst transdutor2.fst > temp.fst 
fstcompose temp.fst transdutor3.fst > codificador.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait codificador.fst | dot -Tpdf > codificador.pdf

# Transdutor descodificador
fstinvert codificador.fst > descodificador.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait descodificador.fst | dot -Tpdf > descodificador.pdf