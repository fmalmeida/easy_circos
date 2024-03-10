gc_skew()
{
# exec GCcalc.py
$CONDA_PREFIX/bin/python3 $CONDA_PREFIX/bin/GCcalc.py -f ${RESULTS}/concatenated_genomes.fasta -w $GCWINDOW -s $GCSTEP | \
    cut -f 1,2,3,5 | awk '{ if ($4 > 0) print $0 "\t" "color=dblue"; else print $0 "\t" "color=red"}' > ${RESULTS}/conf/GC_skew.txt

# Create label definition
read -r -d '' GC_CONF << EOM
# GC Skew
<plot>
type        = histogram
file        = GC_skew.txt
r1          = 1r
r0          = 0.85r
thickness   = 3
max         = 0.49999999999999173
min         = -0.47826086956521324
extend_bin  = yes
orientation = out
</plot>
EOM
}
