#!/usr/bin/perl -w
#Aimed to convert numeric constants, arithmetic operation and print statements only from python to perl only.

#comp2041 assignment 1
#student id :z3447627


while ($line = <>) {
	if ($line =~ /^#!/ && $. == 1) {
		# translate #! line 
		&perlFormat;
	} 
	elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/ ) {
		# Blank & comment lines can be passed unchanged
		print $line;
	
	} 
	elsif ($line =~ /^\s*print\s*[^""]*r".*/){
			#printing raw strings
			print &perlRawPrint($line)."\n";		
	}
	elsif ($line =~ /^\s*print\s*"(.*)"\s*%/) {
			#this line is in printf-like format 
			print &perlPrintf($line)."\n";
	}
	
	elsif($line =~ /^\s*print\s/){
			#contains variable outside"" or no variables inside""
			print &perlVarPrint($line)."\n";
	}
	elsif($line =~ /[a-zA-Z0-9_]+.*=.* /){
			#normal statement assigning values to variables
			print &perlAssn($line)."\n";
	}
	 else {
	
		# Lines we can't translate are turned into comments
		
		print "#$line\n";
	}
}



sub perlAssn{
	#divide the line into 2 
	#q is the content in "" and l is the rest
	my $l = $_[0];
	my $q = "";
	$l =~ s/\"\s*\+\s*\"/\"\.\"/g;
	if($l =~ m/(\".*\")/){
	  $q = $1;
	  $l =~ s/$q//;
	}

	$l =~ s/([a-zA-Z0-9_]*[a-zA-Z]+[a-zA-Z0-9_]*)/\$$1/g ;
	chomp $l;
	
 	my $perlLine = $l.$q.';';
	return $perlLine;
}
sub perlVarPrint{
	#divide the line into 2 
	#q is the content in "" and l is the rest
	my $l = $_[0];
	$l =~ s/\"\s*\+\s*\"/\"\.\"/g;
	chomp $l;
	my $q = $l;
	$q =~ s/^\s*print\s*//g;
	chomp $q;
	if (!($q =~ m/^(".*").*/)){
		$q="";
	}
	$l =~ s/^\s*print\s*//;
	$l =~ s/^\s".*"\s*//;
	chomp $l;
	if ($l){
		$q = $q.',' if($q);
		$l = perlVar($l) ; 
		$l =~ s/,/."\\s",/g;
	}
	my $perlLine = "print ".$q.$l.';';
	
	return $perlLine;
}

sub perlRawPrint{
	my $l = $_[0];
	$l =~ s/\s+r"(.*)"/ '$1\'/g;
	chomp $l;
	return $l.'."\n";';
}

sub perlPrintf {
	#divide the line into 2 
	#inq keeps the content in quotes and var stores the variables
	my $l = $_[0]; #print"%s %s %d" % (v1,v2,v3)
	#print $l."\n";
		chomp $l;
		my $var = $l;
		my $inq = "";
		$var =~ s/print.*\".*\"//; # % (v1,v2,v3)
		$var =~ s/\%//; # (v1,v2,v3)
		$var =~ s/[\(\)]//g; # v1,v2,v3
		$var = &perlVar($var);
		
		($inq) = ($l =~ /(\".*\")/);
		if(($inq) && ($var)){
			$inq = $inq.',';	
		}
		$perlLine = "printf".'('.$inq.$var.'."\n");';
		
	return $perlLine; 
}

sub perlVar{#deduce if there are variables and convert them to perl format if there is any.
	(my $l) = @_;
	my @var = split (/,/,$l); 
	$v = shift @var;
	$v =~ s/ //g;#remove spaces
	$vsInPerl = "\$$v";
		
	foreach $v (@var){
		$v =~ s/ //g;#remove spaces
		$vsInPerl .= ",\$$v";
	}
	
	chomp $vsInPerl;
	return $vsInPerl;


}

sub perlFormat(){
	print "#!/usr/bin/perl -w\n";
}
