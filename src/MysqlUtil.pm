package MysqlUtil;

use strict;
use warnings;


sub getConnection {
    my $host = "localhost";
    my $base = "maverick";
    my $user = "root";
    my $pass = "Cacau123@#";
    DBI->connect("DBI:mysql:database=maverick;host=localhost;port=3306", "root", "Cacau123@#");
}

1;

