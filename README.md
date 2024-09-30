# Bioinformatics_230
This repository contains notebooks and submissions for the couse Foundations of Bioengineering Lab

## Week 5 : Genome Annotation



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
