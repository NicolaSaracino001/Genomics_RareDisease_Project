#!/bin/bash
# FASE 5: Filtraggio per modelli di ereditarietà e qualità
# Utilizzo indici numerici posizionali (0=child, 1=father, 2=mother)

VCF_DIR="$HOME/Genomics_Project/03_VariantCalling"
cd ${VCF_DIR}

# Autosomica Recessiva (Caso 610)
bcftools view -i 'GT[0]="1/1" && GT[1]="0/1" && GT[2]="0/1" && QUAL>20' case610_trio.vcf > case610_final.vcf

# Autosomica Dominante (Casi 683, 657, 586, 681)
for case in 683 657 586 681; do
    bcftools view -i 'GT[0]="0/1" && ((GT[2]="0/1" && GT[1]="0/0") || (GT[2]="0/0" && GT[1]="0/1") || (GT[2]="0/0" && GT[1]="0/0")) && QUAL>20' case${case}_trio.vcf > case${case}_final.vcf
done