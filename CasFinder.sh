#!/bin/bash

GENOME_DIR="/home/ahmedo/ncbi_dataset/data"

OUTPUT_DIR="CRISPRCasFinder_results"

# Create output directory
mkdir -p "$OUTPUT_DIR"


find "$GENOME_DIR" -type f -name "*.fna" | while read -r genome; do
    base_name=$(basename "$genome" .fna)
    singularity exec -B $PWD CrisprCasFinder.simg perl /usr/local/CRISPRCasFinder/CRISPRCasFinder.pl \
    -so /usr/local/CRISPRCasFinder/sel392v2.so \
    -cf /usr/local/CRISPRCasFinder/CasFinder-2.0.3 \
    -drpt /usr/local/CRISPRCasFinder/supplementary_files/repeatDirection.tsv \
    -rpts /usr/local/CRISPRCasFinder/supplementary_files/Repeat_List.csv \
    -cas -def G \
    -out "$OUTPUT_DIR/${base_name}_results" \
    -in "$genome"
done

echo "CRISPRCasFinder analysis completed for all genomes."
