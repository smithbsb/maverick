#!/usr/bin/perl
# maverick.downloadFilesFromSite.pl 
#
#
# Recupera arquivos do site 'statusinvest.com' 
# usando a lista de tickers como parametro que
# foi salva na variável '$file_conf' e descarrega
# os arquivos na pasta 'out/origin'.
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

my $file_conf = '20230425_codes.txt'; # alterar aqui o arquivo conf

my $maverick;
BEGIN { $maverick = "/opt/maverick"; }
my $p_conf = "$maverick/conf";
my $p_origin = "$maverick/out/origin";

use lib "$maverick/src";
use DownloadFilesFromSite;



#
# monta lista com códigos passados no arquivo de configuração
my @list_of_codes = ();
@list_of_codes = DownloadFilesFromSite::readCodes($p_conf, $file_conf);



#
# monta lista com tickers a seres baixados
my @list_of_tickers = ();
@list_of_tickers = DownloadFilesFromSite::mountTickers(@list_of_codes);
print Dumper @list_of_tickers;



#
# baixa arquivos do site 'status invest' conforme ticker passado
DownloadFilesFromSite::searchFileBySite($p_origin, @list_of_tickers);



