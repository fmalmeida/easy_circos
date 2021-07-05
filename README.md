![GitHub release (latest by date)](https://img.shields.io/github/v/release/fmalmeida/easy_circos?style=flat-square) ![](https://anaconda.org/falmeida/easy_circos/badges/version.svg) ![](https://anaconda.org/falmeida/easy_circos/badges/latest_release_date.svg) ![](https://anaconda.org/falmeida/easy_circos/badges/platforms.svg) ![](https://anaconda.org/falmeida/easy_circos/badges/installer/conda.svg)

# Easy (minimal) circos plot

easy_circos is a simple conda package that aims on rapidly and easily creating minimal circos configurations templates based on input data so that users can further customize and plot by their own desires.

## Table of contents

* [Features](https://github.com/fmalmeida/easy_circos#features)
* [Installation](https://github.com/fmalmeida/easy_circos#installation)
* [Documentation](https://github.com/fmalmeida/easy_circos#documentation)
* [Quickstart](https://github.com/fmalmeida/easy_circos#quickstart)
* [How can you colaborate?](https://github.com/fmalmeida/easy_circos#collaborating)
* [Citation](https://github.com/fmalmeida/easy_circos#citation)

## Features

For now, it only has the ability to produce a circos plot showing the GC skew and the links between one or more fasta files, however, some other implementations are already in mind:

* Add the possibility for plotting custom 2D tracks (if following a defined format)
* Add the possibility to add texts to show where specific features are located
* Make the inclusion of some types of data optional, so we can add it or not
* ...

> If you have another idea of implementation flag an issue discussing it (See: [How can you colaborate?](https://github.com/fmalmeida/easy_circos#collaborating))

## Installation

Installation is provided via conda.

> Users are advised to create separate conda environments

```bash
# Get the conda package
conda create -n easy_circos -c conda-forge -c defaults -c bioconda -c falmeida -c anaconda easy_circos
```

:fire: Users can use [mamba](https://github.com/mamba-org/mamba) for faster conda installation

## Documentation

```bash
# activate env
conda activate easy_circos

# see help
plot_circos --help

[...]
Simple script to create a circos plot between two FASTA files.
Copyright, Felipe Almeida <almeidafmarques@outlook.com>, 2021

 Syntax: plot_circos.sh [-h] [--fofn <fasta> --outdir <outdir> --minlen <int> --minid <int>
                              --linklen <int> --show_intrachr --gc_window <int> --gc_step <int>]

 Options:

 # Help
 -h/--help                           Print this help

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
```

## Quickstart

```bash
# activate env
conda activate easy_circos

# quickstart (with test data)
## download ecoli genome 1
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/008/865/GCF_000008865.2_ASM886v2/GCF_000008865.2_ASM886v2_genomic.fna.gz \
  -O ecoli_sakai.fna.gz && \
  gzip -d ecoli_sakai.fna.gz

## download ecoli genome 2
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz \
  -O ecoli_k12.fna.gz && \
  gzip -d ecoli_k12.fna.gz

## run circos plot
echo "ecoli_k12.fna,K12,purple" > input.fofn
echo "ecoli_sakai.fna,SAKAI,lorange" >> input.fofn
plot_circos --fofn input.fofn
```

## Collaborating

This is meant to be a collaborative project, which means it is meant to adapt to the community needs. Thus, we encourage users to use it and to collaborate with ideas for different implementations, new commands, additions, etc.

If you have an analysis that you constantly do when working with GFFs and would like to see it implemented in a command-like package to make your life easy, or whenever you feel something can be improved, don't hesitate and **collaborate**.

You can collaborate by:

* flagging an **enhancement issue** discussing your idea in the homepage of the project
* you can fork the repo, create and start the implementation of your own script/command in the project and then submit a **pull request**
    * I'll then check the request, make sure it is in the same format and standards of the already implemented commands and **confirm** the inclusion.
    * Of course, you will be recognized as the developer/creator of that specific implementation.

Checkout more at about forking and contributing to repos at:

* [Chase's tutorial](https://gist.github.com/Chaser324/ce0505fbed06b947d962)
* [github's advises on how to collaborate to projects](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests)

## Citation

To cite this pipeline users can use the github url. Users are encouraged to cite the python packages used in this pipeline whenever their outputs are valuable.
