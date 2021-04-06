#!/bin/bash
catmandu convert MARC --type ALEPHSEQ to CSV --collect_fields '1' --sep_char ';' --fix dsv01-bibdia-aleph-konkordanz.fix < a150.konkordanz > dsv01-bibdia-aleph-konkordanz.csv
exit 0
