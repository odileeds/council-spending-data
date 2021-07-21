#!/usr/bin/perl


$filedir = $ARGV[0];

# Add in files we've previously obtained that no longer exist
opendir(my $dh, $filedir);
my @files = readdir($dh);
closedir $dh;
for($i = 0; $i < @files; $i++){
	if($files[$i] =~ /([0-9]{4}-.*)\_([^\_]+)\.csv/){
		$temp = $1;
		$key = ($2||"raw");
		if(!-d $filedir."/".$key){
			print "No directory for $key\n";
		}else{
			#print "mv $filedir/$files[$i] $filedir/$key/$temp.csv\n";
			`git mv $filedir/$files[$i] $filedir/$key/$temp.csv`;
		}
#		if(!$gotmonth{$temp}){ $gotmonths{$temp} = $filedir.$files[$i]; }
	}
}