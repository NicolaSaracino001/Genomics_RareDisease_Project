#!/bin/bash
# FASE 6: Annotazione funzionale delle varianti
# Utilizzo della cache offline condivisa dal docente per bypassare i blocchi di rete

VCF_DIR="$HOME/Genomics_Project/03_VariantCalling"
ANN_DIR="$HOME/Genomics_Project/04_Annotation"

mkdir -p ${ANN_DIR}
cd ${VCF_DIR}

for case in 610 683 657 586 681; do
    vep -i case${case}_final.vcf \
        -o ${ANN_DIR}/case${case}_annotated.txt \
        --tab --symbol --hgvs --canonical --offline --dir_cache /home/mchiara/.vep --force_overwrite
done