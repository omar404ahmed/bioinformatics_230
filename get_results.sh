#!/bin/bash

# Directory containing CRISPRCasFinder results
RESULTS_DIR="CRISPRCasFinder_results"

# Function to parse JSON and extract CRISPR array information
parse_json() {
    jq -r '.Sequences[] | .Attributes.Name as $name | 
        .Attributes.CRISPR | 
        if . != null then 
            .[] | "Genome: \($name)\nCRISPR Array: \(.Name)\nNumber of spacers: \(.NumberOfSpacers)\nDR consensus: \(.DR_Consensus)\n"
        else 
            "Genome: \($name)\nNo CRISPR arrays found\n" 
        end' "$1"
}

# Main loop to process each result directory
for dir in "$RESULTS_DIR"/*_results; do
    if [ -d "$dir" ]; then
        json_file=$(find "$dir" -name "result.json")
        if [ -f "$json_file" ]; then
            echo "Results for $(basename "$dir"):"
            parse_json "$json_file"
            echo "----------------------------------------"
        else
            echo "No result.json found in $(basename "$dir")"
        fi
    fi
done

# Summary
echo "Summary:"
echo "Total genomes processed: $(ls -d "$RESULTS_DIR"/*_results | wc -l)"
echo "Genomes with CRISPR arrays: $(grep -c "CRISPR Array:" "$RESULTS_DIR"/*_results/result.json)"
