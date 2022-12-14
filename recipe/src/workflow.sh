workflow()
{
  ## remove existing results
  rm -rf $RESULTS ;

  # Step 1
  echo " # Preparing inputs!"
  filter          ;

  # Step 2
  echo " # Writing karyotypes!"
  karyotype       ;

  # Step 3
  if [ "$SKIP_LINKS" = "no" ]
  then
  echo " # Finding links (all vs all blastn)!"
  find_links      ;
  parse_links     ;
  else
  echo " # Skipping links (all vs all blastn)!"
  empty_links     ;
  fi

  # Step 4
  echo " # Removing duplicate lines in conf files!"
  dedup           ;
  if [ "$SKIP_LINKS" = "no" ]
  then
  check_links     ;
  export DEFAULT_LINE="chromosomes_display_default = no"
  else
  export DEFAULT_LINE="chromosomes_display_default = yes"
  export CUSTOM_CHR_LINE=""
  fi

  # Step 5
  echo " # Computing GC Skew!"
  gc_skew         ;

  # Step 6
  # Check for labels
  if [ -z "$LABELS" ]
  then
    echo "" > /dev/null ;
  else
    echo " # Parsing labels!" ;
    labels                    ;
  fi

  # Step 7
  # Check for tiles
  if [ -z "$TILES" ]
  then
    echo "" > /dev/null ;
  else
    echo " # Parsing tiles!" ;
    tiles                    ;
  fi

  # Step 6
  echo " # Wrinting circos conf file!"
  if [ "$BACANNOT" == "no" ]
  then
  write_circos          > ${RESULTS}/conf/circos.conf ;
  else
  write_circos_bacannot > ${RESULTS}/conf/circos.conf ;
  fi

  # Step 7
  if [ "$BACANNOT" == "no" ]
  then
  echo " # Plotting circos!"
  plot_circos     ;
  fi

  # Bye
  echo ${BYE}
}
