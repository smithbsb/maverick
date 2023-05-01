#!/usr/bin/perl
# maverick.selectValidFiles.pl 
#
#
# O prineiro script baixa todos os tickers para cada code
# code que exista no arquvio de configuração, portanto vem
# muito lixo. Este script pega cada arquivo da pasta 'out/origin'
# e veja se há dados dentro, os que houver ele copia para
# a pasta 'out/valid'.
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
my $p_valid = "$maverick/out/valid";

use lib "$maverick/src";
use SelectValidFiles;



#
# lista arquivos da pasta 'out/origin'
my @list_of_origins = ();
@list_of_origins = SelectValidFiles::listOriginFiles($p_origin);



#
# seleciona apenas arquivos que tenham dados
my @list_of_valids = ();
@list_of_valids = SelectValidFiles::selectValidFiles($p_origin, @list_of_origins);



#
# copia arquivos que tenham dados para pasta 'out/valid'
SelectValidFiles::copyValidFilesInOriginToValid($p_origin, $p_valid, @list_of_valids);



