#!/bin/sh

# landing page
# https://www1.nyc.gov/site/nypd/stats/reports-analysis/stopfrisk.page
# https://www1.nyc.gov/assets/nypd/downloads/zip/analysis_and_planning/stop-question-frisk/sqf-2014-csv.zip
# https://www1.nyc.gov/assets/nypd/downloads/zip/analysis_and_planning/stop-question-frisk/sqf-2003-csv.zip

BASE_URL='https://www1.nyc.gov/assets/nypd/downloads'

DEST_DIR=data/stashed
mkdir -p $DEST_DIR

YEARS=$(seq 2003 2018)

for year in $YEARS; do
    if [ "$year" -lt "2015" ]; then
        # https://www1.nyc.gov/assets/nypd/downloads/zip/analysis_and_planning/stop-question-frisk/sqf-2011-csv.zip
        url=${BASE_URL}/zip/analysis_and_planning/stop-question-frisk/sqf-${year}-csv.zip
        destpath=${DEST_DIR}/${year}.zip
    elif [ "$year" -lt "2017" ]; then
        # https://www1.nyc.gov/assets/nypd/downloads/excel/analysis_and_planning/stop-question-frisk/sqf-2016.csv
        url=${BASE_URL}/excel/analysis_and_planning/stop-question-frisk/sqf-${year}.csv
        destpath=${DEST_DIR}/${year}.csv
    else
        # https://www1.nyc.gov/assets/nypd/downloads/excel/analysis_and_planning/stop-question-frisk/sqf-2018.xlsx
        url=${BASE_URL}/excel/analysis_and_planning/stop-question-frisk/sqf-${year}.xlsx
        destpath=${DEST_DIR}/${year}.xlsx
    fi

    echo "Downloading: ${url}"
    curl -Lo ${destpath} ${url}
done
