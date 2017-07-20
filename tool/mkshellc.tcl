#!/usr/bin/tclsh
#
# Run this script to generate the "src/shell.c" source file from 
# constituent parts.
#
set topdir [file dir [file dir [file normal $argv0]]]
puts "Overwriting $topdir/src/shell.c with new shell source code..."
set out [open $topdir/src/shell.c wb]
puts $out {/* DO NOT EDIT!
** This file is automatically generated by the script in the canonical
** SQLite source tree at tool/mkshellc.tcl.  That script combines source
** code from various constituent source files of SQLite into this single
** "shell.c" file used to implement the SQLite command-line shell.
**
** Most of the code found below comes from the "src/shell.c.in" file in
** the canonical SQLite source tree.  That main file contains "INCLUDE"
** lines that specify other files in the canonical source tree that are
** inserted to getnerate this complete program source file.
**
** The code from multiple files is combined into this single "shell.c"
** source file to help make the command-line program easier to compile.
**
** To modify this program, get a copy of the canonical SQLite source tree,
** edit the src/shell.c.in" and/or some of the other files that are included
** by "src/shell.c.in", then rerun the tool/mkshellc.tcl script.
*/}
set in [open $topdir/src/shell.c.in rb]
while {![eof $in]} {
  set lx [gets $in]
  if {[regexp {^INCLUDE } $lx]} {
    set cfile [lindex $lx 1]
    puts $out "/************************* Begin $cfile ******************/"
    set in2 [open $topdir/src/$cfile rb]
    while {![eof $in2]} {
      set lx [gets $in2]
      if {[regexp {^#include "sqlite} $lx]} continue
      puts $out $lx
    }
    close $in2
    puts $out "/************************* End $cfile ********************/"
    continue
  }
  puts $out $lx
}
close $in
close $out
