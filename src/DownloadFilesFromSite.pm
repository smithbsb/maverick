package DownloadFilesFromSite;

use strict;
use warnings;
use POSIX qw(strftime);
use feature 'say';
use experimental 'smartmatch';


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

1;

