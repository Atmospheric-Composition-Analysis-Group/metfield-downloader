#!/bin/bash
YEAR=${YEAR:=$(date --date='-1 month' +%Y)}
MONTH=${MONTH:=$(date --date='-1 month' +%m)}

BASE_URL=https://portal.nccs.nasa.gov/datashare/gmao/geos-fp/das

function print_collection() {
   COLLECTION=$1
   YEAR=$2
   MONTH=$3
   DAY=$4
   HOUR_OFFSET=$5
   START=$6
   STOP=$7
   STEP=$8
   for HOUR in $(seq -w $START $STEP $STOP) ; do
      echo $BASE_URL/Y${YEAR}/M${MONTH}/D${DAY}/GEOS.fp.asm.${COLLECTION}.${YEAR}${MONTH}${DAY}_${HOUR}${HOUR_OFFSET}.V01.nc4
   done
}

DAYS=$(cal $MONTH $YEAR | awk 'NF {DAYS = $NF}; END {print DAYS}')
for DAY in $(seq -w '01' $DAYS) ; do
   print_collection tavg1_2d_rad_Nx "$YEAR" "$MONTH" "$DAY" 30 0 23
   print_collection tavg1_2d_lnd_Nx "$YEAR" "$MONTH" "$DAY" 30 0 23
   print_collection tavg1_2d_flx_Nx "$YEAR" "$MONTH" "$DAY" 30 0 23
   print_collection tavg1_2d_slv_Nx "$YEAR" "$MONTH" "$DAY" 30 0 23
   print_collection inst3_3d_asm_Nv "$YEAR" "$MONTH" "$DAY" 00 0 23 3
   print_collection tavg3_3d_asm_Nv "$YEAR" "$MONTH" "$DAY" 30 1 23 3
   print_collection tavg3_3d_cld_Nv "$YEAR" "$MONTH" "$DAY" 30 1 23 3
   print_collection tavg3_3d_mst_Ne "$YEAR" "$MONTH" "$DAY" 30 1 23 3
   print_collection tavg3_3d_rad_Nv "$YEAR" "$MONTH" "$DAY" 30 1 23 3
   print_collection tavg3_3d_mst_Nv "$YEAR" "$MONTH" "$DAY" 30 1 23 3
done