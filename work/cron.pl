######################################################
# cron -- by Scott McMahan
# Usage: cron <crontab file>
# Defaults to file named "crontab" in current directory
######################################################
use strict;
######################################################
# If you're not familiar with crontab files, they have lines
# with the following:
#
# min hour monthday month weekday command
#
# - Lines beginning with '#' are comments and are ignored.
# - The numeric entries can be separated by commas -- e.g. 1,2,3
# - Ranges for each are as follows:
# minute (0-59),
# hour (0-23),
# day of the month (1-31),
# month of the year (1-12),
# day of the week (0-6 with 0=Sunday).
######################################################
######################################################
# configuration section
######################################################
################
# Note there are two levels of logging: normal logging, controlled by
# the logfile variable, logs all commands executed and when they're
# executed. The message facility prints messages about everything that
# the program does, and is sent to the screen unless the msgfile
# variable is set. Use the msgfile only in emergencies, as voluminous
# output is generated (so much so that leaving msgfile active all night
# could exhaust available disk space on all but the most capacious
# systems) -- its primary purpose is for emergency debugging.
# Due to the peculiar construction of the log functions, the log and
# msg files can be the same file. This may or may not be good.
my $logfile = "cronlog.txt";
my $msgfile = ""; # assign this only in emergency
# end of configuration
#########################################################
#############
# in_csl searches for an element in a comma separated list
#########################################################
#############
sub in_csl {
   my ($what, $csl) = @_;
   CronMsg("Processing CSL");
   my @a = split(/,/, $csl);
   my $x;
   for $x (@a) {
      CronMsg("is $what equal to item $x?");
      if ($what eq $x) {
         return 1;
      }
   }
   return 0;
}
#########################################################
#############
# Range support -- suggested by Robin Berjon
#########################################################
#############
## Note: I have not had time to do range support or include it in
## the cron processing logic. This subroutine should get you started
## if you want to add it!
##
## sub in_rng {
## my ($what, $myrng) = @_;
## CronMsg("Processing range");
## my ($begin_rng, $end_rng) = split(/-/, $myrng);
## return 1 if ( ($what >= $begin_rng) && ($what <= $end_rng) );
## return 0;
## }
#########################################################
#############
# main program
######################################################
my $crontab;
if (defined $ARGV[0]) {
   CronAct("using $ARGV[0] as crontab file\n");
   $crontab = $ARGV[0];
}
else {
   CronAct("using default file crontab\n");
   $crontab = "crontab";
}
while (1) {
   open(F, "$crontab") or die "Can't open crontab; file
   $crontab: $!\n";
   my $line = 0;
   while (<F>) {
      $line++;
      if (/^$/) {
         CronMsg("blank line $line");
         next;
      }
      if (/^#/) {
         CronMsg("comment on line $line");
         next;
      }
      my ($sec, $min, $hour, $mday, $mon, $year,
         $wday, $yday, $isdst) = localtime(time);
      $mon++;
      my $date =
      sprintf("%0.2s/%0.2s/%0.4s", $mon, $mday, $year+1900);
      my $time=
      sprintf("%02.2s:%02.2s:%02.2s", $hour, $min, $sec);
      my ($tmin, $thour, $tmday, $tmon,
         $twday, $tcommand) = split(/ +/, $_, 6);
      CronMsg("it is now $time on $date;
         wday=$wday");
      CronMsg(
         "should we do $thour:$tmin on
         $tmon/$tmday/--, wday=$twday?");
      my $do_it = 0; # assume don't do it until proven otherwise
      # do it -- this month?
      if ( ($tmon eq "*") || ($mon == $tmon)
         || &in_csl($mon, $tmon)) {
         $do_it = 1;
         CronMsg("the month is valid");
      }
      else {
         $do_it = 0;
         CronMsg("cron: the month is
            invalid");
      }
      # do it -- this day of the month?
      if ( $do_it && ( ($tmday eq "*")
            || ($mday ==
               $tmday) || &in_csl($mday, $tmday)) ) {
         $do_it = 1;
         CronMsg("the day of month is
            valid");
      }
      else {
         $do_it = 0;
         CronMsg("the day of month is
            invalid");
      }
      # do it -- this day of the week?
      if ( $do_it && ( ($twday eq "*")
            || ($wday ==
               $twday) || &in_csl($wday, $twday)) ) {
         $do_it = 1;
         CronMsg("the day of week is valid");
      }
      else {
         $do_it = 0;
         CronMsg("the day of week is
            invalid");
      }
      # do it -- this hour?
      if ( $do_it && ( ($thour eq "*") ||
            ($hour ==
               $thour)|| &in_csl($hour, $thour) ) ) {
         $do_it = 1;
         CronMsg("the hour is valid");
      }
      else {
         $do_it = 0;
         CronMsg("the hour is invalid");
      }
      # do it -- this minute?
      if ( $do_it && ( ($tmin eq "*") ||
            ($min == $tmin)
            || &in_csl($min, $tmin) ) ) {
         $do_it = 1;
         CronMsg("the min is valid");
      }
      else {
         $do_it = 0;
         CronMsg("the minute is invalid");
      }
      if ($do_it) {
         chop $tcommand;
         CronAct("executing command
            <$tcommand>");
         system ("start $tcommand");
      }
   }
   close(F);
   CronMsg("***-----***");
   # The message is to reassure users who might encounter the window,
   # not know what it is, and wonder if it should be closed.
   print "
   ********************************************************
   * DO NOT CLOSE THIS WINDOW ** DO NOT CLOSE THIS WINDOW *
   ********************************************************
   The cron program runs in the background and kicks off jobs
   at certain times. It is an essential part of the system and
   required for keeping the network functioning properly.
   ********************************************************
   * DO NOT CLOSE THIS WINDOW ** DO NOT CLOSE THIS WINDOW *
   ********************************************************
   ";
   sleep(60);
}
exit;
#########################################################
#############
# Log activity
#########################################################
#############
sub CronAct {
   my ($sec, $min, $hour, $mday, $mon, $year, $wday,
      $yday, $isdst) =
   localtime(time);
   $mon++;
   my $date = sprintf("%0.2s/%0.2s/%0.4s", $mon, $mday,
      $year+1900);
   my $time= sprintf("%02.2s:%02.2s:%02.2s", $hour, $min,
      $sec);
   print "cron [$date $time]: @_\n";
   # since we're appending the log, always open it only as little
   # as necessary, so if we crash the info will be there
   open(LOGFILE, ">>$logfile") or return;
   print LOGFILE "cron [$date $time]: @_\n";
   close(LOGFILE);
}
#########################################################
#############
# routine to log messages
# logs to screen unless $msgfile is set to a filename
#########################################################
#############
sub CronMsg {
   my ($sec, $min, $hour, $mday, $mon, $year, $wday,
      $yday, $isdst) =
   localtime(time);
   $mon++;
   my $date = sprintf("%0.2s/%0.2s/%0.4s", $mon, $mday,
      $year+1900);
   my $time= sprintf("%02.2s:%02.2s:%02.2s", $hour, $min,
      $sec);
   print "cron*[$date $time]: @_\n";
   return unless $msgfile;
   # since we're appending the log, always open it only as little
   # as necessary, so if we crash the info will be there
   open(LOGFILE, ">>$logfile") or return;
   print LOGFILE "cron*[$date $time]: @_\n";
   close(LOGFILE);
}
