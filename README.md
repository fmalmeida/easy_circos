![](https://anaconda.org/falmeida/easy_circos_plot/badges/version.svg) ![](https://anaconda.org/falmeida/easy_circos_plot/badges/latest_release_date.svg) ![](https://anaconda.org/falmeida/easy_circos_plot/badges/platforms.svg) ![](https://anaconda.org/falmeida/easy_circos_plot/badges/installer/conda.svg)

# Easy (minimal) circos plot

easy_circos_plot is a simple conda package that aims on rapidly and easily creating minimal circos configuration and plots between two fasta files.

## Table of contents

* [Requirements](https://github.com/fmalmeida/easy_circos_plot#requirements)
* [Installation](https://github.com/fmalmeida/easy_circos_plot#installation)
* [Documentation](https://github.com/fmalmeida/easy_circos_plot#documentation)
* [How can you colaborate?](https://github.com/fmalmeida/easy_circos_plot#collaborating)
* [Citation](https://github.com/fmalmeida/easy_circos_plot#citation)

## Installation

Installation is provided via conda.

> Users are advised to create separate conda environments

```bash
# Get the conda package
conda create -n easy_circos -c conda-forge -c defaults -c bioconda -c falmeida -c anaconda easy_circos
```

## Documentation

```bash
# activate env
conda activate easy_circos

# see help
plot_circos.sh --help

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
plot_circos --fasta1 ecoli_sakai.fna --fasta2 ecoli_k12.fna
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
