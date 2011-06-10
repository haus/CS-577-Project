#!/usr/bin/env bash

rvm jruby
fabl="ruby -J-classpath 'src:src/:src/frontend.jar:sandbox/:.' sandbox/integration.rb"

for F in `ls bm/fab/*.fab`;
do 
	echo $F
	filename=${F%.*b}      #  Strip ".fab" suffix off
	
	fablCMD="$fabl $F"
	$fablCMD 2> $filename.ll
	llc -o $filename.s $filename.ll
#	echo $fablCMD
#	echo $comp
#	break
done

mv bm/fab/*.ll bm/llvm-ir
mv bm/fab/*.s bm/llvm-assembly