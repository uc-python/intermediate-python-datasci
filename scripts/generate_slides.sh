#!/bin/bash

set -e
shopt -s extglob

if [ ! -d ".git" ]; then
    echo "Error: no .git directory detected"
    echo "This script should be run from the base of the repo"
    echo 'e.g. `bash scripts/generate_slides.sh`'
    exit 1
fi

# We must be *in* the notebook folder for relative links (to eg images) to work correctly.
cd notebooks
cp -r images ../slides
# Match all notebook files starting with digits and then a dash.
for file in +([0-9])*-*.ipynb; do
    jupyter nbconvert --to slides $file --output-dir=../slides &
done
# Block until all the parallel tasks (from above loop) finish
wait
