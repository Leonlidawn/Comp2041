#!/usr/bin/perl -w
#Aimed to convert numeric constants, arithmetic operation and print statements only from python to perl only.

#comp2041 assignment 1
#student id :z3447627


#added @operators array to enhance variables detection in perlVar subroutine.


#a array which stores all variables.
@variables=();
@operatoers=("+", "-", "*", "/", "%", "**");

while ($line = <>) {
	if ($line =~ /^#!/ && $. == 1) {
		# translate #! line 
		&perlformat;
	} 
	elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/) {
		# Blank & comment lines can be passed unchanged
		print $line."\n";
	
	} 
	elsif ($line =~ /^\s*print\s*"(.*)"\s*$/) {
		
			perlPrint ($line);
	}
	# Python's print print a new-line character by default

	 else {
	
		# Lines we can't translate are turned into comments
		
		print "#$line\n";
	}
}



sub perlPrint { #need to consider variables
	$l = $_; #print"%s %s %d" % (v1,v2,v3)
	#handle the print;
		#print"%s %s %d" % (v1,v2,v3)
		$var = $l;
		$var =~ s/print".*"//; # % (v1,v2,v3)
		$var =~ s/%//; # (v1,v2,v3)
		$var =~ s/)//; # v1,v2,v3
		$var = perlVar($var,1);
		$var = ",".$var;
		$l =~ /".*"/;
		
		$perlLine = "printf"."\("."$1".$var, ', "\n"', "\)\;");
	}
	return $perlLine; 
}

sub perlVar{#deduce if there are variables and convert them to perl format if there is any.
	($l,$con) = @_;#if $con is true, it skips checking and consider $l contains variables only.
	if($con){ 
		@var =~ split (/,/,$l); 
		foreach $v (@var){
			$v =~ s/ //g;#remove spaces
			$vsInPerl .= ",\$$v";
		}	
		return $vsInPerl;
	}
	else{#not in (), need to check for  
		@var =~ split (/ /,$l); 
		foreach $v (@var){
			if ($v =~ /[a-zA-Z0-9]+/){
	
			}
			$v =~ s/ //g;#remove spaces
			$vsInPerl .= ",\$$v";
		}	
		return $vsInPerl

	}

}

sub perlFormat(){
	print "#!/usr/bin/perl -w\n";
}
