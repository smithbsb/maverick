package FileUtil;

use strict;
use warnings;
use POSIX qw(strftime);
use feature 'say';


sub readCodes {
    my ($dcpath, $dcfile) = @_;
    
    my @list_of_codes = ();
    
    open(FH, '<', "$dcpath/$dcfile") or die "Erro ao carregar arquivo!";
    while (<FH>) {
        my $line = $_;
        chomp $line;
        if ($line ne "") {
            push(@list_of_codes, $line);
        }
    }
    close(FH);

    return @list_of_codes;
}

sub mountTickers {
    my (@list_of_codes) = @_;

    my @list_of_tickers = ();

    foreach (@list_of_codes) {
        my $code = $_;
        chomp $code;
        push(@list_of_tickers, $code."3");
        push(@list_of_tickers, $code."4");
        push(@list_of_tickers, $code."5");
        push(@list_of_tickers, $code."6");
        push(@list_of_tickers, $code."11");
    }
    return @list_of_tickers;
}

sub searchFileBySite {
    my ($dcpath, @list_of_tickers) = @_;

    foreach (@list_of_tickers) {
        my $ticker = $_;
        chomp $ticker;
        print "=>".$ticker."\n";
        my $file_name = strftime "%Y_%m_%d_$ticker.txt", localtime;
        
        system("curl -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36' https://statusinvest.com.br/acoes/$ticker > $dcpath/$file_name && wait");
    }
}

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
        if ($arq ne "." && $arq ne "..") {
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

