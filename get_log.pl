#!/usr/bin/perl

use strict;
use warnings;
use Time::Piece;
use logRecord;

sub usage {
	print "USAGE: \$ perl get_log.pl <log file name>\n";
}


if(@ARGV != 1) {
	usage;
	exit;
}

my $file = $ARGV[0];

if(!-f $file){
	usage;
	exit;	
}

my %LOG_RECORD_LIST = ();

# READ FILE
open(my $fh, "<", $file) 
 or die "Cannot open $file: $!";

while(readline $fh) {
	chomp $_;

	# IP Address
	if(/^((\d{1,3}\.){3}\d{1,3}) .+ \[(\d{2}\/.+\/\d{4}:\d{2}:\d{2}:\d{2}) .*\] .+/) {
		my $t = Time::Piece->strptime($3, '%d/%b/%Y:%H:%M:%S');
		my $date = $t->strftime('%Y/%m/%d %H:%M:%S');

		if(!exists($LOG_RECORD_LIST{$1})) {
			my $log_record = new logRecord;
			$log_record->add_log($date, $_);
			$LOG_RECORD_LIST{$1} = $log_record;
		} else {
			my $log_record = $LOG_RECORD_LIST{$1};
			$log_record->add_log($date, $_);
		}

	}
}

close $fh;

foreach my $key (sort keys %LOG_RECORD_LIST) {
	my $log_record = $LOG_RECORD_LIST{$key};
	my @loglist = @{$log_record->get_loglist()};

	foreach my $log (sort { $a->{time} cmp $b->{time} } @loglist) {

		print "$key	$log->{time}	$log->{log}\n";
	}
}

