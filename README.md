# ���O�W�vPerl�v���O�����i�ЂȌ`�j
 ���O���W�v����̂�Perl�͂��Ȃ苭�͂ȃc�[���ɂȂ�̂ł��B  
 �ł��A���������V���ɏ����N�����͖̂ʓ|�Ȃ킯�ŁB  
 �Ƃ����킯�ŁA������x�A�`�ɂ������̂��ЂȌ`������Ă݂܂����B  
 ����́AApache���O����AIP���L�[�Ɏ��n��ɕ��ׂ���̂ɂ��Ă݂܂����B  
  
 ��̂̃��O�̏W�v�́A�ȉ��̍H�����o��Ǝv���B  
1. ���O�t�@�C����ǂݍ���  
2. �K�v�ȕ�����؂�o��  
3. ����̏����L�[�ɂ��ďW�v����  
  
 �K�v�ɉ����ď��������Ă��������ȁB  
 �m���Ƃ���perl�̐��K�\���Ƃ��K�v�ł����B  
  
 �Ⴆ�΁A�ȉ���Apache���O�ɑ΂��Đ��K�\���Œ��o���Ă݂�ƁB  

 10.2.3.4 - - [18/Apr/2005:00:10:47 +0900] "GET / HTTP/1.1" 200 854 "-" "Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)"  
  ��  
 /^((\d{1,3}\.){3}\d{1,3}) .+ \[(\d{2}\/.+\/\d{4}:\d{2}:\d{2}:\d{2}) .*\] .+/  

 ��L�̐��K�\���Ƀq�b�g�����s�ɑ΂��āA�p�[����"()"�Ŋ���ꂽ�ӏ������o�����̂ŁA$1 �� IP�A�h���X���L�[�Ƃ��āA$3 �� ������؂�o���ă\�[�g�ΏۂƂ���B  
 ���Ƃ̓��O�S�̂�ێ�����B  
 �f�[�^�̕ێ��́A�f�[�^�N���X�ɕ��荞�ތ`�B  
  
 �ɂ��Ă��Aperl�̔z��A�A�z�z��́A�킯�������E�E�E�B  
 �z��ɘA�z�z�������Ƃ��́A�A�z�z���$�ϐ�1�Ɋi�[�������̂��A()�ŏ���������$�ϐ�2�ɑ΂���push()���Ă��܂��������݂��������ǁE�E�E�Bpush�ł����z���@$�ϐ�2�ɓ����B(�ȉ��̗�ł́A�N���X�Ȃ̂�{}�Ŋ����Ă��邯��)   
 ���o���Ƃ����A$�ϐ���n���āA�n������ł�@{}�Ŋ��������̂�@�ϐ��Ɋi�[���Ĕz��Ƃ��Ĉ����B�����āA�A�z�z��Ƃ��Ĉ����E�E�E�B  
 ���s���낵�Ă݂Ăł�������ǁA����ς�A�킯�������B  
  
 ��logRecord.pm  
_________________________
package logRecord;  
  
sub new {  
	my $pkg = shift;  
	bless {  
		log_data =&gt; (),  
	}, $pkg;  
}  
  
sub add_log {  
	my $self = shift;  
	my ($time, $log) = @_;  
	my $logdata = { 'time' =&gt; $time, 'log' =&gt; $log };  
	push( @{$self-&gt;{log_data}}, $logdata);  
}  
  
sub get_loglist {  
	my $self = shift;  
  
 return $self-&gt;{log_data};  
}  
  
1;  
_________________________

_________________________
 #!/usr/bin/perl  
  
use Time::Piece;  
  
my $log_record = new logRecord;  
$log_record-&gt;add_log("2014/03/23 20:47:00", "test");  
  
my @loglist = @{$log_record-&gt;get_loglist()};  
foreach my $log (sort { $a-&gt;{time} cmp $b-&gt;{time} } @loglist) {  
  
print "$log-&gt;{time}	$log-&gt;{log}\n";  
}  
_________________________


