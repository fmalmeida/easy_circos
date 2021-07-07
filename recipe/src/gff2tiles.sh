gff2tiles()
{
  # use awk to parse gff and create labels based on user desire
  echo -e "#chr\tstart\tend\toptions\tcomment"
  awk \
    -v pattern="$PATTERN" \
    -v color_val="$COLOR" \
    '
    BEGIN{OFS="\t";}
    {
      {
        if($0 ~ pattern){
          print $1,$4,$5,"color="color_val,"# attributes: "$9
        } ;
      }
    }' $GFF
}
