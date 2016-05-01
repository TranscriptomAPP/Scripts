#!/usr/bin/env perl

# script to take the trimmomatic output printed to the terminal window for plotting in R

#reads file name (of captured trimmomatic output) from command line.
$filename=$ARGV[0];
#extracts sample name
$sampleName = $filename;
$sampleName =~ s/\.tmp//;
$sampleName =~ s/LOG//;
$sampleName =~ s/(\w*\/)*//;

#reads file and extracts the read pair info
open($FH, "<", $filename);
while($line = <$FH>){
	if($line !~ m/^Input Read/){
		next;
	}else{
		@data = split(":", $line);
		$inputReads = (split(" ", $data[1]))[0] ;
		$bothSurviving = (split(" ", $data[2]))[0];
		$fwOnly = (split(" ", $data[3]))[0];
		$rvOnly = (split(" ", $data[4]))[0];
		$dropped = (split(" ", $data[5]))[0];
	}
}
close($FH);

#prints read pair info to file specified in command line.
$,="\t";
print $sampleName, "\"$inputReads\"", "\"$bothSurviving\"", "\"$fwOnly\"", "\"$rvOnly\"", "\"$dropped\"\n";

exit;

