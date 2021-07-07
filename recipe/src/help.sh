Help()
{
cat << EOF

Simple script to create a circos plot between two FASTA files.
Copyright, Felipe Almeida <almeidafmarques@outlook.com>, 2021

 Syntax: plot_circos.sh [-h] [--fofn <file> --outdir <outdir> --minlen <int> --minid <int>
                              --linklen <int> --show_intrachr --gc_window <int> --gc_step <int>
                              --labels <file> --tiles <files> ]

 Options:

 # Help
 -h/--help                           Print this help

 # Threads for blastn
 --threads                          Number of threads to use [Default: 1]

 # Output
 --outdir                            Path to output directory [Default: ./results]

 # Input file of file names
 # CSV: fasta path,prefix,color
 --fofn                              File of file names contatining list of fastas to
                                     draw circos plot.

 # Input min. length
 --minlen                            Min size of contigs to consider for plot [Default: 10000]

 # Links (blastn) min. percentage id
 --minid                             Min. percentage id to filter the results of blastn to draw links [Default: 85]
 --linklen                           Min. link (blastn hit) length to display in plot [Default: 5000]
 --show_intrachr                     Tells the program to create a conf file showing intra chr links [Default: false]
                                     Mandatory if using only one FASTA, otherwise, links will not be shown.

 # GC skew config
 --gc_window                         GC skew window size [Default: 5000]
 --gc_step                           GC skew step size [Default: 5000]

 # Labels config
 --labels                            TSV file containing the label definitions for plotting. The file must contain
                                     3 or 4 columns as shown at http://circos.ca/documentation/tutorials/2d_tracks/text_1/lesson,
                                     "DATA FORMAT" section. The first column must be the name (ID) of the contig.

 # Tiles config
 --tiles                             TSV file containing the tile definitions for plotting. The file must contain
                                     3 or 4 columns as shown at http://circos.ca/documentation/tutorials/configuration/data_files.
                                     The first column must be the name (ID) of the contig.


EOF
}
