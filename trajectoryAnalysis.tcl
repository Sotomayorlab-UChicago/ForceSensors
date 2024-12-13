set mol1 [mol new system.psf type psf waitfor all]
set c 3 # number of trajectrory files
set folder "folderX"
set systemName "system"
set sep "_"
cd $folder
for {set i 1} {$i <= $c} {incr i} {
	mol addfile $systemName$folder$sep$i.dcd type dcd step 10 waitfor all
}

cd ..
mkdir analysis$folder
cd analysis$folder 
package require pbctools
pbc unwrap -all 
#set complex "protein and noh"
set prot "protein and name CA"
set nuc "nucleic and noh"


#Fuction to align the trajectery
proc align {seltext } {
  set ref [atomselect  top $seltext frame 0]
  set sel [atomselect top $seltext]
  set all [atomselect top all]
  set n [molinfo top get numframes]

  for { set i 0 } { $i < $n } { incr i } {
    $sel frame $i   
    $all frame $i
    $all move [measure fit $sel $ref]
  }
  return
}
#function to calculate radius of gyration
proc radG {fname seltext} {
  set outfile [open $fname w];
  set sel [atomselect top $seltext]
  for { set f 0 } { $f < [molinfo top get numframes] } { incr f } {
    $sel frame $f
    set t [expr $f*0.1]
    set rgyr [measure rgyr $sel]
    puts $outfile "$t $rgyr"
  } 
  close $outfile	
}
#Prcedure to calculate distances over the course of the trajectory
proc bonDistsel {fname sel1 sel2 } {
  set atm1 [[atomselect top $sel1] get index]
  set atm2 [[atomselect top $sel2] get index]
  set outfile [open $fname w];
  set n [molinfo top get numframes]
  for { set f 0 } { $f < $n } { incr f } {
    set t [expr $f*0.1]
    set bondist [measure bond [list $atm1 $atm2] frame $f]
    set bondistnm [expr $bondist*0.1]
    puts $outfile "$t $bondistnm"
  } 
	close $outfile
}

	

#align $nuc
#align $prot 
#radG ABCD_radius_gyration.dat $protChains
#bonDistsel $folder.dat "protein and resid 73 and name CA" "protein and resid 97 and name CA"


