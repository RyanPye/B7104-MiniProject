#!/usr/bin/perl
#Front end to determine features of .gtf file. 
#Usage perl gtf_rp322.pl FILENAME flags
#Use -g to return number of genes.
#Use -e to return number of exons.
#Use -a to return average exon length.
#Use -n to return gene with the highest exon count.

use strict;
use warnings;

my $fileaddress;
my $file;
my $filecontents;
my $result;
my @results;
my %opts;
my $gene_id;
my $output;
my $seperator;

use GTFrp322;
use Getopt::Std;

getopts('hgeanld:f:r:m:o:', \%opts);

if ($opts{'h'}) {#checks if help requested
	die "
This script analyzes a .gtf file.
Please input -f file_address followed by one or more flags.
Use -g to return number of genes.
Use -e to return number of exons.
Use -a to return average exon length.
Use -n to return gene with the highest exon count.
Use -l to return all gene_ids.
Use -d to change divider on return list of gene_ids.
Use -r gene_id to return the range of a gene.
Use -m gene_id to return all features associated with the gene.
Use -o output_address to append results to file\n\n";
}

unless($opts{'f'}) { #check filename has been given 
	die "
Please input -f file_address followed by one or more flags.
Use -h for help";
}

#shift fileaddress out of @ARGV
$fileaddress = $opts{'f'};

#open file
open $file, '<', $fileaddress or die "Could not open file.\n Please input file address follwed by one or more flags";
{
#converts file into single string variable 
	local $/ = undef;
	$filecontents = <$file>;
}
#closes file
close $file;
if ($opts{'o'}){
	$output = $opts{'o'};
	open OUTPUT, '>>', "$output";
	print "Sending output to $output\n";
	STDOUT->fdopen( \*OUTPUT, 'w' ) or die $!;
}


if ($opts{'g'}){
	$result = GTFrp322::countGenes($filecontents);
	print "# Number of genes: $result\n";
}
if ($opts{'e'}){
	$result = GTFrp322::countExons($filecontents);
	print "# Number of exons: $result\n";
}
if ($opts{'a'}){
	$result = GTFrp322::averageExon($filecontents);
	print "# Average exon length: $result\n";
}
if ($opts{'n'}){
	@results = GTFrp322::highestExon($filecontents);
	print "# Highest exon gene: $results[0]\nWith exon count: $results[1]\n";
}

if ($opts{'r'}){
	$gene_id = $opts{'r'};
	@results = GTFrp322::geneRange($filecontents, $gene_id);
	print "# Gene range of $gene_id\nStart position $results[0]\nEnd position $results[1]\nRange $results[2]\n";
}	

if ($opts{'m'}){
	$gene_id = $opts{'m'};
	@results = GTFrp322::geneFeatures($filecontents, $gene_id);
	print "# Gene features of $gene_id\n";
	if (@results){
		foreach (@results){
			print "$_\n";
		}
	}
	else{
		print "Gene not found\n";
	}
}

if ($opts{'l'}){
	@results = GTFrp322::geneList($filecontents);
	print "# Genes in $fileaddress\n";
	@results = sort { lc($a) cmp lc($b) } @results;
	$seperator = "\n";
	if ($opts{'d'}){
		$seperator = $opts{'d'};
	}
	foreach (@results){
		print "$_$seperator";
	}
}

