Help()
{
cat << EOF

Simple script to create a circos plot between two FASTA files.
Copyright, Felipe Almeida <almeidafmarques@outlook.com>, 2021

 Syntax:

  # To draw circos
  plot_circos.sh [-h] [--fofn <file> --outdir <outdir> --minlen <int> --minid <int>
                       --linklen <int> --show_intrachr --gc_window <int> --gc_step <int>
                       --labels <file> --tiles <files> ]

  # To use helpful scripts
  plot_circos [ --gff2labels <PATTERN> <ATTRIBUTE> <COLOR> <GFF> ]
  plot_circos [ --gff2tiles  <PATTERN> <COLOR> <GFF> ]


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
                                     Checkout the "--gff2labels" script (below).

 # Tiles config
 --tiles                             TSV file containing the tile definitions for plotting. The file must contain
                                     3 or 4 columns as shown at http://circos.ca/documentation/tutorials/configuration/data_files.
                                     The first column must be the name (ID) of the contig.
                                     Checkout the "--gff2tiles" script (below).


 # Helpful scripts!
 --gff2labels                        A useful script that allows you to filter a GFF file and create a "circos label file"
                                     with desired inputs. Eg. "plot_circos --gff2labels arcA ID red ecoli_k12.gff". This
                                     command will get each line of the gff that has the "acrA" pattern, and write the
                                     "circos labels file" using the ID attributes column (name as found in the gff) found
                                     in the gff, giving these features a "red" color option.

 --gff2tiles                         A useful script that allows you to filter a GFF file and create a "circos tiles file"
                                     with desired inputs. Eg. "plot_circos --gff2tiles arcA red ecoli_k12.gff". This command
                                     will get each line of the gff that has the "acrA" pattern, and write the "circos tiles file"
                                     giving these features a "red" color option.


EOF
}
