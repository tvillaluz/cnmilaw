#!/bin/sh

# Requires:
#   - curl
# Assumes:
#   - https://www.cnmilaw.org/cmc.php formatting (treeview) is correct order
#   - does not take into account network errors. (manual recovery)
# Goal : 
#   - download https://www.cnmilaw.org/cmc.php as html
#   - extract pdf links from html in assumed order (html order)
#   - create title_x.txt file for each title of law, maintaing order based on treeview

# download file
curl -o data/cmc.php.html https://www.cnmilaw.org/cmc.php

# find links, split by title number, ouputs title_XYZ.txt to data dir
seq 1 10 | xargs -I {} sh -c 'grep -o -E "https.+\/cmc_section\/T{}\/.+\.pdf" data/cmc.php.html > data/T{}.txt'

# download title_x files into pdf/title dir
ls data/T*.txt | cut -d . -f 1  - | xargs -n 1 -I {} sh -c 'cat {}.txt | xargs -n 1 -I {1} curl --create-dirs --output-dir {} -O {1}'
