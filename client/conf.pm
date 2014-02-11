#!/usr/bin/perl

package cron::dist::client::conf;
use strict;
use Exporter;
use JSON;
use utf8::all;
use Encode;
use File::Slurp;

our @ISA = qw(Exporter);
our @EXPORT = qw (getValue);

sub getValue{
	my $option = shift;
	my $file='conf.json';
        my @value;
        my $config=decode_json(encode("utf8",read_file($file))) || die;
        @value=@{$config->{$option}};
        return @value;
}
