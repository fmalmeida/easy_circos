#!/bin/bash

# Simple script to create a circos plot between two FASTA files.

############
### Help ###
############
Help()
{
cat << EOF

Simple script to create a circos plot between two FASTA files.
Copyright, Felipe Almeida <almeidafmarques@outlook.com>, 2021

 Syntax: plot_circos.sh [-h] [--fasta1 <fasta> --fasta2 <fasta> --outdir <outdir> --fasta1_prefix <str> --fasta2_prefix <str> --minlen <int> ...]

 Options:

 # Help
 -h/--help                           Print this help

 # Output
 --outdir                            Path to output directory [Default: ./results]

 # Input files
 --fasta1                            Path to the 1st FASTA file
 --fasta2                            Path to the 2nd FASTA file

 # Input files prefixes
 # This will rename the contigs as \${prefix}contigname so you
 # can readily identify the species in the plot. Not required.
 --fasta1_prefix                     Prefix for naming fasta1 contigs when creating karyotypes [Default: ""]
 --fasta2_prefix                     Prefix for naming fasta2 contigs when creating karyotypes [Default: ""]

 # Input min. length
 --minlen                            Min size of contigs to consider for plot [Default: 10000]

 # Input file colors
 # Which color to use for each fasta
 # See Circos accepted colors
 --fasta1_color                      Color for fasta 1 [Default: lorange]
 --fasta2_color                      Color for fasta 2 [Default: blue]

 # Links (blastn) min. percentage id
 --minid                             Min. percentage id to filter the results of blastn to draw links [Default: 85]
 --linklen                           Min. link (blastn hit) length to display in plot [Default: 5000]

 # GC skew config
 --gc_window                         GC skew window size [Default: 5000]
 --gc_step                           GC skew step size [Default: 5000]


EOF
}

################
### Defaults ###
################
RESULTS="./results" # tmp directory
FASTA1=""
FASTA1_PREFIX=""
FASTA1_COLOR="lorange"
FASTA2=""
FASTA2_PREFIX=""
FASTA2_COLOR="blue"
MINLEN=10000
MINID=85
MINLINKLEN=5000
GCWINDOW=5000
GCSTEP=5000

######################################
### Function to filter FASTA files ###
######################################
filter()
{
# create results dir
mkdir -p $RESULTS

# create dir for files
mkdir -p ${RESULTS}/filtered

# filter genome
name="$(basename $FASTA1)" ;
$CONDA_PREFIX/bin/perl $CONDA_PREFIX/bin/removesmalls.pl $MINLEN $FASTA1 >>${RESULTS}/filtered/"$name" ;
export FILTERED_FASTA1=${RESULTS}/filtered/"$name"
name="$(basename $FASTA2)" ;
$CONDA_PREFIX/bin/perl $CONDA_PREFIX/bin/removesmalls.pl $MINLEN $FASTA2 >>${RESULTS}/filtered/"$name" ;
export FILTERED_FASTA2=${RESULTS}/filtered/"$name"
}

##########################################
### Function to create karyotype files ###
##########################################
karyotype()
{
# create dir
mkdir -p ${RESULTS}/conf

# for FASTA1
bioawk -c fastx -v p1=$FASTA1_PREFIX -v color1=$FASTA1_COLOR '{ printf "chr - " substr($name,1) " " p1 substr($name,1) " " "0" " " length($seq) " " color1"\n" }' $FILTERED_FASTA1 >> ${RESULTS}/conf/circos.sequences.txt

# for FASTA2
bioawk -c fastx -v p2=$FASTA2_PREFIX -v color2=$FASTA2_COLOR '{ printf "chr - " substr($name,1) " " p2 substr($name,1) " " "0" " " length($seq) " " color2"\n" }' $FILTERED_FASTA2 >> ${RESULTS}/conf/circos.sequences.txt
}

#############################################
### Function to find links between fastas ###
#############################################
find_links()
{
# create dir
mkdir -p ${RESULTS}/all_vs_all_blast

# concatenate genomes
cat $FILTERED_FASTA1 $FILTERED_FASTA2 >> ${RESULTS}/all_vs_all_blast/concatenated_genomes.fasta ;
export CONCAT_FASTA=${RESULTS}/all_vs_all_blast/concatenated_genomes.fasta

# Run blast
blastn -task blastn -perc_identity $MINID -query $CONCAT_FASTA -subject $CONCAT_FASTA \
    -outfmt "6 qseqid qstart qend sseqid sstart send pident length mismatch gapopen evalue bitscore stitle" \
    -out ${RESULTS}/all_vs_all_blast/tmp.blast

# Filter blast
awk -F '\t' -v minid=$MINID '{ if ($7 >= minid) { print } }' ${RESULTS}/all_vs_all_blast/tmp.blast > ${RESULTS}/all_vs_all_blast/all_vs_all.blast

# Remove tmp
rm ${RESULTS}/all_vs_all_blast/tmp.blast
}

#########################################################################
### Function to parse blastn (links) and create conf file with colors ###
#########################################################################
parse_links()
{
# create dir
mkdir -p ${RESULTS}/conf

# Filter blocks with more then N bp hits
awk -v minlen=$MINLINKLEN '{ if ($8 >= minlen) { print } }' ${RESULTS}/all_vs_all_blast/all_vs_all.blast | cut -f 1,2,3,4,5,6 >> ${RESULTS}/conf/links_concatenated.txt ;

# get links comming from contigs of FASTA1 and give it colors
bioawk -c fastx '{ printf $name"\n" }' $FASTA1 > tmp_names.fasta1 ;
awk -v color1=$FASTA1_COLOR -F'\t' 'NR==FNR{c[$1]++;next};c[$1] > 0 {print $0 "\t" "color="color1}' tmp_names.fasta1 ${RESULTS}/conf/links_concatenated.txt > ${RESULTS}/conf/links_concatenated_colored.txt
rm tmp_names.fasta1 ;

# get links comming from contigs of FASTA2 and give it colors
bioawk -c fastx '{ printf $name"\n" }' $FASTA2 > tmp_names.fasta2 ;
awk -v color2=$FASTA2_COLOR -F'\t' 'NR==FNR{c[$1]++;next};c[$1] > 0 {print $0 "\t" "color="color2}' tmp_names.fasta2 ${RESULTS}/conf/links_concatenated.txt > ${RESULTS}/conf/links_concatenated_colored.txt
rm tmp_names.fasta2 ;
}

#############################################################################
### Function to sort and remove duplicates from links and karyotype files ###
#############################################################################
dedup()
{
for file in $(ls ${RESULTS}/conf/*); do
    sort -u $file > tmp.txt ;
    cat tmp.txt > $file ;
    rm tmp.txt
done
}

###############################################
### Function to check which chrs have links ###
###############################################
check_links()
{
# get chrs with links
CHRS=$(cut -f 1 ${RESULTS}/conf/links_concatenated.txt | sort -u | tr '\n' ';')

# export LINE
export CUSTOM_CHR_LINE="chromosomes = "${CHRS}
}

#########################################################
### Function to create GC skew file proper for Circos ###
#########################################################
gc_skew()
{
# exec GCcalc.py
$CONDA_PREFIX/bin/python3 $CONDA_PREFIX/bin/GCcalc.py -f ${RESULTS}/all_vs_all_blast/concatenated_genomes.fasta -w $GCWINDOW -s $GCSTEP | \
    cut -f 1,2,3,5 | awk '{ if ($4 > 0) print $0 "\t" "color=blue"; else print $0 "\t" "color=orange"}' > ${RESULTS}/conf/GC_skew.txt
}

###########################################
### Function to create circos.conf file ###
###########################################
write_circos()
{
cat << EOF
# MINIMUM CIRCOS CONFIGURATION

# Defines unit length for ideogram and tick spacing, referenced
# using "u" prefix, e.g. 10u
chromosomes_units = 1000000

# Show all chromosomes in karyotype file. By default, this is
# true. If you want to explicitly specify which chromosomes
# to draw, set this to 'no' and use the 'chromosomes' parameter.
chromosomes_display_default = no
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
radius           = 0.9r
thickness        = 30p
fill             = yes
show_label	     = no
label_font	     = default
label_size	     = 40
label_radius	 = 1r + 75p
label_parallel	 = yes

</ideogram>

<links>
	<link>
		show     = yes
		ribbon   = no
		file     = links_concatenated_colored.txt
		radius   = 0.8r
		tickness = 15

	<rules>

	<rule>
	 # Do not show intra-chromossome links
   condition  = var(intrachr)
   show       = no
  </rule>

	</rules>

	</link>
</links>

# Add plots
<plots>

<plot>
type        = histogram
file        = GC_skew.txt
r1          = 1.0r
r0          = 0.8r
thickness   = 2
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

<tick>
spacing        = 1u
show_label     = no
thickness      = 2p
color          = dgrey
</tick>

<tick>
spacing        = 2.5u
show_label     = no
thickness      = 3p
color          = vdgrey
</tick>

<tick>
spacing        = 5.5u
show_label     = yes
label_size     = 20p
label_offset   = 10p
format         = %d
grid           = yes
grid_color     = dgrey
grid_thickness = 1p
grid_start     = 0.5r
grid_end       = 0.999r
</tick>

</ticks>

EOF
}

###############################
### Function to plot circos ###
###############################
plot_circos()
{
# get current dir
CURRENT_DIR=$PWD

# got to conf dir
cd ${RESULTS}/conf/

# draw
circos

# go back
cd $CURRENT_DIR
}


################################
### Get positional arguments ###
################################

# No arguments given
if [ $# -eq 0 ] ; then
    Help
    exit
fi

# arguments given
POSITIONAL=()
while [[ $# -gt 0 ]]
do
ARGS="$1"
case $ARGS in
    -h|--help)
      Help
      exit
      ;;
    --outdir)
      RESULTS=$2
      shift 2
      ;;
    --fasta1)
      if [ "$2" ]; then
          FASTA1=$2
          shift 2
      else
          echo -e '\nERROR: "--fasta1" requires an argument\n'
          exit
      fi
      ;;
    --fasta2)
      if [ "$2" ]; then
          FASTA2=$2
          shift 2
      else
          echo -e '\nERROR: "--fasta2" requires an argument\n'
          exit
      fi
      ;;
    --minlen)
      if [ "$2" ]; then
          MINLEN=$2
          shift 2
      else
          echo -e '\nERROR: "--minlen" requires a numeric argument\n'
          exit
      fi
      ;;
    --minid)
      if [ "$2" ]; then
          MINID=$2
          shift 2
      else
          echo -e '\nERROR: "--minid" requires a numeric argument\n'
          exit
      fi
      ;;
    --linklen)
      if [ "$2" ]; then
          MINLINKLEN=$2
          shift 2
      else
          echo -e '\nERROR: "--linklen" requires a numeric argument\n'
          exit
      fi
      ;;
    --gc_window)
      if [ "$2" ]; then
          GCWINDOW=$2
          shift 2
      else
          echo -e '\nERROR: "--gc_window" requires a numeric argument\n'
          exit
      fi
      ;;
    --gc_step)
      if [ "$2" ]; then
          GCSTEP=$2
          shift 2
      else
          echo -e '\nERROR: "--gc_step" requires a numeric argument\n'
          exit
      fi
      ;;
    --fasta1_prefix)
      if [ "$2" ]; then
          FASTA1_PREFIX=$2
          shift 2
      else
          echo -e '\nERROR: "--fasta1_prefix" requires an argument\n'
          exit
      fi
      ;;
    --fasta2_prefix)
      if [ "$2" ]; then
          FASTA2_PREFIX=$2
          shift 2
      else
          echo -e '\nERROR: "--fasta2_prefix" requires an argument\n'
          exit
      fi
      ;;
    --fasta1_color)
      if [ "$2" ]; then
          FASTA1_COLOR=$2
          shift 2
      else
          echo -e '\nERROR: "--fasta1_color" requires an argument\n'
          exit
      fi
      ;;
    --fasta2_color)
      if [ "$2" ]; then
          FASTA2_COLOR=$2
          shift 2
      else
          echo -e '\nERROR: "--fasta2_color" requires an argument\n'
          exit
      fi
      ;;
    *)
      printf "******************************\n"
      printf "Error: Invalid argument $1\n"
      printf "******************************\n"
      exit 1
esac
done

###################
### Exec script ###
###################
# Step 1
echo " # Preparing inputs!"
rm -rf $RESULTS ;
filter          ;

# Step 2
echo " # Writing karyotypes!"
karyotype       ;

# Step 3
echo " # Finding links (all vs all blastn)!"
find_links      ;
parse_links     ;

# Step 4
echo " # Removing duplicate lines in conf files!"
dedup           ;
check_links     ;

# Step 5
echo " # Computing GC Skew!"
gc_skew         ;

# Step 6
echo " # Wrinting circos conf file!"
write_circos > ${RESULTS}/conf/circos.conf ;

# Step 7
echo " # Plotting circos!"
plot_circos     ;

cat << EOF

 # Bye Bye
 Now your plot is complete and must be available at: ${RESULTS}/conf/

 All the required files for a minimal circos plot have been produced and stored at ${RESULTS}/conf/.
 Now you can play with the ${RESULTS}/conf/circos.conf file in order to change the plot as you like.

 Remember to read the manual in order to understand the conf file.

 Have fun!

EOF
