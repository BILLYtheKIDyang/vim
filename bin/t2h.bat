@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!/usr/bin/perl
#line 15
# This program translates texinfo files to markdown for use in
# doxygen.

# Copyright (C) 2014 Kieran Colford

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see
# <http://www.gnu.org/licenses/>.

use strict;
use warnings;

sub basics() {
    s/\@copyright{}/&copy;/g;
    s/\@dots{}/... /g;
    s/La\@TeX{}/LaTeX/g;
    s/\@var{(.*?)}/<$1>/g;
    s/\@samp{(.*?)}/'$1'/g;
    s/\@(?:code|command|file|option){(.*?)}/`$1`/g;
    s/\@(?:emph|dfn){(.*?)}/_$1_/g;
    s/\@\././g;
    s/\@:/:/g;
    if (!/^    /) {
	s/\@(?:url|uref){(.*?)}/<<$1>>/g;
	s/``/&ldquo;/g;
	s/''/&rdquo;/g;
    } else {
	s/\@(?:url|uref){(.*?)}/<$1>/g;
	s/``/"/g;
	s/''/"/g;
    }
    s/\@(center|display|group|page)\b//g;
    s/\@end (display|group)\b//g;
    s/\@c\b.*$//;
}

sub enum_alpha {
    if (/\@enumerate ([a-zA-Z])/) {
	my $count = $1;
      LINE: while (<>) {
	  last LINE if (/\@end enumerate/);
	  basics ();
	  if (/\@item/) {
	      s/\@item/ * **$count)** /;
	      $count = chr ((ord $count) + 1);
	  }
	  print;
      }
	$_ = '';
    }
}

sub enum_num {
    if (/\@enumerate ([0-9])/) {
	my $count = $1;
      LINE: while (<>) {
	  last LINE if (/\@end enumerate/);
	  basics ();
	  enum_alpha ();
	  if (/\@item/) {
	      if (!/\@item [a-zA-Z0-9]+/) {
		  chomp; $_ .= ' ' . <>;
	      }
	      s/\@item/### $count./;
	      $count += 1;
	  }
	  print;
      }
	$_ = '';
    }
}

sub example {
    if (/\@(small)?example/) {
      LINE: while (<>) {
	  last LINE if (/\@end (small)?example/);
	  $_ = '    ' . $_;
	  basics ();
	  print;
      }
	$_ = '';
    }
}

sub parse () {
    while (<>) {
	basics ();
	s/\@heading/##/;
	s/\@section/##/;
	enum_alpha ();
	enum_num ();
	example ();
	print;
    }
}

$_ = <>;
s/\@[^ \t]+/#/;
print;
parse ();
__END__
:endofperl
