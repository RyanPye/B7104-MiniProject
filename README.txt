# B7104-MiniProject

Program is run from the commandline. 
Please use perl gtfparser.pl followed by flags or make the script executable to run as gtfparser.pl 
The script uses flags to select the .gtf file for parsing and to select the desired feature set.

The file is selected using the flag -f file_address
Use -g to return number of genes.
Use -e to return number of exons.
Use -a to return average exon length.
Use -n to return gene with the highest exon count.
Use -d to change divider on return list of gene_ids.
Use -r gene_id to return the range of a gene.
Use -m gene_id to return all features associated with the gene.
Use -l to return all gene_ids. 
Use -o output_address to print results to file.

All results are printed to the terminal unless an -o flag is given.
The output is printed with header lines marked by a # for easy searching when printed to file
Output is printed in the order
  Number of genes
  Number of exons
  Average exon length
  Highest exon gene
  Gene range
  Gene features
  List of all genes
  
For example to find the number of genes and all gene_ids a gtffile.gtf and print to output file output.txt use the command

perl gtfparser.pl -f gtffile.gtf -o output.txt -gl

To find all features associated with the gene geney001 in gtffile.gtf and print them in .gtf format to geney001features.txt use

perl gtfparser.pl -f gtffile.gtf -m geney001 -o geney001features.txt

If the gene_ids returned by -l are desired in a different format use -l='seperator'
For example to list all genes in gtffile.gtf seperated by a space followed by a  , use 

perl gtfparser.pl -f gtffile.gtf -l -d ' ,' 
If no space is required in the seperator then the '' are not needed. 
