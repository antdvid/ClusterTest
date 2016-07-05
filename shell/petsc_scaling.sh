#!/bin/bash

for f in `ls petsc_test.o*`; do
    t=`grep "by zgao" $f`
    t=${t#*with }
    t=${t% processor*} 
    echo $t
    cp $f ./new_strong_scaling/petsc_test$t
done
