#!/bin/bash

mkdir -p bmps

convert moose.svg -transparent white ./bmps/moose.bmp
convert btinc_logo.svg -transparent white ./bmps/btinc_logo.bmp
convert btinc_logo_with_text.svg -transparent white ./bmps/btinc_logo_with_text.bmp
convert btinc_logo_with_text_flat_b.svg -transparent white ./bmps/btinc_logo_with_text_flat_b.bmp

