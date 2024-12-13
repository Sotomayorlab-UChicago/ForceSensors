# script to calculate end to end distance of the atoms being pulled
set infile [open ALL_SMD.log.smd r];
set infile2 [open ALL_SMD.log.smd2 r];
set outfile [open ALL_SMD.log.dist w];
set data [read -nonewline $infile]
set data2 [read -nonewline $infile2]
set lines [split $data \n]
set lines2 [split $data2 \n]
set n [llength $lines]
for {set i 0} {$i < $n} {incr i} { # loop that goes thru the lines of data
    set line [lindex $lines $i]
    set words [split $line]
    set line2 [lindex $lines2 $i]
    set words2 [split $line2]
#    puts "[lindex $words 0] [lindex $words 1] [lindex $words 2] [lindex $words 3]  [lindex $words2 2] [expr pow([lindex $words 2]-[lindex $words2 2],2)]"
    puts $outfile "[expr sqrt(pow([lindex $words 3]-[lindex $words2 2],2)+pow([lindex $words 4]-[lindex $words2 3],2)+pow([lindex $words 5]-[lindex $words2 4],2))]" 
}
close $infile
close $infile2
close $outfile
quit

