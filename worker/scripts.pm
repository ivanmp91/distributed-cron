#!/usr/bin/perl

package cron::dist::worker::scripts;
use strict;
use Exporter;
use JSON;
use utf8::all;
use Encode;
use File::Slurp;
use Data::Dumper;

our @ISA = qw(Exporter);
our @EXPORT = qw (getValue);

sub getValue{
	my $option = shift;
	my $file='conf.json';
        my $value;
	my @jobs;
	my @job_servers;
        my $config=decode_json(encode("utf8",read_file($file))) || die;
	if($option eq "debug"){
		$value=$$config{$option};
		return $value;
	}
	elsif($option eq "job_servers"){
		@job_servers=@{$config->{$option}};
		return @job_servers;
	}
	else{
		@jobs=@{$config->{'jobs'}};
		foreach(@jobs){
			my $task_ref=$_;
			my %task=%{$task_ref};
			foreach my $k (keys %task){
				if($k eq $option){
					$value=$task{$k};
				}
			}
		}
		return $value;
	}
}
