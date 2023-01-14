#! /usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
open(my $fh, "<", "beemovie.txt") or die $!;
sleep(5);
my @words;
while (my $line = <$fh>){
    chomp($line);
    if ($line && !($line eq '-')){
        foreach my $word (split(m/\s/, $line)){
            if (!($word eq '-')){
                $word = quotemeta($word);
                $word =~ s/'//g;
                $word =~ s/"//g;
                $word =~ s/\\//g;
                push(@words, $word);
            }
        }
    }
}
foreach my $index (0..$#words){
    my $word = $words[$index];
    print("Sending word: $word [".($index + 1)."/".($#words + 1)."]\n");
    my $cmd = qq{osascript -e 'tell application "System Events" to keystroke "$word"'};
    system($cmd);
    sleep(1);
    system(q{osascript -e 'tell application "System Events" to key code 76'});
    sleep(1);
}
