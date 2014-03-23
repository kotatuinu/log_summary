package logRecord;

sub new {
	my $pkg = shift;
	bless {
		log_data => (),
	}, $pkg;
}

sub add_log {
	my $self = shift;
	my ($time, $log) = @_;
	my $logdata = { 'time' => $time, 'log' => $log };
	push( @{$self->{log_data}}, $logdata);
}

sub get_loglist {
	my $self = shift;

	return $self->{log_data};
}

1;

