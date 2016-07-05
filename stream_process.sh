#!/bin/bash

printf "%-8s %-15s %-15s %-15s %-15s %-15s %-15s %-15s %-15s\n" "%cores" \
"CopyBandwidth" "CopyTime" \
"ScaleBandwidth" "ScaleTime" \
"AddBandwidth" "AddTime" \
"TriadBandwidth" "TriadTime"

filebase="./stream_test.o*"
for f in `ls $filebase`; do
	ranks=`grep "MPI ranks" $f`
	ranks=${ranks#*across }
	ranks=${ranks% MPI*}

	copydata=(`grep "Copy:" $f`)
	copyband=${copydata[1]}
	copytime=${copydata[2]}

	adddata=(`grep "Add:" $f`)
	addband=${adddata[1]}
	addtime=${adddata[2]}

	scaledata=(`grep "Scale:" $f`)
	scaleband=${scaledata[1]}
	scaletime=${scaledata[2]}

	triaddata=(`grep "Triad:" $f`)
	triadband=${triaddata[1]}
	triadtime=${triaddata[2]}
	printf "%-8d %-15f %-15f %-15f %-15f %-15f %-15f %-15f %-15f\n" "$ranks" \
		 $copyband $copytime \
		 $scaleband $scaletime \
		 $addband $addtime \
		 $triadband $triadtime
done
