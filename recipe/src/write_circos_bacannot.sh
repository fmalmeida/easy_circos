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

# ideogram position, thickness and fill
radius           = 0.85r
thickness        = 30p
fill             = yes
show_label	     = yes
label_font	     = default
label_size	     = 40
label_radius	 = 1r + 100p
label_parallel	 = yes

</ideogram>

# Add plots
<plots>

#
# forward features
#
<plot>
type              = tile
layers_overflow   = grow
file              = forward_features.txt
r1                = 1r
r0                = 0.85r
orientation       = out
layers            = 5
margin            = 0.02u
thickness         = 15
padding           = 8
stroke_thickness  = 1
stroke_color      = grey # TODO
</plot>

#
# reverse features
#
<plot>
type              = tile
layers_overflow   = grow
file              = reverse_features.txt
r1                = 0.85r
r0                = 0.75r
orientation       = out
layers            = 5
margin            = 0.02u
thickness         = 15
padding           = 8
stroke_thickness  = 1
stroke_color      = grey # TODO
</plot>

#
# rRNA features
#
<plot>
type              = tile
layers_overflow   = grow
file              = rrna.txt
r1                = 0.75r
r0                = 0.65r
orientation       = out
layers            = 5
margin            = 0.02u
thickness         = 15
padding           = 8
stroke_thickness  = 1
stroke_color      = grey # TODO
</plot>

#
# tRNA features
#
<plot>
type              = tile
layers_overflow   = grow
file              = trna.txt
r1                = 0.65r
r0                = 0.55r
orientation       = out
layers            = 5
margin            = 0.02u
thickness         = 15
padding           = 8
stroke_thickness  = 1
stroke_color      = grey # TODO
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

#
# Labels
# to understand it more read: http://circos.ca/documentation/tutorials/2d_tracks/text_1/lesson
#
<plot>
label_snuggle    = yes
type             = text
color            = black
file             = bacannot_labels.txt
r0               = 1r
r1               = 1r+500p
show_links       = yes
link_dims        = 4p,4p,8p,4p,4p
link_thickness   = 5p
link_color       = black
label_size       = 30p
padding          = 0p
rpadding         = 0p
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
