.. _manual:

Manual
======

.. code-block:: bash

  # Get help in the command line
  nextflow run fmalmeida/bacannot-compare --help

Input files
-----------

This toolkit takes as input a directory containing the results obtained with the `bacannot pipeline <https://github.com/fmalmeida/bacannot>`_ (generally, the ``--outdir`` parameter).

.. warning::

	**This toolkit requires that at least two genome annotations are available.**

.. tip::

	As described in `the bacannot manual <https://bacannot.readthedocs.io/en/latest/outputs.html>`_, each genome annotation will (or must be) be placed in an individual subdirectory inside the main directory. This subdirectories are generally named with the genome prefixes or the ``--prefix`` parameter.

.. list-table::
   :widths: 20 10 20 30
   :header-rows: 1

   * - Arguments
     - Required
     - Default value
     - Description

   * - ``--dir``
     - Y
     - NA
     - Path to the directory containing the annotation results of the bacannot pipeline.

Output files
------------

.. list-table::
   :widths: 20 10 20 30
   :header-rows: 1

   * - Arguments
     - Required
     - Default value
     - Description

   * - ``--outdir``
     - N
     - By default, they will be placed inside the bacannot main annotation dir.
     - Path to the directory to place the analyses results.

   * - ``--prefix``
     - N
     - BAC-COMPARE-"${DATE}"
     - The name of the output directory. The results dir will be placed inside the ``--outdir``.

   * - ``--force``
     - N
     - False
     - Force the results to be overwritten when resuming an execution (with ``-resume``). Otherwise, whenever available, nextflow will use the existing results.

Workflow options
----------------

.. list-table::
   :widths: 20 10 10 50
   :header-rows: 1

   * - Arguments
     - Required
     - Default value
     - Description

   * - ``--threads``
     - N
     - 2
     - Set the number of threads to be used by the software.

   * - ``--parallel_jobs``
     - N
     - 1
     - Number of jobs to run in parallel. Each job can consume up to N threads (--threads). Default: 1.

   * - ``--all``
     - N
     - False
     - Activates all analyses.

   * - ``--prokka``
     - N
     - False
     - Activates prokka annotation comparison with multiqc.

   * - ``--pangenome``
     - N
     - False
     - Activates the pangenome estimation using roary.

   * - ``--decoder``
     - N
     - False
     - Activates the KEGG KO annotation comparison with keggdecoder.

   * - ``--phylogeny``
     - N
     - False
     - Activates the phylogeny estimation using parsnp.

   * - ``--resistance``
     - N
     - False
     - Activates the AMR annotation comparison.

   * - ``--kleborate``
     - N
     - False
     - Activates Kleborate/Kaptive analysis (*Klebsiella* genomes).

BlastFrost option
-----------------

This optinal process uses a nucleotide fasta file to query the genomes and produce a presence/absence matrix, as well as a Heatmap of the hits.

.. list-table::
   :widths: 20 10 20 30
   :header-rows: 1

   * - Arguments
     - Required
     - Default value
     - Description

   * - ``--blastfrost_query``
     - N
     - NA
     - A nucleotide fasta file containing a list of query genes to be searched in the genomes.
