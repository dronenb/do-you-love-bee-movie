#! /usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
open(my $fh, "<", "beemovie.txt") or die $!;
my @words;
sleep(5);
while (my $line = <$fh>){
    chomp($line);
    if ($line && !($line eq '-')){
        foreach my $word (split(m/\s/, $line)){
            if (!($word eq '-')){
                $word = quotemeta($word);
                $word =~ s/'//g;
                $word =~ s/"//g;
                $word =~ s/\\//g;
                print("Sending word: $word\n");
                my $cmd = qq{osascript -e 'tell application "System Events" to keystroke "$word"'};
                system($cmd);
                sleep(1);
                system(q{osascript -e 'tell application "System Events" to key code 76'});
                sleep(1);
            }
        }
    }
}
