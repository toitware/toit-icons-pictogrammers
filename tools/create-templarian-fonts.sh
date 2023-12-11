#!/bin/sh

# Copyright (C) 2023 Toitware ApS. All rights reserved.

# Produce verbose or terse .toit files.
VERBOSE=
#VERBOSE=--verbose

set -e

touch tools/.font  # Should be run from top level packagpackage directory.
mkdir -p tools/font/tmp
rm -rf tools/font/tmp/*
cd tools/font/tmp

DIR_PKG=../../..
DIR_WEBFONTS=$DIR_PKG/third_party/MaterialDesign-Webfont
OUT_100DPI=$DIR_PKG/src/
TOITRUN=toit.run
CONVERT="../../../../../toitlang/toit-font-tools/bin/convertfont.toit"
FONT_FORGE="fontforge $DIR_PKG/tools/convert.fontforge"

mkdir -p $OUT_100DPI

# TODO(3279): For larger sizes we need to fix the issue that limits font files
# to 4k.
# Smaller sizes than 20 are too ugly in automatically rasterized icons.
# Larger sizes than 96 create too large font files, currently.
for size in 20 24 32 40 48 64 80 96 
do
  echo $size
  $FONT_FORGE $DIR_WEBFONTS/fonts/materialdesignicons-webfont.ttf $size icons.bdf
  echo $TOITRUN $CONVERT --copyright_file $DIR_WEBFONTS/LICENSE icons-$size.bdf "Material Design Icons" $OUT_100DPI/size_${size}.toit &
  $TOITRUN $CONVERT --copyright_file $DIR_WEBFONTS/LICENSE icons-$size.bdf "Material Design Icons" $OUT_100DPI/size_${size}.toit &
done
wait  # Wait for backgrounded jobs.
cp $DIR_WEBFONTS/LICENSE $DIR_PKG
cp $DIR_WEBFONTS/README.md $OUT_100DPI
exit 0
