FROM fmalmeida/mamba
SHELL ["/bin/bash", "-c"]
MAINTAINER Felipe Marques de Almeida <felipemarques89@gmail.com>

# install program
# Get the conda package
RUN mamba install -y -n easy_circos -c conda-forge -c bioconda -c falmeida easy_circos

ENTRYPOINT ["plot_circos"]

