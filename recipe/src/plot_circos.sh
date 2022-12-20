plot_circos()
{
# get current dir
CURRENT_DIR=$PWD

# got to conf dir
cd ${RESULTS}/conf/

# get etc/files
cp -r $(which circos | sed 's|/circos$|/../etc|g') .

sed -i "s/max_ticks.*= 5000/max_ticks = ${MAX_TICKS}/" etc/housekeeping.conf
sed -i "s/max_ideograms.*= 200/max_ideograms = ${MAX_IDEOGRAMS}/" etc/housekeeping.conf
sed -i "s/max_links.*= 25000/max_links = ${MAX_LINKS}/" etc/housekeeping.conf
sed -i "s/max_points_per_track.*= 25000/max_points_per_track = ${MAX_POINTS_PER_TRACK}/" etc/housekeeping.conf

# draw
circos

# go back
cd $CURRENT_DIR
}
