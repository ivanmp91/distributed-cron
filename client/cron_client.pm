#!/usr/bin/perl

package cron::dist::client::cron_client;

use strict;
use Exporter;
use Gearman::Client;
use cron::dist::client::conf;

our @ISA = qw(Exporter);
our @EXPORT = qw (putJob);

sub putJob {
	my $job=shift;
	my @job_servers=getValue('job_servers');
	my @servers;
	foreach(@job_servers){
		my $server=$_->{'server'};
		my $port=$_->{'port'};
		push(@servers,$server.':'.$port);
	}
	my $gearman_client=new Gearman::Client;
	$gearman_client->job_servers(@servers);
	return $gearman_client->do_task('runJob',$job);
}
1;
