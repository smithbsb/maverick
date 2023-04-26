#!/usr/bin/perl
# maverick.downloadFilesFromSite.pl 
#
#
# Recuperar arquivos do site statusinvest.com 
# usando a lista de tickers como parametro.
#
#
#  Empresa: Smith Softwares
#  WebSite: smithsoftwares.com
#    Autor: Cesar Smith
#     Data: 2023-04-25
#
my $version = 1.001;
# 1.001 - 2023-04-25 - Versão Inicial
#

use strict;
use warnings;
use POSIX qw(strftime);
use LWP::UserAgent;
use feature 'say';
use Data::Dumper;

my $maverick;
BEGIN { $maverick = "/opt/maverick"; }
my $p_conf = "$maverick/conf";
my $p_origin = "$maverick/out/origin";

use lib "$maverick/src";
use FileUtil;


my @list_of_codes = ();
@list_of_codes = FileUtil::readCodes($p_conf, '20230425_codes.txt');


my @list_of_tickers = ();
@list_of_tickers = FileUtil::mountTickers(@list_of_codes);
print Dumper @list_of_tickers;


FileUtil::searchFileBySite($p_origin, @list_of_tickers);


