#!/usr/bin/env perl
use CPAN;

my $windows = $^O =~ /Win32/i;

if(!$windows and getpwuid($<) ne 'root'){
  print "Please run the module installer as root!\n";
  exit();
}elsif($windows){
	my $retval = system('mkdir "%windir%\system32\perl_modules_test') >> 8;
	if($retval == 0){
		system('rmdir "%windir%\system32\perl_modules_test');
	}else{
		print "Please run the module installer as administrator!\n";
		exit();
	}
}

my @requiredModules = (
	"utf8",
	"IO::Null",
	"File::Basename",
	"abs_path",
	"Getopt::Long",
	"Term::ReadKey",
	"Term::ANSIColor",
	"XML::Simple",
	"WWW::Mechanize",
	"HTTP::Request::Common",
	"HTML::TreeBuilder",
	"URI::Escape",
);

if($windows){
  # Append additional windose modules
	push(@requiredModules,"Win32::Console::ANSI");
	push(@requiredModules,"Win32::File");
}

for my $moduleName (@requiredModules){
  printf("Installing '%s'...\n", $moduleName);
  CPAN::Shell->install($moduleName);
}