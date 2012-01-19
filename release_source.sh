#!/bin/bash
echo "The android source code is located at: $1"
echo "The miui source code is located at: $2"
echo "The released source code would be put at: $3"

echo "[IMPORTANT] make sure the source codes has been put under $1"

mv $1 $1.bak
src_dir=frameworks/base
android=$1.bak/$src_dir
android_rlz=$1/$src_dir
miui=$2/$src_dir
release=$3/$src_dir

for mf in `find $miui -name "*.java"`
do
       af=${mf/$miui/$android}
       if [ -f "$af" ]
       then
        diff $af $mf > /dev/null || {
                #echo $af is different with $mf;
                arf=${af/$android/$android_rlz}
                mkdir -p `dirname $arf`
                cp $af $arf
                rf=${mf/$miui/$release}
                mkdir -p `dirname $rf`
                cp $mf $rf
            }
       else
            echo "Have $mf but $af does not exist!"
            exit
       fi
done
echo "[IMPORTANT] The orignal android dir $1"
echo "[IMPORTANT] is left as $1.bak."
echo "[IMPORTANT] Please remove it before offical release!"
