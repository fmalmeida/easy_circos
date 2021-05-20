#!/bin/bash

echo "Building package...."
env
echo "___________________"

# Update build
conda update --all --yes

# Copy main file
mkdir -p $PREFIX/bin  || exit 1;

cp $RECIPE_DIR/bin/* $PREFIX/bin/

# Fix perl
$PREFIX/bin/cpanm -i Statistics::Basic
