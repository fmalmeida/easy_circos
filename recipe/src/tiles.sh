tiles()
{

# copy file
echo -e "#chr\tstart\tend\toptions\tcomment" > ${RESULTS}/conf/circos_tiles.txt ;
grep -v "^#" ${TILES} >> ${RESULTS}/conf/circos_tiles.txt

if [ "$SKIP_GC" = "no" ]
then
    export R1_tiles="0.85r"
    export R2_tiles="0.75r"
    export LINKS_RADIUS="0.7r"
else
    export R1_tiles="0.95r"
    export R2_tiles="0.85r"
    export LINKS_RADIUS="0.8r"
fi

# Create label definition
read -r -d '' TILES_CONF << EOM
# Tiles
# to understand its configuration read: http://circos.ca/documentation/tutorials/2d_tracks/tiles/configuration
<plot>
type              = tile
layers_overflow   = collapse
file              = circos_tiles.txt
r1                = ${R1_tiles}
r0                = ${R2_tiles}
orientation       = out

layers      = 5
margin      = 0.02u
thickness   = 15
padding     = 8

stroke_thickness = 1
stroke_color     = grey

<backgrounds>
<background>
color = vvlgrey
</background>
</backgrounds>

</plot>
EOM
}
