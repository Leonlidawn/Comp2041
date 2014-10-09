#!/usr/bin/perl -w
#Aimed to convert numeric constants, arithmetic operation and print statements only from python to perl only.

#comp2041 assignment 1
#student id :z3447627


#added @operators array to enhance variables detection in perlVar subroutine.


#a array which stores all variables.
#@variables=();
#@operatoers=("+", "-", "*", "/", "%", "**");

while ($line = <>) {
	if ($line =~ /^#!/ && $. == 1) {
		# translate #! line 
		&perlFormat;
	} 
	elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/ ) {
		# Blank & comment lines can be passed unchanged
		print"---------------------enter 1\n";
		print $line."\n";
	
	} 
	elsif ($line =~ /^\s*print\s*"(.*)"\s*$/) {#contains variable in ""
			print"---------------------enter 2\n";
			print &perlPrintf ($line)."\n";
	}
	elsif ($line =~ /^\s*print\s*[^""]*r".*/){#printing raw string
			print"---------------------enter 3\n";
			print &perlRawPrint($line)."\n";		
	}
	elsif ($line =~ /^\s*print\s*"(.*)"\s*$/) {#contains variable in ""
			print"---------------------enter 4\n";
			print &perlPrintf($line)."\n";
	}
	elsif($line =~ /^\s*print\s/){#contains variable outside
			print"---------------------enter 5\n";
			print &perlVarPrint($line)."\n";
	}
	elsif($line =~ /\d+.*=. /)
	 else {
	
		# Lines we can't translate are turned into comments
		
		print "#$line\n";
	}
}
sub perlVarPrint{
	my $l = $_[0];
	$l =~ s/^\s*print//;
	$l = perlVar($l,1);
	$l =~ s/,/."\\s",/g;
	$perlLine = "print ".$l.';';
	return $perlLine;
}

sub perlRawPrint{
	my $l = $_[0];
	$l =~ s/\s+r"(.*)"/'$1\'/g;
	return $l.'"\n"'."\n";
}

sub perlPrintf { #need to consider variables
	my $l = $_[0]; #print"%s %s %d" % (v1,v2,v3)
	print $l."\n";
		my $var = $l;
		my $inq = "";
		$var =~ s/print\".*\"//; # % (v1,v2,v3)
		$var =~ s/\%//; # (v1,v2,v3)
		$var =~ s/[\(\)]//g; # v1,v2,v3
		$var = &perlVar($var,1);
		($inq) = ($l =~ /(\".*\")/);
		if(($inq) && ($var)){
			$inq = $inq.',';	
		}
		$perlLine = "printf".'('.$inq.$var.'."\n");';
	
	return $perlLine; 
}

sub perlVar{#deduce if there are variables and convert them to perl format if there is any.
	(my $l,$con) = @_;
	if($con){ 
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

}

sub perlFormat(){
	print "#!/usr/bin/perl -w\n";
}
