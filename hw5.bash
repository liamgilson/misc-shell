#!/usr/bin/tcsh

#2. I got 505 using:
cat /ACTF/Course/inx_s19/data/hw5/gene_exp.diff | grep 'yes' | awk '{if($10>0) {print $0}}'>count.txt
wc -l count.txt
#512 count.txt

#3. I got 34609 using
 cat /ACTF/Course/inx_s19/data/hw5/pz_cDNAs.full.fasta | grep '>'|wc -l
#34609
 
#4. I got 15743 using
cat /ACTF/Course/inx_s19/data/hw5/pz_cDNAs.full.fasta | grep '>' | grep 'nReads=1 ' | wc -l
#15743

#5. a) I got 21237 using
cat /ACTF/Course/inx_s19/data/hw5/pz_cDNAs.full.fasta | grep '>' | grep -v '_' | wc -l
#21237

#5. b) I got PZ7180000032376 using
cat /ACTF/Course/inx_s19/data/hw5/pz_cDNAs.full.fasta | grep '>' | grep -v '_' | sed 's/cov=//g' | sort -k3,3gr | head -1
#PZ7180000032376 nReads=629 400.477

#6. I got 1613 with
cat /ACTF/Course/inx_s19/data/hw5/pz_cDNAs.full.fasta | grep '>' | grep '_' | perl -pe 's/.*_(\w{1,})\b.*/\1/g' |\
 sort -u | wc -l
#1613
