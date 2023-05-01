package SelectValidFiles;

use strict;
use warnings;
use POSIX qw(strftime);
use feature 'say';
use experimental 'smartmatch';


sub listOriginFiles {
    my ($dcpath) = @_;
    
    opendir DIR, $dcpath;
    my @list_of_origins = readdir(DIR);
    close DIR;

    return @list_of_origins;
}

sub selectValidFiles {
    my ($dcpath, @list_of_origins) = @_;

    my @list_of_valids = ();
    
    foreach (@list_of_origins) {
        my $arq = $_;
        if ($arq ne "." && $arq ne ".." && $arq ne "backup") {
            my $cmd = `grep '<title>OPS. . .N&#xE3;o encontramos o que voc&#xEA; est&#xE1; procurando | Status Invest</title>' $dcpath/$arq`;
            if ($cmd eq "") {
                push(@list_of_valids, $arq);
            }
        }
    }
    return @list_of_valids;
}

sub copyValidFilesInOriginToValid {
    my ($p_origin, $p_valid, @list_of_valids) = @_;
    
    foreach (@list_of_valids) {
        my $arq = $_;
        system("cp $p_origin/$arq $p_valid");
    }
}

1;

