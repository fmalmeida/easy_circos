write_circos_bacannot()
{
cat << EOF
# MINIMUM CIRCOS CONFIGURATION

# Defines unit length for ideogram and tick spacing, referenced
# using "u" prefix, e.g. 10u
chromosomes_units = 500000

# Show all chromosomes in karyotype file. By default, this is
# true. If you want to explicitly specify which chromosomes
# to draw, set this to 'no' and use the 'chromosomes' parameter.
${DEFAULT_LINE}
${CUSTOM_CHR_LINE}

# Chromosome name, size and color definition
karyotype = circos.sequences.txt

<<include etc/colors_fonts_patterns.conf>>
<colors>
</colors>

<image>
<<include etc/image.conf>>
# overwrite auto_alpha_steps from default value included in etc/image.conf
auto_alpha_steps* = 10
</image>

<ideogram>

<spacing>
# spacing between ideograms
default = 0.005r
</spacing>

#
# ideogram position, thickness and fill
#
radius           = 0.8r
thickness        = 15p
fill             = yes
stroke_color     = dgrey
stroke_thickness = 2p
show_label	     = no
show_bands       = yes
fill_bands       = yes
label_font	     = default
label_size	     = 30
label_radius	 = 1r + 75p
label_parallel	 = yes

</ideogram>

# Add plots
<plots>

#
# forward features
#
<plot>
type              = tile
layers_overflow   = collapse
file              = forward_features.txt
r1                = 1.000r
r0                = 0.930r
orientation       = out
layers            = 1
margin            = 0.01u
thickness         = 15
padding           = 8
stroke_color      = black
stroke_thickness  = 0
</plot>

#
# reverse features
#
<plot>
type              = tile
layers_overflow   = collapse
file              = reverse_features.txt
r1                = 0.930r
r0                = 0.860r
orientation       = out
layers            = 1
margin            = 0.01u
thickness         = 15
padding           = 8
stroke_color      = dgreen
stroke_thickness  = 0
</plot>

#
# rRNA features
#
<plot>
type              = tile
layers_overflow   = collapse
file              = rrna.txt
r1                = 0.860r
r0                = 0.790r
orientation       = out
layers            = 1
margin            = 0.01u
thickness         = 15
padding           = 8
stroke_color      = dorange
stroke_thickness  = 0
</plot>

#
# tRNA features
#
<plot>
type              = tile
layers_overflow   = collapse
file              = trna.txt
r1                = 0.790r
r0                = 0.720r
orientation       = out
layers            = 1
margin            = 0.01u
thickness         = 15
padding           = 8
stroke_color      = dpurple
stroke_thickness  = 0
</plot>

#
# Labels
# to understand it more read: http://circos.ca/documentation/tutorials/2d_tracks/text_1/lesson
#
<plot>
label_snuggle    = no
type             = text
color            = black
file             = bacannot_labels.txt
r0               = 0.600r
r1               = 0.720r
layers           = 1
orientation      = out
layers_overflow  = collapse
margin           = 0.02u
show_links       = no
# link_dims        = 4p,4p,8p,4p,4p
# link_thickness   = 5p
link_color       = black
label_size       = 20p
padding          = 0p
rpadding         = 0p
</plot>

#
# Mobile Genetic Elements
#
<plot>
type             = tile
file             = mges.txt
r1               = 0.550r
r0               = 0.500r
orientation      = center
layers           = 1
margin           = 0.01u
thickness        = 40.0
padding          = 1
stroke_color     = black
stroke_thickness = 0
layers_overflow  = collapse
</plot>

#
# GC Skew
#
<plot>
type        = histogram
file        = GC_skew.txt
r1          = 0.55r
r0          = 0.35r
thickness   = 3
max         = 0.49999999999999173
min         = -0.47826086956521324
extend_bin  = yes
orientation = out
</plot>

</plots>

# debugging, I/O an dother system parameters
<<include etc/housekeeping.conf>> # included from Circos distribution

show_ticks = yes
show_tick_labels = yes

<ticks>

skip_first_label = no
skip_last_label  = no
radius           = dims(ideogram,radius_outer)
tick_separation  = 2p
label_separation = 5p
multiplier       = 1e-6
color            = black
thickness        = 4p
size             = 20p

# with you desired more ticks, add new tick inclusions as the one shown. See: http://circos.ca/documentation/tutorials/ticks_and_labels/labels/configuration
<tick>
spacing        = 1u
show_label     = yes
label_size     = 30p
label_offset   = 10p
format         = %d
grid           = yes
grid_color     = black
grid_thickness = 1p
grid_start     = 0.5r
grid_end       = 0.999r
</tick>

<tick>
skip_first_label = yes
spacing        = 0.5u
show_label     = yes
label_size     = 30p
label_offset   = 10p
format         = %.2fMb
grid           = yes
grid_color     = black
grid_thickness = 1p
grid_start     = 0.5r
grid_end       = 0.999r
</tick>

</ticks>

EOF
}
