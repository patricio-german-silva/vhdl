#!/bin/bash
test -e work-obj93.cf && rm work-obj93.cf

for file in $(ls *.vhd) ; do
   name=$(basename -s .vhd "$file")
   lname=$(echo ${name} | tr '[:upper:]' '[:lower:]')
   for i in "$lname" "e~${lname}.o" "${name}.o" "${name}.vcd" ; do
      test -e "$i" && rm "$i"
   done
done
