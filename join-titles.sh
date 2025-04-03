#!/bin/sh

# Create BIG PDF from little pdfs
# Requires:
#   - ghostscript installed
# Assumes:
#   - all files are already downloaded and in known dirs
#   - little pdf files are not corrupted
# Goal:
#   - traverse the directories joining the small pdfs into a large pdf based on order in the title (TX.txt) manifests


# GS
gs -q -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=TITLE.pdf -dBATCH


# TESTING
ls data/T*.txt | cut -d . -f 1 - | xargs -n 1 -I {} echo "cat {}.txt | grep -o -E [0-9]+\.pdf | xargs -n 1 -I {1} echo \"{}/{1}\"| xargs gs -q -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE={}/ALL-SECTIONS.pdf -dBATCH"