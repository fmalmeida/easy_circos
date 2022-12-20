Help()
{
cat << EOF

Simple script to create a circos plot between FASTA files.
Copyright, Felipe Almeida <almeidafmarques@outlook.com>, 2021

    Syntax:

    # To draw circos
    plot_circos.sh [-h] [ options ]

    # To use helpful scripts
    plot_circos [ --gff2labels <FEATURES> <PATTERN> <ATTRIBUTE> <COLOR> <GFF> ]
    plot_circos [ --gff2tiles  <FEATURES> <PATTERN> <COLOR> <GFF> ]


    Options:

    # Help
    -h/--help                           Print this help

    # Threads for blastn
    --threads                           Number of threads to use [Default: 1]

    # Output
    --outdir                            Path to output directory [Default: ./results]

    # Input file of file names
    # CSV: fasta path,prefix,color
    --fofn                              File of file names containing list of fastas to draw circos plot.

    # Input min. length
    --minlen                            Min size of contigs to consider for plot [Default: 10000]

    # Links configurations
    --skip_links                        Do not compute blast and do not draw links.
                                        Useful for when only desiring the configs. [Default: false]
    
    --use_minimap2                      Compute links with minimap2. This is only useful for big genomes.
                                        With small genomes probably no align block will be detected.
                                        For minimap2, --minid and --linklen have no effect. By default uses blastn.
    
    --minimap2_method                   Select alignment "method" / "algorithm" for minimap2.
                                        Options: asm5 | asm10 | asm20. [Default: asm20]

    --minid                             Min. percentage id to filter the results of blastn (only for blastn) to draw links [Default: 85]

    --linklen                           Min. length of blastn hits (only for blastn) length to display in plot [Default: 5000]
    
    --show_intrachr                     Tells the program to create a conf file showing intra chr links [Default: false]
                                        Mandatory if using only one FASTA, otherwise, links will not be shown.

    # GC skew config
    --gc_window                         GC skew window size [Default: 5000]
    
    --gc_step                           GC skew step size [Default: 5000]

    # Labels config
    --labels                            TSV file containing the label definitions for plotting. The file must contain
                                        4 or 5 columns as shown at http://circos.ca/documentation/tutorials/2d_tracks/text_1/lesson,
                                        "DATA FORMAT" section. The first column must be the name (ID) of the contig.
                                        Checkout the "--gff2labels" script (below).

    # Tiles config
    --tiles                             TSV file containing the tile definitions for plotting. The file must contain
                                        3 or 4 columns as shown at http://circos.ca/documentation/tutorials/configuration/data_files.
                                        The first column must be the name (ID) of the contig.
                                        Checkout the "--gff2tiles" script (below).
    
    # Housekeeping conf

    --max_ticks                         Max number of ticks allowed to plot. [Default: 5000]
    --max_ideograms                     Max number of ideograms allowed to plot. [Default: 200]
    --max_links                         Max number of links allowed to plot. [Default: 50000]
    --max_points_per_track              Max number of points per track (e.g. histogram) allowed to plot. [Default: 50000]


    # Helpful scripts!
    # See the examples in our quickstart: https://easy-circos.readthedocs.io/en/latest/quickstart.html
    --gff2labels                        A useful script that allows you to filter a GFF file and create a "circos label file"
                                        with desired inputs. Eg. "plot_circos --gff2labels CDS arcA ID red ecoli_k12.gff". This
                                        command will get each line where the feature (3rd column) is a CDS and that has the
                                        "acrA" (in the complete line) pattern to write the "circos labels file" using the ID
                                        attributes column as label (string as found in the gff), giving these features
                                        a "red" color option.

                                        For <FEATURES> and <PATTERN> users can use "" to match anything, and "|" to match
                                        more than one string. E.g. plot_circos --gff2labels "" "acrA|mdt" ID red ecoli_k12.gff

    --gff2tiles                         A useful script that allows you to filter a GFF file and create a "circos tiles file"
                                        with desired inputs. Eg. "plot_circos --gff2tiles CDS arcA red ecoli_k12.gff". This
                                        command will get each line where the feature (3rd column) is a CDS and that has the
                                        "acrA" (in the complete line) pattern to write the "circos tiles file" giving these
                                        features a "red" color option.

                                        For <FEATURES> and <PATTERN> users can use "" to match anything, and "|" to match
                                        more than one string. E.g. plot_circos --gff2tiles "" "acrA|mdt" red ecoli_k12.gff.
    
    --bacannot                          It also writes the customized configs for bacannot annotations.
                                        Only useful inside bacannot pipelines.


EOF
}
