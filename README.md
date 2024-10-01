# Bioinformatics_230
This repository contains notebooks and submissions for the couse Foundations of Bioengineering Lab

## Week 5 : Genome Annotation

The final week of the Bioinformatics module deals with bash scripts and Genome Annotation tools like Prokka and Prodigal.

### Count number of AA and Bases for a given sequence

```
given_aa = "KVRMFTSELDIMLSVNGPADQIKYFCRHWT*"

len_aa = len(given_aa) - 1 # -1 to exclude stop codon *

number_bases = (len(given_aa)) * 3

print(f"Number of amino acids: {len_aa}")
print(f"Number of bases in ORF: {number_bases}")

*OUTPUT*
Number of amino acids: 30
NUmber of bases in ORF: 93
```

## Prodigal
### Running Prodigal on e.coli_genome.fna

```
ml load prodigal
prodigal -i e.coli_genome.fna -o e.coli.gbk -d e.coli_genes.faa
grep ">" e.coli_genes.fna -c > gene_count.txt
```
[gene_count_e.coli](gene_count.txt)

### Script to run Prodigal on downloaded genomes

```
nano prodigal_script.sh
bash ./prodigal_script.sh
```
The output of the script is [prodigal_results.txt](prodigal_results.txt) which contains the genome filename with highest number of genes.


## Prokka

### Annotate all downloaded genomes using Prokka

```
nano prokka_script.sh
bash ./prokka_script.sh
```
The output of [prokka_script.sh](prokka_script.sh) are [prokka_cds_counts.txt](prokka_cds_counts.txt) and [prokka_final_result.txt](prokka_final_result.txt).


#### We observe that the highest gene count found by Prokka and Prodigal are different (3589 and 3594 respectively). This can be attributed to the different filters used by both tools. However, it is of note that the values differ by just 0.14%.


### Extract and list all unique gene names annotated by Prokka



## Week 4 : Gene Finder
The Gene Finder is implemented in this [repository](https://github.com/omar404ahmed/gene_finder)


## Week 3 : Data Wrangling

The required dataset was downloaded from [NCBI Dataset website](https://www.ncbi.nlm.nih.gov/datasets/genome/?taxon=2&assembly_level=3:3&release_year=1980:2001).

Brief description of the dataset:
* 14 Complete bacterial genomes sequences as FASTA files.
* The metadata includes GC perceatage, Genome sizes (in Mb), Contig N50, Scaffold count (among others).

Downloaded zip file was sent to home directory using:

```
scp /Users/omar/Downloads/ncbi_dataset.zip ahmedo@ilogin.ibex.kaust.edu.sa:/home/ahmedo
```

![Alt text](/Screenshots/send.png?raw=true)


Downloaded zip file could also be uploaded to the git repository which can be cloned to the ibex cluster.

```
git clone https://github.com/omar404ahmed/bioinformatics_230
```

<!--- image 1 here--->
![Alt text](/Screenshots/Clone.png?raw=true)


File can be easily decompressed using:

```
unzip ncbi_dataset.zip
```



### Smallest and Largest Genome

The smallest and largest gemone can be obtained by sorting based on the gene sizes which is column 11 in the dataframe. Using ```head -n 1``` and ```tail -n 1``` in conjuction with the pipeline we can output only the line with smallest and largest genomes respctively. The result is stored in output.txt

```
*smallest*
tail -n+2 data_summary.tsv | cut -f 1,11 | sort -t$'\t' -n -k2 | head -n 1 >> output.txt
*largest*
tail -n+2 data_summary.tsv | cut -f 1,11 | sort -t$'\t' -n -k2 | tail -n 1 >> output.txt
```


To output only the genome size appending ```awk '{print $NF}'``` to above pipeline returns the last column which contains only the size of the genome.

```
*smallest*
tail -n+2 data_summary.tsv | cut -f 1,11 | sort -t$'\t' -n -k2 | head -n 1 | awk '{print $NF}' >> output.txt
*largest*
tail -n+2 data_summary.tsv | cut -f 1,11 | sort -t$'\t' -n -k2 | tail -n 1 | awk '{print $NF}' >> output.txt
```

### Find number of genomes with at least two "c"

For this task the regex ```'c.*c"``` gives us strings with at least two "c" in them. Using ```grep -ic 'c.*c``` we can obtain the desired number.

```tail -n +2 ncbi_dataset.tsv | cut -f 3 | uniq -d | grep -ic 'c.*c' >> output.txt```


#### Find number of genomes with at least two "c" but not the word 'coccus'

Using ```grep -cv 'coccus'``` with previous command allows us to ignore the word 'coccus' from the word count.

```tail -n +2 ncbi_dataset.tsv | cut -f 3 | uniq -d | grep -io 'c.*c' | grep -cv 'coccus' >> output.txt```


### Fing .fna files greater than 3MB

Using ```find``` command tests, namely ```name``` and ```size```, we can achieve the task at hand.

```find -name '*.fna' -size +3M | wc -l >> output.txt```


### The results of all commands were appended to a file titled 'output.txt'.

The file output.txt was added to the cloned repository and then commited and pushed to main.
