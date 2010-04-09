#!/usr/bin/perl -w

# instructions
#
#   run it as is, and the program segfaults (Data::Dumper returns undef)
#       perl -w $0 | wc
#
#   make it not use a sort sub, and program works; prints 18429 bytes to
#   STDOUT:
#       NO_SORT_SUB=1 perl -w $0 | wc
#
#   run the bizarre workaround that slackorama found (issue #15 on gitolite's
#   github repo), and the program works; prints 18429 bytes to STDOUT
#       WTF=1 perl -w $0 | wc
#
#   run it by populating the hash in one shot (not possible in real life), and
#   the program works; prints 18429 bytes to STDOUT
#       ONE_SHOT_SETUP=1 perl -w $0 | wc

# step 1 -- setup the %repos hash
our %repos = ();
if (exists $ENV{ONE_SHOT_SETUP}) {
    # do it in one shot, from a fully populated hash directly coded into the
    # program.  This is not useful as a workaround for us in real life but it
    # may help debugging the actual problem
    &one_shot_setup();
} else {
    # or do it in the sequence that gitolite "compile" step actually does
    &real_life_setup();
}

use Data::Dumper;
$Data::Dumper::Indent = 1;
# sorting is not a problem...
$Data::Dumper::Sortkeys = 1;

# ...but a custom sort sub is!  Not calling one helps, and is the official
# workaround for this problem, currently...
$Data::Dumper::Sortkeys = sub { return [ reverse sort keys %{$_[0]} ]; }
    unless exists $ENV{NO_SORT_SUB};

# ...or you could use this totally meaningless operation too!  The bizarreness
# of this has prompted me to write this test program
if (exists $ENV{WTF}) {
    for my $key (sort keys %repos) {
        my @wtf = sort keys %{ $repos{$key} };
    }
}

my $dumped_data = Data::Dumper->Dump([\%repos], [qw(*repos)]);
print $dumped_data;
print STDERR "dumped " . length($dumped_data) . " bytes\n";

sub one_shot_setup
{
    # set up the %repos hash in one shot... in real life we cannot do this of
    # course!
    %repos = ('testing' => {'guser13' => [{'refs/.*' =>
                'RW+'},{'refs/heads/master' => '-'}],'user88' =>
            [{'refs/heads/fun/' => 'RW+'},{'refs/.*' => 'R'}],'user1' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser76' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser25' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'user4' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' =>
                '-'},{'refs/heads/master' => 'RW+'}],'guser36' => [{'refs/.*'
                => 'RW+'},{'refs/heads/master' => '-'}],'guser2' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser14' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser60' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser57' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser31' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser7' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser66' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser75' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser58' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser1' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser73' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser35' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser74' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'user5' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' =>
                '-'},{'refs/heads/master' => 'RW+'}],'guser11' => [{'refs/.*'
                => 'RW+'},{'refs/heads/master' => '-'}],'guser33' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser53' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser5' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser4' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser85' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser50' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser38' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser59' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser56' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'user3' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' =>
                '-'},{'refs/heads/master' => 'RW'},{'refs/heads/master' =>
                'RW+'}],'guser54' => [{'refs/.*' =>
                'RW+'},{'refs/heads/master' => '-'}],'guser20' => [{'refs/.*'
                => 'RW+'},{'refs/heads/master' => '-'}],'guser27' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'user9' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser0' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser32' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'user8' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser41' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser26' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser18' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser78' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser52' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser43' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser22' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser29' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser64' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser17' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser34' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'user2' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' =>
                '-'},{'refs/heads/master' => 'RW'},{'refs/heads/master' =>
                'RW+'}],'guser82' => [{'refs/.*' =>
                'RW+'},{'refs/heads/master' => '-'}],'guser86' =>
            [{'refs/heads/fun/' => 'RW+'},{'refs/.*' => 'R'}],'guser44' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser62' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser45' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser48' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser37' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'user16' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' =>
                '-'},{'refs/heads/master' => 'RW+'}],'user6' => [{'refs/.*' =>
                'RW+'},{'refs/heads/master' => '-'}],'guser83' => [{'refs/.*'
                => 'RW+'},{'refs/heads/master' => '-'}],'user7' => [{'refs/.*'
                => 'RW+'},{'refs/heads/master' => '-'}],'user13' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' =>
                '-'},{'refs/heads/master' => 'RW'}],'guser55' => [{'refs/.*'
                => 'RW+'},{'refs/heads/master' => '-'}],'user10' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'W' =>
            {'guser13' => 1,'user88' => 1,'user1' => 1,'guser76' =>
                1,'guser25' => 1,'user4' => 1,'guser36' => 1,'guser2' =>
                1,'guser14' => 1,'guser60' => 1,'guser57' => 1,'guser31' =>
                1,'guser7' => 1,'guser66' => 1,'guser75' => 1,'guser58' =>
                1,'guser1' => 1,'guser73' => 1,'guser35' => 1,'guser74' =>
                1,'user5' => 1,'guser11' => 1,'guser33' => 1,'guser53' =>
                1,'guser5' => 1,'guser4' => 1,'guser85' => 1,'guser50' =>
                1,'guser38' => 1,'guser59' => 1,'guser56' => 1,'user3' =>
                1,'guser54' => 1,'guser20' => 1,'guser27' => 1,'user9' =>
                1,'guser0' => 1,'guser32' => 1,'user8' => 1,'guser41' =>
                1,'guser26' => 1,'guser18' => 1,'guser78' => 1,'guser52' =>
                1,'guser43' => 1,'guser22' => 1,'guser29' => 1,'guser64' =>
                1,'guser17' => 1,'guser34' => 1,'user2' => 1,'guser82' =>
                1,'guser86' => 1,'guser44' => 1,'guser62' => 1,'guser45' =>
                1,'guser48' => 1,'guser37' => 1,'user16' => 1,'user6' =>
                1,'guser83' => 1,'user7' => 1,'user13' => 1,'guser55' =>
                1,'user10' => 1,'guser9' => 1,'guser8' => 1,'guser23' =>
                1,'guser51' => 1,'guser68' => 1,'guser6' => 1,'guser69' =>
                1,'user12' => 1,'guser21' => 1,'guser87' => 1,'user11' =>
                1,'guser77' => 1,'guser63' => 1,'guser39' => 1,'guser79' =>
                1,'guser49' => 1,'guser3' => 1,'guser84' => 1,'guser80' =>
                1,'guser65' => 1,'guser10' => 1,'guser12' => 1,'guser42' =>
                1,'user15' => 1,'guser15' => 1,'guser71' => 1,'@all' =>
                1,'guser47' => 1,'guser40' => 1,'guser70' => 1,'guser28' =>
                1,'guser67' => 1,'grussell' => 1,'guser19' => 1,'guser61' =>
                1,'user14' => 1,'guser16' => 1,'guser81' => 1,'guser72' =>
                1,'guser46' => 1,'guser30' => 1,'guser24' => 1},'guser9' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser8' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser23' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser51' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser68' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser6' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser69' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'user12' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' =>
                '-'},{'refs/heads/master' => 'RW'}],'guser21' => [{'refs/.*'
                => 'RW+'},{'refs/heads/master' => '-'}],'guser87' =>
            [{'refs/heads/fun/' => 'RW+'},{'refs/.*' => 'R'}],'user11' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' =>
                '-'},{'refs/heads/master' => 'RW'}],'guser77' => [{'refs/.*'
                => 'RW+'},{'refs/heads/master' => '-'}],'guser63' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser39' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser79' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser49' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser3' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser84' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser80' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser65' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser10' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser12' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser42' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'user15' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' =>
                '-'},{'refs/heads/master' => 'RW'}],'guser15' => [{'refs/.*'
                => 'RW+'},{'refs/heads/master' => '-'}],'guser71' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'@all' =>
            [{'refs/.*' => 'RW+'}],'guser47' => [{'refs/.*' =>
                'RW+'},{'refs/heads/master' => '-'}],'guser40' => [{'refs/.*'
                => 'RW+'},{'refs/heads/master' => '-'}],'guser70' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser28' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser67' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'grussell' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' =>
                '-'},{'refs/heads/master' => 'RW+'}],'guser19' => [{'refs/.*'
                => 'RW+'},{'refs/heads/master' => '-'}],'guser61' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'user14' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' =>
                '-'},{'refs/heads/master' => 'RW'}],'guser16' => [{'refs/.*'
                => 'RW+'},{'refs/heads/master' => '-'}],'guser81' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser72' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'R' =>
            {'guser13' => 1,'user88' => 1,'user1' => 1,'guser76' =>
                1,'guser25' => 1,'user4' => 1,'guser36' => 1,'guser2' =>
                1,'guser14' => 1,'guser60' => 1,'guser57' => 1,'guser31' =>
                1,'guser7' => 1,'guser66' => 1,'guser75' => 1,'guser58' =>
                1,'guser1' => 1,'guser73' => 1,'guser35' => 1,'guser74' =>
                1,'user5' => 1,'guser11' => 1,'guser33' => 1,'guser53' =>
                1,'guser5' => 1,'guser4' => 1,'guser85' => 1,'guser50' =>
                1,'guser38' => 1,'guser59' => 1,'guser56' => 1,'user3' =>
                1,'guser54' => 1,'guser20' => 1,'guser27' => 1,'user9' =>
                1,'guser0' => 1,'guser32' => 1,'user8' => 1,'guser41' =>
                1,'guser26' => 1,'guser18' => 1,'guser78' => 1,'guser52' =>
                1,'guser43' => 1,'guser22' => 1,'guser29' => 1,'guser64' =>
                1,'guser17' => 1,'guser34' => 1,'user2' => 1,'guser82' =>
                1,'guser86' => 1,'guser44' => 1,'guser62' => 1,'guser45' =>
                1,'guser48' => 1,'guser37' => 1,'user16' => 1,'user6' =>
                1,'guser83' => 1,'user7' => 1,'user13' => 1,'guser55' =>
                1,'user10' => 1,'guser9' => 1,'guser8' => 1,'guser23' =>
                1,'guser51' => 1,'guser68' => 1,'guser6' => 1,'guser69' =>
                1,'user12' => 1,'guser21' => 1,'guser87' => 1,'user11' =>
                1,'guser77' => 1,'guser63' => 1,'guser39' => 1,'guser79' =>
                1,'guser49' => 1,'guser3' => 1,'guser84' => 1,'guser80' =>
                1,'guser65' => 1,'guser10' => 1,'guser12' => 1,'guser42' =>
                1,'user15' => 1,'guser15' => 1,'guser71' => 1,'@all' =>
                1,'guser47' => 1,'guser40' => 1,'guser70' => 1,'guser28' =>
                1,'guser67' => 1,'grussell' => 1,'guser19' => 1,'guser61' =>
                1,'user14' => 1,'guser16' => 1,'guser81' => 1,'guser72' =>
                1,'guser46' => 1,'guser30' => 1,'guser24' => 1},'guser46' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser30' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' => '-'}],'guser24' =>
            [{'refs/.*' => 'RW+'},{'refs/heads/master' =>
                '-'}]},'gitolite-admin' => {'W' => {'sitaram' => 1},'sitaram'
            => [{'refs/.*' => 'RW+'}],'R' => {'sitaram' => 1}});
}

sub real_life_setup {
    # set up the %repos hash in a manner that reflects a real run of
    # gitolite's "compiler" script:
    $repos{'gitolite-admin'}{R}{'sitaram'} = 1;
    $repos{'gitolite-admin'}{W}{'sitaram'} = 1;
    push @{ $repos{'gitolite-admin'}{'sitaram'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'@all'} = 1;
    $repos{'testing'}{W}{'@all'} = 1;
    push @{ $repos{'testing'}{'@all'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser86'} = 1;
    $repos{'testing'}{W}{'guser86'} = 1;
    push @{ $repos{'testing'}{'guser86'} }, { 'refs/heads/fun/' => 'RW+' };
    $repos{'testing'}{R}{'guser87'} = 1;
    $repos{'testing'}{W}{'guser87'} = 1;
    push @{ $repos{'testing'}{'guser87'} }, { 'refs/heads/fun/' => 'RW+' };
    $repos{'testing'}{R}{'user88'} = 1;
    $repos{'testing'}{W}{'user88'} = 1;
    push @{ $repos{'testing'}{'user88'} }, { 'refs/heads/fun/' => 'RW+' };
    $repos{'testing'}{R}{'guser86'} = 1;
    push @{ $repos{'testing'}{'guser86'} }, { 'refs/.*' => 'R' };
    $repos{'testing'}{R}{'guser87'} = 1;
    push @{ $repos{'testing'}{'guser87'} }, { 'refs/.*' => 'R' };
    $repos{'testing'}{R}{'user88'} = 1;
    push @{ $repos{'testing'}{'user88'} }, { 'refs/.*' => 'R' };
    $repos{'testing'}{R}{'grussell'} = 1;
    $repos{'testing'}{W}{'grussell'} = 1;
    push @{ $repos{'testing'}{'grussell'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser0'} = 1;
    $repos{'testing'}{W}{'guser0'} = 1;
    push @{ $repos{'testing'}{'guser0'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser1'} = 1;
    $repos{'testing'}{W}{'guser1'} = 1;
    push @{ $repos{'testing'}{'guser1'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser10'} = 1;
    $repos{'testing'}{W}{'guser10'} = 1;
    push @{ $repos{'testing'}{'guser10'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser11'} = 1;
    $repos{'testing'}{W}{'guser11'} = 1;
    push @{ $repos{'testing'}{'guser11'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser12'} = 1;
    $repos{'testing'}{W}{'guser12'} = 1;
    push @{ $repos{'testing'}{'guser12'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser13'} = 1;
    $repos{'testing'}{W}{'guser13'} = 1;
    push @{ $repos{'testing'}{'guser13'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser14'} = 1;
    $repos{'testing'}{W}{'guser14'} = 1;
    push @{ $repos{'testing'}{'guser14'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser15'} = 1;
    $repos{'testing'}{W}{'guser15'} = 1;
    push @{ $repos{'testing'}{'guser15'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser16'} = 1;
    $repos{'testing'}{W}{'guser16'} = 1;
    push @{ $repos{'testing'}{'guser16'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser17'} = 1;
    $repos{'testing'}{W}{'guser17'} = 1;
    push @{ $repos{'testing'}{'guser17'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser18'} = 1;
    $repos{'testing'}{W}{'guser18'} = 1;
    push @{ $repos{'testing'}{'guser18'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser19'} = 1;
    $repos{'testing'}{W}{'guser19'} = 1;
    push @{ $repos{'testing'}{'guser19'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser2'} = 1;
    $repos{'testing'}{W}{'guser2'} = 1;
    push @{ $repos{'testing'}{'guser2'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser20'} = 1;
    $repos{'testing'}{W}{'guser20'} = 1;
    push @{ $repos{'testing'}{'guser20'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser21'} = 1;
    $repos{'testing'}{W}{'guser21'} = 1;
    push @{ $repos{'testing'}{'guser21'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser22'} = 1;
    $repos{'testing'}{W}{'guser22'} = 1;
    push @{ $repos{'testing'}{'guser22'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser23'} = 1;
    $repos{'testing'}{W}{'guser23'} = 1;
    push @{ $repos{'testing'}{'guser23'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser24'} = 1;
    $repos{'testing'}{W}{'guser24'} = 1;
    push @{ $repos{'testing'}{'guser24'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser25'} = 1;
    $repos{'testing'}{W}{'guser25'} = 1;
    push @{ $repos{'testing'}{'guser25'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser26'} = 1;
    $repos{'testing'}{W}{'guser26'} = 1;
    push @{ $repos{'testing'}{'guser26'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser27'} = 1;
    $repos{'testing'}{W}{'guser27'} = 1;
    push @{ $repos{'testing'}{'guser27'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser28'} = 1;
    $repos{'testing'}{W}{'guser28'} = 1;
    push @{ $repos{'testing'}{'guser28'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser29'} = 1;
    $repos{'testing'}{W}{'guser29'} = 1;
    push @{ $repos{'testing'}{'guser29'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser3'} = 1;
    $repos{'testing'}{W}{'guser3'} = 1;
    push @{ $repos{'testing'}{'guser3'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser30'} = 1;
    $repos{'testing'}{W}{'guser30'} = 1;
    push @{ $repos{'testing'}{'guser30'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser31'} = 1;
    $repos{'testing'}{W}{'guser31'} = 1;
    push @{ $repos{'testing'}{'guser31'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser32'} = 1;
    $repos{'testing'}{W}{'guser32'} = 1;
    push @{ $repos{'testing'}{'guser32'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser33'} = 1;
    $repos{'testing'}{W}{'guser33'} = 1;
    push @{ $repos{'testing'}{'guser33'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser34'} = 1;
    $repos{'testing'}{W}{'guser34'} = 1;
    push @{ $repos{'testing'}{'guser34'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser35'} = 1;
    $repos{'testing'}{W}{'guser35'} = 1;
    push @{ $repos{'testing'}{'guser35'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser36'} = 1;
    $repos{'testing'}{W}{'guser36'} = 1;
    push @{ $repos{'testing'}{'guser36'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser37'} = 1;
    $repos{'testing'}{W}{'guser37'} = 1;
    push @{ $repos{'testing'}{'guser37'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser38'} = 1;
    $repos{'testing'}{W}{'guser38'} = 1;
    push @{ $repos{'testing'}{'guser38'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser39'} = 1;
    $repos{'testing'}{W}{'guser39'} = 1;
    push @{ $repos{'testing'}{'guser39'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser4'} = 1;
    $repos{'testing'}{W}{'guser4'} = 1;
    push @{ $repos{'testing'}{'guser4'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser40'} = 1;
    $repos{'testing'}{W}{'guser40'} = 1;
    push @{ $repos{'testing'}{'guser40'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser41'} = 1;
    $repos{'testing'}{W}{'guser41'} = 1;
    push @{ $repos{'testing'}{'guser41'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser42'} = 1;
    $repos{'testing'}{W}{'guser42'} = 1;
    push @{ $repos{'testing'}{'guser42'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser43'} = 1;
    $repos{'testing'}{W}{'guser43'} = 1;
    push @{ $repos{'testing'}{'guser43'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser44'} = 1;
    $repos{'testing'}{W}{'guser44'} = 1;
    push @{ $repos{'testing'}{'guser44'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser45'} = 1;
    $repos{'testing'}{W}{'guser45'} = 1;
    push @{ $repos{'testing'}{'guser45'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser46'} = 1;
    $repos{'testing'}{W}{'guser46'} = 1;
    push @{ $repos{'testing'}{'guser46'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser47'} = 1;
    $repos{'testing'}{W}{'guser47'} = 1;
    push @{ $repos{'testing'}{'guser47'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser48'} = 1;
    $repos{'testing'}{W}{'guser48'} = 1;
    push @{ $repos{'testing'}{'guser48'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser49'} = 1;
    $repos{'testing'}{W}{'guser49'} = 1;
    push @{ $repos{'testing'}{'guser49'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser5'} = 1;
    $repos{'testing'}{W}{'guser5'} = 1;
    push @{ $repos{'testing'}{'guser5'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser50'} = 1;
    $repos{'testing'}{W}{'guser50'} = 1;
    push @{ $repos{'testing'}{'guser50'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser51'} = 1;
    $repos{'testing'}{W}{'guser51'} = 1;
    push @{ $repos{'testing'}{'guser51'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser52'} = 1;
    $repos{'testing'}{W}{'guser52'} = 1;
    push @{ $repos{'testing'}{'guser52'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser53'} = 1;
    $repos{'testing'}{W}{'guser53'} = 1;
    push @{ $repos{'testing'}{'guser53'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser54'} = 1;
    $repos{'testing'}{W}{'guser54'} = 1;
    push @{ $repos{'testing'}{'guser54'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser55'} = 1;
    $repos{'testing'}{W}{'guser55'} = 1;
    push @{ $repos{'testing'}{'guser55'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser56'} = 1;
    $repos{'testing'}{W}{'guser56'} = 1;
    push @{ $repos{'testing'}{'guser56'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser57'} = 1;
    $repos{'testing'}{W}{'guser57'} = 1;
    push @{ $repos{'testing'}{'guser57'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser58'} = 1;
    $repos{'testing'}{W}{'guser58'} = 1;
    push @{ $repos{'testing'}{'guser58'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser59'} = 1;
    $repos{'testing'}{W}{'guser59'} = 1;
    push @{ $repos{'testing'}{'guser59'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser6'} = 1;
    $repos{'testing'}{W}{'guser6'} = 1;
    push @{ $repos{'testing'}{'guser6'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser60'} = 1;
    $repos{'testing'}{W}{'guser60'} = 1;
    push @{ $repos{'testing'}{'guser60'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser61'} = 1;
    $repos{'testing'}{W}{'guser61'} = 1;
    push @{ $repos{'testing'}{'guser61'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser62'} = 1;
    $repos{'testing'}{W}{'guser62'} = 1;
    push @{ $repos{'testing'}{'guser62'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser63'} = 1;
    $repos{'testing'}{W}{'guser63'} = 1;
    push @{ $repos{'testing'}{'guser63'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser64'} = 1;
    $repos{'testing'}{W}{'guser64'} = 1;
    push @{ $repos{'testing'}{'guser64'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser65'} = 1;
    $repos{'testing'}{W}{'guser65'} = 1;
    push @{ $repos{'testing'}{'guser65'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser66'} = 1;
    $repos{'testing'}{W}{'guser66'} = 1;
    push @{ $repos{'testing'}{'guser66'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser67'} = 1;
    $repos{'testing'}{W}{'guser67'} = 1;
    push @{ $repos{'testing'}{'guser67'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser68'} = 1;
    $repos{'testing'}{W}{'guser68'} = 1;
    push @{ $repos{'testing'}{'guser68'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser69'} = 1;
    $repos{'testing'}{W}{'guser69'} = 1;
    push @{ $repos{'testing'}{'guser69'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser7'} = 1;
    $repos{'testing'}{W}{'guser7'} = 1;
    push @{ $repos{'testing'}{'guser7'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser70'} = 1;
    $repos{'testing'}{W}{'guser70'} = 1;
    push @{ $repos{'testing'}{'guser70'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser71'} = 1;
    $repos{'testing'}{W}{'guser71'} = 1;
    push @{ $repos{'testing'}{'guser71'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser72'} = 1;
    $repos{'testing'}{W}{'guser72'} = 1;
    push @{ $repos{'testing'}{'guser72'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser73'} = 1;
    $repos{'testing'}{W}{'guser73'} = 1;
    push @{ $repos{'testing'}{'guser73'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser74'} = 1;
    $repos{'testing'}{W}{'guser74'} = 1;
    push @{ $repos{'testing'}{'guser74'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser75'} = 1;
    $repos{'testing'}{W}{'guser75'} = 1;
    push @{ $repos{'testing'}{'guser75'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser76'} = 1;
    $repos{'testing'}{W}{'guser76'} = 1;
    push @{ $repos{'testing'}{'guser76'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser77'} = 1;
    $repos{'testing'}{W}{'guser77'} = 1;
    push @{ $repos{'testing'}{'guser77'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser78'} = 1;
    $repos{'testing'}{W}{'guser78'} = 1;
    push @{ $repos{'testing'}{'guser78'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser79'} = 1;
    $repos{'testing'}{W}{'guser79'} = 1;
    push @{ $repos{'testing'}{'guser79'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser8'} = 1;
    $repos{'testing'}{W}{'guser8'} = 1;
    push @{ $repos{'testing'}{'guser8'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser80'} = 1;
    $repos{'testing'}{W}{'guser80'} = 1;
    push @{ $repos{'testing'}{'guser80'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser81'} = 1;
    $repos{'testing'}{W}{'guser81'} = 1;
    push @{ $repos{'testing'}{'guser81'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser82'} = 1;
    $repos{'testing'}{W}{'guser82'} = 1;
    push @{ $repos{'testing'}{'guser82'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser83'} = 1;
    $repos{'testing'}{W}{'guser83'} = 1;
    push @{ $repos{'testing'}{'guser83'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser84'} = 1;
    $repos{'testing'}{W}{'guser84'} = 1;
    push @{ $repos{'testing'}{'guser84'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser85'} = 1;
    $repos{'testing'}{W}{'guser85'} = 1;
    push @{ $repos{'testing'}{'guser85'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'guser9'} = 1;
    $repos{'testing'}{W}{'guser9'} = 1;
    push @{ $repos{'testing'}{'guser9'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user1'} = 1;
    $repos{'testing'}{W}{'user1'} = 1;
    push @{ $repos{'testing'}{'user1'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user10'} = 1;
    $repos{'testing'}{W}{'user10'} = 1;
    push @{ $repos{'testing'}{'user10'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user11'} = 1;
    $repos{'testing'}{W}{'user11'} = 1;
    push @{ $repos{'testing'}{'user11'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user12'} = 1;
    $repos{'testing'}{W}{'user12'} = 1;
    push @{ $repos{'testing'}{'user12'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user13'} = 1;
    $repos{'testing'}{W}{'user13'} = 1;
    push @{ $repos{'testing'}{'user13'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user14'} = 1;
    $repos{'testing'}{W}{'user14'} = 1;
    push @{ $repos{'testing'}{'user14'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user15'} = 1;
    $repos{'testing'}{W}{'user15'} = 1;
    push @{ $repos{'testing'}{'user15'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user16'} = 1;
    $repos{'testing'}{W}{'user16'} = 1;
    push @{ $repos{'testing'}{'user16'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user2'} = 1;
    $repos{'testing'}{W}{'user2'} = 1;
    push @{ $repos{'testing'}{'user2'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user3'} = 1;
    $repos{'testing'}{W}{'user3'} = 1;
    push @{ $repos{'testing'}{'user3'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user4'} = 1;
    $repos{'testing'}{W}{'user4'} = 1;
    push @{ $repos{'testing'}{'user4'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user5'} = 1;
    $repos{'testing'}{W}{'user5'} = 1;
    push @{ $repos{'testing'}{'user5'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user6'} = 1;
    $repos{'testing'}{W}{'user6'} = 1;
    push @{ $repos{'testing'}{'user6'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user7'} = 1;
    $repos{'testing'}{W}{'user7'} = 1;
    push @{ $repos{'testing'}{'user7'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user8'} = 1;
    $repos{'testing'}{W}{'user8'} = 1;
    push @{ $repos{'testing'}{'user8'} }, { 'refs/.*' => 'RW+' };
    $repos{'testing'}{R}{'user9'} = 1;
    $repos{'testing'}{W}{'user9'} = 1;
    push @{ $repos{'testing'}{'user9'} }, { 'refs/.*' => 'RW+' };
    push @{ $repos{'testing'}{'grussell'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser0'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser1'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser10'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser11'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser12'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser13'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser14'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser15'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser16'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser17'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser18'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser19'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser2'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser20'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser21'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser22'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser23'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser24'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser25'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser26'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser27'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser28'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser29'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser3'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser30'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser31'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser32'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser33'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser34'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser35'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser36'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser37'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser38'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser39'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser4'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser40'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser41'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser42'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser43'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser44'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser45'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser46'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser47'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser48'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser49'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser5'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser50'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser51'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser52'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser53'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser54'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser55'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser56'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser57'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser58'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser59'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser6'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser60'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser61'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser62'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser63'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser64'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser65'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser66'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser67'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser68'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser69'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser7'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser70'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser71'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser72'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser73'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser74'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser75'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser76'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser77'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser78'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser79'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser8'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser80'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser81'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser82'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser83'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser84'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser85'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'guser9'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user1'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user10'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user11'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user12'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user13'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user14'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user15'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user16'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user2'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user3'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user4'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user5'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user6'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user7'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user8'} }, { 'refs/heads/master' => '-' };
    push @{ $repos{'testing'}{'user9'} }, { 'refs/heads/master' => '-' };
    $repos{'testing'}{R}{'user11'} = 1;
    $repos{'testing'}{W}{'user11'} = 1;
    push @{ $repos{'testing'}{'user11'} }, { 'refs/heads/master' => 'RW' };
    $repos{'testing'}{R}{'user12'} = 1;
    $repos{'testing'}{W}{'user12'} = 1;
    push @{ $repos{'testing'}{'user12'} }, { 'refs/heads/master' => 'RW' };
    $repos{'testing'}{R}{'user13'} = 1;
    $repos{'testing'}{W}{'user13'} = 1;
    push @{ $repos{'testing'}{'user13'} }, { 'refs/heads/master' => 'RW' };
    $repos{'testing'}{R}{'user14'} = 1;
    $repos{'testing'}{W}{'user14'} = 1;
    push @{ $repos{'testing'}{'user14'} }, { 'refs/heads/master' => 'RW' };
    $repos{'testing'}{R}{'user15'} = 1;
    $repos{'testing'}{W}{'user15'} = 1;
    push @{ $repos{'testing'}{'user15'} }, { 'refs/heads/master' => 'RW' };
    $repos{'testing'}{R}{'user2'} = 1;
    $repos{'testing'}{W}{'user2'} = 1;
    push @{ $repos{'testing'}{'user2'} }, { 'refs/heads/master' => 'RW' };
    $repos{'testing'}{R}{'user3'} = 1;
    $repos{'testing'}{W}{'user3'} = 1;
    push @{ $repos{'testing'}{'user3'} }, { 'refs/heads/master' => 'RW' };
    $repos{'testing'}{R}{'grussell'} = 1;
    $repos{'testing'}{W}{'grussell'} = 1;
    push @{ $repos{'testing'}{'grussell'} }, { 'refs/heads/master' => 'RW+' };
    $repos{'testing'}{R}{'user16'} = 1;
    $repos{'testing'}{W}{'user16'} = 1;
    push @{ $repos{'testing'}{'user16'} }, { 'refs/heads/master' => 'RW+' };
    $repos{'testing'}{R}{'user2'} = 1;
    $repos{'testing'}{W}{'user2'} = 1;
    push @{ $repos{'testing'}{'user2'} }, { 'refs/heads/master' => 'RW+' };
    $repos{'testing'}{R}{'user3'} = 1;
    $repos{'testing'}{W}{'user3'} = 1;
    push @{ $repos{'testing'}{'user3'} }, { 'refs/heads/master' => 'RW+' };
    $repos{'testing'}{R}{'user4'} = 1;
    $repos{'testing'}{W}{'user4'} = 1;
    push @{ $repos{'testing'}{'user4'} }, { 'refs/heads/master' => 'RW+' };
    $repos{'testing'}{R}{'user5'} = 1;
    $repos{'testing'}{W}{'user5'} = 1;
    push @{ $repos{'testing'}{'user5'} }, { 'refs/heads/master' => 'RW+' };
}
