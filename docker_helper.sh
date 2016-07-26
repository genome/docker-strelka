#!/bin/sh

set -o errexit
set -o nounset

if [ $# -ne 4 ]
then
    echo "Usage: $0 [TUMOR_BAM] [NORMAL_BAM] [REFERENCE] [OUTPUT_DIR]"
    exit 255
fi

TUMOR_BAM=$1
NORMAL_BAM=$2
REFERENCE=$3
OUTPUT_DIR=$4

$STRELKA_INSTALL_DIR/bin/configureStrelkaWorkflow.pl --tumor=$TUMOR_BAM --normal=$NORMAL_BAM --ref=$REFERENCE --output-dir=$OUTPUT_DIR --config=$STRELKA_INSTALL_DIR/etc/strelka_config_bwa_default.ini

cd $OUTPUT_DIR
make -j 4
