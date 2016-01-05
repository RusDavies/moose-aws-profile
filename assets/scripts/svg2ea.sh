#!/bin/bash

#
# Convert SVG files into formats required for Sparx Systems Enterprise Architect profiles. 
#

find . -iname "*.svg" | while read line
do 
  dir=$(dirname "$line")
  file=$(basename "$line")
  pushd "$dir" &> /dev/null

  echo -n "Converting $line... "

  # Convert to EMF & WMF formats, which are useful as alternative images for elements.
#  inkscape --file "$file" --export-area-drawing --export-wmf "${file%.svg}.wmf"
  inkscape --file "$file" --export-area-drawing --export-emf "${file%.svg}.emf"

  # Convert to 16x16 bitmaps, which is useful for icons in toolboxes and the project browser. 
  convert "$file" -auto-orient -thumbnail "16x16>" -background white -gravity center -extent 16x16 -unsharp 0x3+1.5+0.01963+1.5+0.01963+1.5+0.0196 "${file%.*}.bmp"
  
  echo "Done"
  popd &> /dev/null
done



