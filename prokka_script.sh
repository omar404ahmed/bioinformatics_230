#!/bin/bash


GENOME_DIR="/home/ahmedo/ncbi_dataset/data"

PROKKA_RESULTS="prokka_results"
CDS_COUNTS_FILE="prokka_cds_counts.txt"
FINAL_RESULTS_FILE="prokka_final_results.txt"

mkdir -p "$PROKKA_RESULTS"

MAX_CDS=0
MAX_GENOME=""

# Clear previous results
> "$CDS_COUNTS_FILE"

for genome in $(find "$GENOME_DIR" -type f -name "*GCF*.fna"); do
    base=$(basename "$genome" .fna)
    
    # Run Prokka
    prokka --outdir "$PROKKA_RESULTS/$base" --prefix "$base" "$genome" --cpus 4 --force
    
    # Count CDS
    cds_count=$(grep -c "CDS" "$PROKKA_RESULTS/$base/$base.gff")
    echo "$genome: $cds_count" >> "$CDS_COUNTS_FILE"
    
    # Update max CDS if necessary
    if [ "$cds_count" -gt "$MAX_CDS" ]; then
        MAX_CDS=$cds_count
        MAX_GENOME=$genome
    fi
done

# Prepare and output the result
result="Genome with the highest number of CDS (Prokka):
File: $MAX_GENOME
Number of CDS: $MAX_CDS"

echo "$result"
echo "$result" > "$FINAL_RESULTS_FILE"

