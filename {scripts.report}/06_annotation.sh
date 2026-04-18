#!/bin/bash
# FASE 6: Annotazione funzionale delle varianti
# Eseguito sul server il $(date)

VCF_DIR="$HOME/Genomics_Project/03_VariantCalling"
ANN_DIR="$HOME/Genomics_Project/04_Annotation"

mkdir -p ${ANN_DIR}
cd ${VCF_DIR}

for case in 610 683 657 586 681; do
    vep -i case${case}_final.vcf \
        -o ${ANN_DIR}/case${case}_annotated.txt \
        --tab --symbol --hgvs --canonical --offline --force_overwrite
done