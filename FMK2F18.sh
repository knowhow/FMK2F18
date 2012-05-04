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
TABLES=`ls *.dbf`
for table in $TABLES ;do
    DBNAME=`echo $table | cut -d. -f1`
/Users/bringout/Developer/harbour_playground/pgsql/dbf2pg -h $1 -y 5432 -d $4 -u $2 -p $3 -e fmk -f $table -t $DBNAME & 
done
exit

