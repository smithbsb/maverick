#!/usr/bin/perl
# maverick.deleteDuplicates.pl 
#
#
# Deleta tickers duplicados, selecionados pelo
# maior volume.
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
my $p_valid = "$maverick/out/valid";
my $p_final = "$maverick/out/final";

use lib "$maverick/src";
use FileUtil;



my @list_of_valids = ();
@list_of_valids = FileUtil::listValidFiles($p_valid);


my @list_of_uniques = FileUtil::selectUniqueFilesFromValid($p_valid, @list_of_valids);
my @list_of_duplicates = FileUtil::selectDuplicateFilesFromValid($p_valid, @list_of_valids);

my @sort_duplicates = sort @list_of_duplicates;

print Dumper @sort_duplicates;


#my @list_of_valids = ();
#@list_of_valids = FileUtil::selectValidFiles($p_origin, @list_of_origins);


#FileUtil::copyValidFilesInOriginToValid($p_origin, $p_valid, @list_of_valids);

