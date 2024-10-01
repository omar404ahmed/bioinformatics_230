#!/bin/bash

GENOME_DIR="/home/ahmedo/ncbi_dataset/data"

# Output files
OUTPUT_FILE="temp_output.fna"
ALL_COUNTS_FILE="all_gene_counts.txt"
RESULTS_FILE="prodigal_results.txt"


MAX_GENES=0
MAX_GENOME=""

# Clear previous results
> "$ALL_COUNTS_FILE"

# Process each genome
for genome in $(find "$GENOME_DIR" -type f -name "*GCF*.fna"); do
    prodigal -i "$genome" -d "$OUTPUT_FILE" -q
    gene_count=$(grep -c ">" "$OUTPUT_FILE")
    echo "$genome: $gene_count" >> "$ALL_COUNTS_FILE"
    if [ "$gene_count" -gt "$MAX_GENES" ]; then
        MAX_GENES=$gene_count
        MAX_GENOME=$genome
    fi
done


result="Genome with the highest number of genes:
File: $MAX_GENOME
Number of genes: $MAX_GENES"

echo "$result"
echo "$result" > "$RESULTS_FILE"

# Clean up
rm "$OUTPUT_FILE"
