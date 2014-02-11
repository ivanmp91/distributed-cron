#!/usr/bin/perl

use strict;
use warnings;
use Exporter;
use Getopt::Long;
use cron::dist::client::cron_client;

my @tasks;
my $params={};
GetOptions($params,
   "tasks=s{1,}" =>\@tasks,
   "help",
  )
   or die usage();

checkArguments();

sub checkArguments{
	if(defined($params->{help}) || !@tasks){
		usage();
	}
	else{
		foreach(@tasks){
			&putJob($_);
		}			
	}
}

sub usage{
print <<EOF;
usage: cron_client.pl [OPTIONS]
Send job tasks to the gearman job server
Arguments:
	--tasks	: Name of the tasks to run
	--help	: print this menu help
Example:
	cron_client.pl --tasks task1 task2
EOF
        exit 0;
}
