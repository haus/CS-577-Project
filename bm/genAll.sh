#!/usr/bin/env bash

rvm jruby
fabl="ruby -J-classpath 'src:src/:src/frontend.jar:sandbox/:.' sandbox/integration.rb"

for F in `ls bm/fab/*.fab`;
do 
	echo $F
	filename=${F%.*b}      #  Strip ".fab" suffix off
	
	fablCMD="$fabl $F none"
	$fablCMD 2> $filename.ll
	llc -o $filename.s $filename.ll
	gcc -o $filename.bin $filename.s
done

mv bm/fab/*.ll bm/llvm-ir-noOpt
mv bm/fab/*.s bm/llvm-assembly-noOpt
mv bm/fab/*.bin bm/llvm-binary-noOpt

for F in `ls bm/fab/*.fab`;
do 
	echo $F
	filename=${F%.*b}      #  Strip ".fab" suffix off
	
	fablCMD="$fabl $F half"
	$fablCMD 2> $filename.ll
	llc -o $filename.s $filename.ll
	gcc -o $filename.bin $filename.s
done

mv bm/fab/*.ll bm/llvm-ir-halfOpt
mv bm/fab/*.s bm/llvm-assembly-halfOpt
mv bm/fab/*.bin bm/llvm-binary-halfOpt

for F in `ls bm/fab/*.fab`;
do 
	echo $F
	filename=${F%.*b}      #  Strip ".fab" suffix off
	
	fablCMD="$fabl $F full"
	$fablCMD 2> $filename.ll
	llc -o $filename.s $filename.ll
	gcc -o $filename.bin $filename.s
done

mv bm/fab/*.ll bm/llvm-ir-fullOpt
mv bm/fab/*.s bm/llvm-assembly-fullOpt
mv bm/fab/*.bin bm/llvm-binary-fullOpt