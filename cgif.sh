#!/bin/bash

gifsicle -O3 --crop 130,62+784x688 --colors 256 --scale 0.5 < "$1" > "new_$1"
