#/bin/bash
# ver 0.2.0
# bjasko@bring.out.ba 
# 27.12.2011


ARGS=5
BADARGS=85

if [ $# -ne "$ARGS" ]
then
   echo "Upotreba: hostname | db username | pwd | db | input folder "
   exit $BADARGS
fi

cd $5
for files in $( ls *.dbf);do
    DBNAME=`echo $files | cut -d. -f1`
dbf2pg -h $1 -y 5432 -d $4 -u $2 -p $3 -e fmk -f $files -t $DBNAME 
done
exit

