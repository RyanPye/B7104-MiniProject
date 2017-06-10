# B7104-MiniProject

Program is run from the commandline. 
Please use perl gtfparser.pl followed by flags or make the script executable to run as gtfparser.pl 
The script uses flags to select the .gtf file for parsing and to select the desired feature set.

The file is selected using the flag -f=file_address
Use -g to return number of genes.
Use -e to return number of exons.
Use -a to return average exon length.
Use -n to return gene with the highest exon count.
Use -l to return all gene_ids. 
Use -m=gene_id to return all features associated with the gene.
Use -o=output_address to print results to file.

All results are printed to the terminal unless an -o flag is given.

