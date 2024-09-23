# Bioinformatics_230
This repository contains notebooks and submissions for the couse Foundations of Bioengineering Lab
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
tail -n+2 data_summary.tsv | cut -f 1,11 | sort -t$'\t' -n -k2 | uniq | head -n 1 >> output.txt
*largest*
tail -n+2 data_summary.tsv | cut -f 1,11 | sort -t$'\t' -n -k2 | uniq | tail -n 1 >> output.txt
```


To output only the genome size appending ```awk '{print $NF}'``` to above pipeline returns the last column which contains only the size of the genome.

```
*smallest*
tail -n+2 data_summary.tsv | cut -f 1,11 | sort -t$'\t' -n -k2 | uniq | head -n 1 | awk '{print $NF}' >> output.txt
*largest*
tail -n+2 data_summary.tsv | cut -f 1,11 | sort -t$'\t' -n -k2 | uniq | tail -n 1 | awk '{print $NF}' >> output.txt
```
