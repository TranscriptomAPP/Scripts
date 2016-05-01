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
		$Surviving = (split(" ", $data[2]))[0];
		$dropped = (split(" ", $data[3]))[0];
	}
}
close($FH);

#prints read pair info to file specified in command line.
$,="\t";
print $sampleName, "\"$inputReads\"", "\"$Surviving\"", "\"$dropped\"\n";

exit;

