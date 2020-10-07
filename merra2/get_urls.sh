#!/bin/bash
YEAR=${YEAR:=$(date --date='-2 month' +%Y)}
MONTH=${MONTH:=$(date --date='-2 month' +%m)}

function print_collection() {
   BASE_URL=$1
   COLLECTION_DIR=$2
   COLLECTION=$3
   YEAR=$4
   MONTH=$5
   DAY=$6
   
   if [ $YEAR -lt 1992 ]; then
      fileprefix=MERRA2_100
   elif [ $YEAR -ge 1992 ] && [ $YEAR -lt 2001 ]; then
      fileprefix=MERRA2_200
   elif [ $YEAR -ge 2001 ] && [ $YEAR -lt 2011 ]; then
      fileprefix=MERRA2_300
   elif [ $YEAR -ge 2011 ]; then
      fileprefix=MERRA2_400
   fi

   echo $BASE_URL/$COLLECTION_DIR/$YEAR/$MONTH/$fileprefix.$COLLECTION.$YEAR$MONTH$DAY.nc4
}

BASE_URL=https://goldsmr4.gesdisc.eosdis.nasa.gov/data/MERRA2/
DAYS=$(cal $MONTH $YEAR | awk 'NF {DAYS = $NF}; END {print DAYS}')
for DAY in $(seq -w '01' $DAYS) ; do
   print_collection $BASE_URL M2T1NXFLX.5.12.4 tavg1_2d_flx_Nx "$YEAR" "$MONTH" "$DAY"
   print_collection $BASE_URL M2T1NXLND.5.12.4 tavg1_2d_lnd_Nx "$YEAR" "$MONTH" "$DAY"
   print_collection $BASE_URL M2T1NXRAD.5.12.4 tavg1_2d_rad_Nx "$YEAR" "$MONTH" "$DAY"
   print_collection $BASE_URL M2T1NXSLV.5.12.4 tavg1_2d_slv_Nx "$YEAR" "$MONTH" "$DAY"
done

BASE_URL=https://goldsmr5.gesdisc.eosdis.nasa.gov/data/MERRA2/
DAYS=$(cal $MONTH $YEAR | awk 'NF {DAYS = $NF}; END {print DAYS}')
for DAY in $(seq -w '01' $DAYS) ; do
   print_collection $BASE_URL M2T3NVASM.5.12.4 tavg3_3d_asm_Nv "$YEAR" "$MONTH" "$DAY"
   print_collection $BASE_URL M2T3NVCLD.5.12.4 tavg3_3d_cld_Nv "$YEAR" "$MONTH" "$DAY"
   print_collection $BASE_URL M2T3NEMST.5.12.4 tavg3_3d_mst_Ne "$YEAR" "$MONTH" "$DAY"
   print_collection $BASE_URL M2T3NVMST.5.12.4 tavg3_3d_mst_Nv "$YEAR" "$MONTH" "$DAY"
   print_collection $BASE_URL M2T3NVRAD.5.12.4 tavg3_3d_rad_Nv "$YEAR" "$MONTH" "$DAY"
   print_collection $BASE_URL M2I3NVASM.5.12.4 inst3_3d_asm_Nv "$YEAR" "$MONTH" "$DAY"
done
