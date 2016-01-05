#!/bin/bash

find . -iname "*.png" | while read line
do 
  dir=$(dirname "$line")
  file=$(basename "$line")
  pushd "$dir" &> /dev/null

  echo -n "Converting $line... "
  for i in 16x16
    do 	
      mkdir -p ${i}
      convert "$file" -auto-orient -thumbnail "${i}>" -background white -gravity center -extent ${i} -unsharp 0x.5 -trim "./${i}/${file%.*}.bmp"
    done
  echo "Done"
  popd &> /dev/null
done


