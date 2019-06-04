#!/usr/bin/tcsh

#2. I used this code to make the file
cat /ACTF/Course/inx_s19/data/hw5/pz_cDNAs.full.fasta | grep '>'|wc -l

cat /ACTF/Course/inx_s19/data/hw5/pz_cDNAs.full.fasta | grep 'PZ' | wc -l
cat /ACTF/Course/inx_s19/data/hw5/pz_cDNAs.full.fasta | perl -pe 's/^(>PZ[0-9]*)\ /\1_nogroup\ /g' > dr_obnoxious.fasta

#3
# I used this code to get the result:
cat dr_obnoxious.fasta | grep '>' | sed 's/_/\ /g' | awk '{print $2}' | sort -k1,1d | uniq -c | sort -k1,1nr | head
# A is the largest group, with 5753 sequences in it

#4
# This might be the wrong use case for a regex, but I wanted to mess around with them, so I came up with this
cat dr_obnoxious.fasta | perl -0777 -pe 's/^>.*?nReads=1\ .*?\n[G,T,A,C,N,\n]*//gm' > test.fasta
#this works because it includes the -0777 tag to slurp the whole file
cat dr_obnoxious.fasta | perl -pe 's/^>.*nReads=1\ .*\n[G,T,A,C,N,\n]*//gm' > pz_cDNAs.full.nosingles.fasta
#fails because it only processes line-by-line
#This preserves the number of reads and coverage, it just removes all the sequences with
#nReads=1 without doing anything else
cat dr_obnoxious.fasta | tr '\n' '@' | tr '>' '\n' | perl -pe 's/^[\w,_]*\ nReads=1\ .*@?[C,T,A,G,N,@]*//gm' |\
 tr '\n' '>' | tr '@' '\n' | less
#"reflow" technique- works identically, but kind of messy

#5
cat /ACTF/Course/inx_s19/data/hw6/yeast_proteins.fasta | grep '>' | awk '{print $1, $7}' | sed 's/,/ /g' |\
 sed '{if ($3) {next} else {print $0}} | wc -l
#This returns 5561
#This is clunky but it works:
cat /ACTF/Course/inx_s19/data/hw6/yeast_proteins.fasta | grep '>' | awk '{print $1, $7}' | sed 's/,/ /g' |\
 awk '{if($6) {print $0}}' | wc -l
#Interate until it returns "1" (if $8) then:
cat /ACTF/Course/inx_s19/data/hw6/yeast_proteins.fasta | grep '>' | awk '{print $1, $7}' | sed 's/,/ /g' |\
 awk '{if($8) {print $0}}'
#returns "Q0045 13818-13986 16435-16470 18954-18991 20508-20984 21995-22246 23612-23746 25318-25342 26229-26701"
#So our gene with the most exons in Q0045