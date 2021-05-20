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
$PREFIX/bin/cpanm Module::Build Clone Config::General Font::TTF::Font GD GD::Polyline Math::Bezier Math::Round Math::VecStat Params::Validate Readonly Regexp::Common SVG Set::IntSpan Statistics::Basic Text::Format
