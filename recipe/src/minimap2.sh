minimap_links()
{
    # create dir
    mkdir -p ${RESULTS}/all_vs_all_links ${RESULTS}/conf

    # concatenate genomes
    cat ${RESULTS}/filtered/* >> ${RESULTS}/concatenated_genomes.fasta ;
    export CONCAT_FASTA=${RESULTS}/concatenated_genomes.fasta

    # run minimap2
    minimap2 \
        -c --cs -t $THREADS \
        -x asm20 -o ${RESULTS}/all_vs_all_links/all_vs_all.aln.txt \
        $CONCAT_FASTA $CONCAT_FASTA 2> /dev/null

    # parse paf
    cut -f 1,3,4,6,8,9 ${RESULTS}/all_vs_all_links/all_vs_all.aln.txt >> ${RESULTS}/conf/links_concatenated.txt

    # get links comming from contigs and give it colors
    IFS=','
    while read -r FASTA FASTA_PREFIX FASTA_COLOR ; do
    bioawk -c fastx '{ printf $name"\n" }' $FASTA > tmp_names.fasta ;
    awk -v color1=$FASTA_COLOR -F'\t' 'NR==FNR{c[$1]++;next};c[$1] > 0 {print $0 "\t" "color="color1}' \
        tmp_names.fasta ${RESULTS}/conf/links_concatenated.txt >> ${RESULTS}/conf/links_concatenated_colored.txt
    rm tmp_names.fasta ;
    done<"$FOFN"

    # create additional file whithout intrachr links
    awk \
        -F'\t' \
        '{ if ($1 != $4) { print } }' \
        ${RESULTS}/conf/links_concatenated_colored.txt > ${RESULTS}/conf/links_concatenated_colored_no_intrachr.txt ;
}