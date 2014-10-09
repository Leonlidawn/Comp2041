#!/usr/bin/perl -w
#comp2041 assignment 1
#student id :z3447627

#subroutine perlPrint implemented in normal txt file.


#a array which stores all variables.
@variables=();


while ($line = <>) {
	if ($line =~ /^#!/ && $. == 1) {
		# translate #! line 
		&perlformat;
	} 
	elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/) {
		# Blank & comment lines can be passed unchanged
		print $line;
	
	} 
	elsif ($line =~ /^\s*print\s*"(.*)"\s*$/) {#variable needed
		if($line =~ %){

		}
	# Python's print print a new-line character by default
		# so we need to add it explicitly to the Perl print statement
		#check if variable is used.

		if (){ #if there are new var,push in.
			push @variables, $cvar;
		}

	 elsif(){#check for new variable

	 



	 else {
	
		# Lines we can't translate are turned into comments
		
		print "#$line\n";
	}
}



sub perlPrint { #need to consider variables
	$l = $_; #print"%s %s %d" % (v1,v2,v3)
	#handle the print;
		#print"%s %s %d" % (v1,v2,v3)
	
		$var =~ s/print".*"//,$l; # % (v1,v2,v3)
		$var =~ s/%//; # (v1,v2,v3)
		$var =~ s/)//; # v1,v2,v3
	
		@var =~ split (/,/,$var); 
		foreach $v (@var){
			$vsInPerl .= ",\$$v";
		}

		$l =~ /printf".*"/;
		
		$l = join ("printf", "\(", $section, ', "\n"', "\)");
	}
	return $l; 
}

sub perlFormat(){
	print "#!/usr/bin/perl -w\n";
}
