#!/usr/bin/perl
#Used by gtf_rp322.pl to determine features of a .gtf file.

use strict;
use warnings;

package GTFrp322;

my (@geneids, %genes, @exons, $genes, @exoncounts);
my ($exons, $average, $maxcount, $maxname, $keys, @exoncount, @genes);
my (@start, @end, $count, $length, $total, %exoncount, $file, @results, $num);
my (@lines, $gene, @features);
sub countGenes { #Determines total gene count
	($file) = @_;
	@geneids = ($file =~ /\tgene_id "(.*?)";/g);  
	foreach (@geneids) {
		unless ($genes{$_}) {
			$genes{$_} = 1;
		}  
	}
	$keys = (keys %genes);
	return ($keys);
}

sub countExons { #Determines total exon count
	($file) = @_;
	$exons = $file =~ s/\texon\t/\texon\t/g;
	return ($exons);
}

sub averageExon{ #Determines average exon length
	($file) = @_;
	@results = $file =~ /exon.*?(\d+).*?(\d+)[^\n]*?gene_id ".*?";/g;
	$count = 0;
	$total = 0;
	foreach (@results) {
		if ($count % 2 == 0){
			$length = abs($results[$count] - $results[$count + 1])+1;
			$total += $length; 
		}
		$count ++;
	}
	$average = $total / ($count/2);
	return $average;
}

sub highestExon{ #Determines highest exon count
	($file) = @_;
	__exonutil();
	$maxcount = 0;
	$maxname = "No exons found";
	@genes = keys %exoncount;
	foreach (@genes){
		if ($exoncount{$_} > $maxcount) {
		$maxcount = $exoncount{$_};
		$maxname = $_;
		}
	}
	return ($maxname, $maxcount);
}
sub geneFeatures{
	($file,$gene) = @_;
	@lines = split /\n/,$file;
	foreach (@lines){
		if ($_=~ /\tgene_id "$gene"/){
			push @features, $_; 
		}
	}
	return @features;
}

sub geneList{
	($file) = @_;
	@geneids = ($file =~ /\tgene_id "(.*?)";/g);  
	foreach (@geneids) {
		unless ($genes{$_}) {
			$genes{$_} = 1;
		}  
	}
	return keys %genes;
}

sub __exonutil { #Populates %exoncount with keys being gene_ids and values exon counts
	# Double underscore used to denote as private method
	@exons = ($file =~ /exon.*?[^\n]*gene_id "(.*?)";/g);
	#Clears hash
	%exoncount =();
	foreach (@exons) {
		if ($exoncount{$_}) {
			$exoncount{$_} ++;
		}  
		else {
		$exoncount{$_} = 1;
		}
	}
};
1;
