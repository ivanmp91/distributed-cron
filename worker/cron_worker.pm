#!/usr/bin/perl

package cron::dist::worker::cron_worker;

use strict;
use Exporter;
use Gearman::Worker;
use cron::dist::worker::scripts;
use Sys::Syslog qw(:DEFAULT :standard :macros);

our @ISA = qw(Exporter);
our @EXPORT = qw (workerInit);

sub workerInit {
	my $worker= new Gearman::Worker;
	my @job_servers=getValue('job_servers');
	my @servers;
        foreach(@job_servers){
                my $server=$_->{'server'};
                my $port=$_->{'port'};
                push(@servers,$server.':'.$port);
        }
	$worker->job_servers(@servers);
	$worker->register_function(runJob=>\&runJob);
	$worker->work() while 1;
}

sub runJob{
	my $job=shift;
	my $cronTask=$job->arg;
	my $script=getValue($cronTask);	
	my $debug=getValue('debug');
	openlog('Distributed Cron', 'cons,pid', 'user');
	if (defined($script)){
		my $exit=system($script);
			if($exit==0){
			syslog('info', '%s', 'Task '.$script.' executed successfully at '.localtime()) if ($debug eq "true");
		}
		else{
			syslog('info', '%s', 'Task '.$script.' not executed successfully at '.localtime()) if ($debug eq "true");
		}
	}
	else{
		syslog('info', '%s', 'Task not found '.$cronTask.' at '.localtime().' define it on configuration file') if ($debug eq "true");
	}
	closelog();
}
1;
