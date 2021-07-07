labels()
{
# Create label definition
read -r -d '' LABELS_CONF << EOM
# Labels
# to understand it more read: http://circos.ca/documentation/tutorials/2d_tracks/text_1/lesson
<plot>
label_snuggle    = yes
type             = text
color            = black
file             = ${LABELS}

r0 = 1r
r1 = 1r+200p

show_links     = yes
link_dims      = 4p,4p,8p,4p,4p
link_thickness = 5p
link_color     = black

label_size   = 30p

padding  = 0p
rpadding = 0p

</plot>
EOM
}
