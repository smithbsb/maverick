#!/usr/bin/perl
# maverick.selectValidFiles.pl 
#
#
# Seleciona arquivos baixados pelo primeiro script 
# salvando na pasta valid somente os válidos
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
use FileUtil;



my @list_of_origins = ();
@list_of_origins = FileUtil::listOriginFiles($p_origin);


my @list_of_valids = ();
@list_of_valids = FileUtil::selectValidFiles($p_origin, @list_of_origins);


FileUtil::copyValidFilesInOriginToValid($p_origin, $p_valid, @list_of_valids);

