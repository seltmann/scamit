#/bin/bash

( cd ../scamit-toolbox; find . -type f -print | sed 's/^\.\///' | sort > '../scamit-toolbox/Toolbox File Listing.txt' )
