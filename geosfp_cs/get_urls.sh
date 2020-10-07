#!/bin/bash
set -e
set -u
: "$YEAR" "$MONTH"

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
   print_collection tavg_3hr_ctm_c0720_v72 "$YEAR" "$MONTH" "$DAY" 30 1 23 3
done