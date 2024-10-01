given_aa = "KVRMFTSELDIMLSVNGPADQIKYFCRHWT*"

len_aa = len(given_aa) - 1 # -1 to exclude stop codon *

number_bases = (len(given_aa)) * 3

print(f"Number of amino acids: {len_aa}")
print(f"Number of bases in ORF: {number_bases}")
