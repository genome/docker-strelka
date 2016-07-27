#!/bin/sh

set -o errexit
set -o nounset

if [ $# -ne 6 ]
then
    echo "Usage: $0 [TUMOR_BAM] [NORMAL_BAM] [REFERENCE] [OUTPUT_DIR] [CONFIG] [NUM_CPUS]"
    exit 255
fi

TUMOR_BAM="$1"
NORMAL_BAM="$2"
REFERENCE="$3"
OUTPUT_DIR="$4"
CONFIG="$5"
NUM_CPUS=${6:-"8"}

#CONFIG can name of one of the default configuration files
#Otherwise it must be the full path to an alternative configuration
DEFAULT_CONFIG="$STRELKA_INSTALL_DIR/etc/$CONFIG"
if [ -e "$DEFAULT_CONFIG" ]
then
    CONFIG="$DEFAULT_CONFIG"
fi

$STRELKA_INSTALL_DIR/bin/configureStrelkaWorkflow.pl \
    --tumor="$TUMOR_BAM" \
    --normal="$NORMAL_BAM" \
    --ref="$REFERENCE" \
    --output-dir="$OUTPUT_DIR" \
    --config="$CONFIG"

cd "$OUTPUT_DIR"
make -j "$NUM_CPUS"
