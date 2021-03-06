#!/bin/bash
# ver 0.1.2
# bjasko@bring.out.ba 
# 29.12.2011
###########################################
FMKDBPATH="$1"
F18DBPATH="$2"
IDFIRMA="$3"
GODINA="$4"
###########################################
ARGS=5
BADARGS=85

# check args

if [ $# -lt  "$ARGS" ];then
     echo ""
     echo ""
     echo "Upotreba: input folder | output folder | firma | godina  | modul1 | modul 2 |  sifrarnik "
     echo "" 
     echo "Npr.  ./FMK2F18_prepare.sh /home/SIGMA /home/f18_fmk 1 2010 fin kalk fakt sif" 
     echo ""
     echo "Za trenutnu godinu korititi RP oznaku"
     echo ""
     echo "Najmanje 1 modul ili sifrarnik"
     exit $BADARGS
fi

# check paths 
if [ -d $F18DBPATH ]; then
     echo "$F18DBPATH je OK, nastavljam ......."
     else
     echo "$F18DBPATH ne postoji kreiram $F18DBPATH"
     mkdir -p $F18DBPATH
fi

if [ -d $FMKDBPATH ]; then
     cd $FMKDBPATH
     else
     echo "$FMKDBPATH ne postoji provjerite podesenja"
     exit
fi

# dali je RP ili Sezona 
if [ "$GODINA" =  "RP" ]
    then
    SEZONATAR=""
    else
    SEZONA="$GODINA" 
fi

# display  info 

bold=`tput bold`
normal=`tput sgr0`
echo ""
echo ""
echo ""
echo ""
echo " source lokacija FMK DB-a je: ${bold} $FMKDBPATH ${normal} "
echo " destinacija za F18 DB je:... ${bold} $F18DBPATH ${normal} "
echo " id Firme je: ............... ${bold} $IDFIRMA ${normal} "
echo " sezona je .................. ${bold} $GODINA ${normal} "
echo ""
echo ""
echo ""
read -p "Ako su gornji parametri ispravni pritisni bilo koju tipku za nastavak ili Ctrl+c  za prekid"
echo ""
echo ""
echo ""

# rename source to UPPERCASE
cd $FMKDBPATH
find . -type d | rename 'y/a-z/A-Z/'  
find . -type f | rename 'y/a-z/A-Z/'


fin () {
# copy FMK DB to F18
echo "kopiram fmk db to f18" 
echo "FIN tabele"
FINTB="SUBAN ANAL SINT NALOG FOND FUNK BUDZET BUIZ PAREK ZAGLI IZVJE KOLIZ KONIZ"
if [ ! -d "$FMKDBPATH/FIN/KUM$IDFIRMA/$SEZONA" ]; then echo "FIN source ne postoji" ; fi
    cd $FMKDBPATH/FIN/KUM$IDFIRMA/$SEZONA
    for table in $FINTB
    do 
    cp $table.DBF $F18DBPATH/fin_$table.dbf 
done
cd $F18DBPATH

for i in $( ls | grep [A-Z] ); do mv -i -f $i `echo $i | tr 'A-Z' 'a-z'`;done
    echo "lista kopiranih fajlova"
    ls $F18DBPATH 
    echo "...OK nastavljam ................."
    sleep 3
}


fakt () {
# copy FMK DB to F18
echo "kopiram fmk db to f18" 
echo "FAKT tabele"
FAKTB="FAKT DOKS DOKS2 GEN_UG GEN_UG_P RUGOV UGOV UPL"
if [ ! -d "$FMKDBPATH/FAKT/KUM$IDFIRMA/$SEZONA" ]; then echo "FAKT source ne postoji" ; fi
    cd $FMKDBPATH/FAKT/KUM$IDFIRMA/$SEZONA
    for table in $FAKTB
    do 
    cp $table.DBF $F18DBPATH/fakt_$table.dbf 
    cp $table.FPT $F18DBPATH/fakt_$table.fpt

done

cd $F18DBPATH
for i in $( ls | grep [A-Z] ); do mv -i -f $i `echo $i | tr 'A-Z' 'a-z'`;done

    echo "lista kopiranih fajlova"
    ls $F18DBPATH 
    echo "...OK nastavljam ................."
    sleep 3
}


kalk () {
# copy FMK DB to F18
echo "kopiram fmk db to f18" 
echo "KALK tabele"
KALKTB="KALK DOKS DOKS2"
if [ ! -d "$FMKDBPATH/KALK/KUM$IDFIRMA/$SEZONA" ]; then echo "KALK source ne postoji" ; fi
cd $FMKDBPATH/KALK/KUM$IDFIRMA/$SEZONA
    for table in $KALKTB
    do
    cp $table.DBF $F18DBPATH/kalk_$table.dbf

done

cd $F18DBPATH

for i in $( ls | grep [A-Z] ); do mv -i -f $i `echo $i | tr 'A-Z' 'a-z'`;done

    echo "lista kopiranih fajlova"
    ls $F18DBPATH
    sleep 3
}


epdv () {
# copy EPDV FMK DB to F18
echo "kopiram fmk db to f18" 
echo "EPDV tabele"
EPTB="KIF KUF PDV SG_KIF SG_KUF"
if [ ! -d "$FMKDBPATH/EPDV/KUM$IDFIRMA/$SEZONA" ]; then echo "EPDV source ne postoji" ; fi
cd $FMKDBPATH/EPDV/KUM$IDFIRMA/$SEZONA
    for table in $EPTB
    do
    cp $table.DBF $F18DBPATH/epdv_$table.dbf

done

cd $F18DBPATH

for i in $( ls | grep [A-Z] ); do mv -i -f $i `echo $i | tr 'A-Z' 'a-z'`;done

    echo "lista kopiranih fajlova"
    ls $F18DBPATH
    sleep 3
}

os () {
# copy OS FMK DB to F18
echo "kopiram fmk db to f18" 
echo "OS tabele"
OSTB="K1 OS PROMJ"
if [ ! -d "$FMKDBPATH/OS/KUM$IDFIRMA/$SEZONA" ]; then echo "OS source ne postoji" ; fi
    cd $FMKDBPATH/OS/KUM$IDFIRMA/$SEZONA
    for table in $OSTB
    do
    cp $table.DBF $F18DBPATH/os_$table.dbf

done

cd $F18DBPATH

for i in $( ls | grep [A-Z] ); do mv -i -f $i `echo $i | tr 'A-Z' 'a-z'`;done
    echo "lista kopiranih fajlova"
    ls $F18DBPATH
    sleep 3
} 


sii () {
# copy SII FMK DB to F18
echo "kopiram fmk db to f18" 
echo "SII tabele"
OSTB="K1 OS PROMJ"
if [ ! -d "$FMKDBPATH/SII/KUM$IDFIRMA/$SEZONA" ]; then echo "SII source ne postoji" ;  fi
    cd $FMKDBPATH/SII/KUM$IDFIRMA/$SEZONA
    for table in $OSTB
    do
    cp $table.DBF $F18DBPATH/sii_$table.dbf
done

cd $F18DBPATH

for i in $( ls | grep [A-Z] ); do mv -i -f $i `echo $i | tr 'A-Z' 'a-z'`;done
    echo "lista kopiranih fajlova"
    ls $F18DBPATH
    sleep 3
} 



ld () {
# copy FMK LD DB to F18
echo "kopiram fmk db to f18" 
echo "LD tabele"
LDTB="LD NORSIHT OBRACUNI PK_DATA PK_RADN RADKR RADN RADSAT RJ TPRSIHT"
if [ ! -d "$FMKDBPATH/LD/KUM$IDFIRMA/$SEZONA" ]; then echo "LD source ne postoji" ; fi
    cd $FMKDBPATH/LD/KUM$IDFIRMA/$SEZONA
    for table in $LDTB
    do
    cp $table.DBF $F18DBPATH/ld_$table.dbf

done

cd $F18DBPATH

for i in $( ls | grep [A-Z] ); do mv -i -f $i `echo $i | tr 'A-Z' 'a-z'`;done

    echo "lista kopiranih fajlova"
    ls $F18DBPATH
    sleep 3
}


virm () {
# copy FMK VIRM DB to F18
echo "kopiram fmk db to f18" 
echo "VIRM tabele"
VIRMTB="LDVIRM VRPRIM"
if [ ! -d "$FMKDBPATH/VIRM/KUM$IDFIRMA/$SEZONA" ]; then echo "VIRM source ne postoji" ; fi
    cd $FMKDBPATH/VIRM/KUM$IDFIRMA/$SEZONA
    for table in $VIRMTB
    do
    cp $table.DBF $F18DBPATH/$table.dbf

done

cd $F18DBPATH

for i in $( ls | grep [A-Z] ); do mv -i -f $i `echo $i | tr 'A-Z' 'a-z'`;done

    echo "lista kopiranih fajlova"
    ls $F18DBPATH
    sleep 3
}


mat () {
# copy FMK DB to F18
echo "kopiram fmk db to f18" 
echo "MAT tabele"
MATTB="SUBAN ANAL SINT NALOG"
if [ ! -d "$FMKDBPATH/MAT/KUM$IDFIRMA/$SEZONA" ]; then echo "MAT source ne postoji" ; fi
    cd $FMKDBPATH/MAT/KUM$IDFIRMA/$SEZONA
    for table in $MATTB
    do
    cp  $table.DBF $F18DBPATH/mat_$table.dbf

done

cd $F18DBPATH
for i in $( ls | grep [A-Z] ); do mv -i -f $i `echo $i | tr 'A-Z' 'a-z'`;done
    echo "lista kopiranih fajlova"
    ls $F18DBPATH
    sleep 3
cd .. 
echo "...OK nastavljam ................."

}



rnal () {
# copy FMK DB to F18
echo "kopiram fmk db to f18" 
echo "RNAL tabele"
RNALTB="DOCS DOC_IT DOC_IT2 DOC_OPS DOC_LOG DOC_LIT"
if [ ! -d "$FMKDBPATH/RNAL/KUM$IDFIRMA/$SEZONA" ]; then echo "RNAL source ne postoji" ; fi
     cd $FMKDBPATH/RNAL/KUM$IDFIRMA/$SEZONA
     for table in $RNALTB
     do
     cp  $table.DBF $F18DBPATH/rnal_$table.dbf
 
done
 
cd $F18DBPATH
for i in $( ls | grep [A-Z] ); do mv -i -f $i `echo $i | tr 'A-Z' 'a-z'`;done
echo "lista kopiranih fajlova"
ls $F18DBPATH
sleep 3
cd ..
echo "...OK nastavljam ................."
 
}







sif  () {
# copy FMK DB to F18
echo "kopiram fmk db to f18" 
echo "SIF tabele"
SIFTB="ADRES ROBA SIFK SIFV PARTN BANKE KONTO POR RJ SAST TARIFA TDOK TIPPR TIPPR2 TNAL TRFP TRFP2 TRFP3 VALUTE VPOSLA VPRIH OPS KBENEF KONCIJ PKONTO REFER KRED DOPR LOKAL AMORT REVAL FMKRULES DEST FTXT PAROBR STRSPR JPRIH KALVIR VRSTEP RAL ARTICLES ELEMENTS AOPS AOPS_ATT CONTACTS CUSTOMS E_AOPS E_ATT E_GR_ATT E_GR_VAL E_GROUPS OBJECTS RELATION KS"
if [ ! -d "$FMKDBPATH/SIF$IDFIRMA/$SEZONA" ]; then echo "SIF source ne postoji" ; fi
    cd $FMKDBPATH/SIF$IDFIRMA/$SEZONA
    for table in $SIFTB
    do
    cp $table.DBF $F18DBPATH/$table.dbf
done

    for files in $( ls *.FPT )
    do     
    cp $files $F18DBPATH
done

cd $F18DBPATH

for i in $( ls | grep [A-Z] ); do mv -i -f $i `echo $i | tr 'A-Z' 'a-z'`;done
    mv amort.dbf os_amort.dbf
    mv reval.dbf os_reval.dbf
    mv ftxt.dbf  fakt_ftxt.dbf
    mv fmkrules.dbf f18_rules.dbf
    mv parobr.dbf ld_parobr.dbf
    mv articles.dbf rnal_articles.dbf
    mv ral.dbf rnal_ral.dbf
    mv elements.dbf rnal_elements.dbf
    mv aops.dbf rnal_aops.dbf
    mv aops_att.dbf rnal_aops_att.dbf
    mv contacts.dbf rnal_contacts.dbf
    mv customs.dbf rnal_customs.dbf
    mv e_aops.dbf rnal_e_aops.dbf
    mv e_att.dbf rnal_e_att.dbf
    mv e_gr_att.dbf rnal_e_gr_att.dbf
    mv e_gr_val.dbf rnal_e_gr_val.dbf
    mv e_groups.dbf rnal_e_groups.dbf
    mv objects.dbf rnal_objects.dbf

echo ""    
echo ""
echo "lista kopiranih fajlova"
echo ""
echo ""
ls $F18DBPATH
sleep 3

}

$5
$6
$7
$8
$9
${10}
${11}
${12}
${13}
${14}


echo "gotovo................."
exit 0
