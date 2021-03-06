#!/bin/bash

echo 'Building documentation... use "no-ex" argument to disable experiments'

if [ $# -gt 0 ]; then
if [ $1 == 'no-ex' ]; then echo 'disabled experiments...'; export ignore='ex'; fi
if [ $# -gt 1 ]; then
if [ $2 == 'no-api' ]; then echo 'disabled API...'; export ignore_api='true'; fi
fi
fi
rm api/generated/*
rm savefig/*
make clean
make html
grep -r -l 'CASUSERHDFS' _build/html | xargs -r -d'\n' sed -i 's/CASUSERHDFS\(([A-Za-z0-9]*)\)/CASUSERHDFS(casuser)/g'
make latex
sed -i -- 's/CASUSERHDFS([A-Za-z0-9]*)/CASUSERHDFS(casuser)/g' _build/latex/sasoptpy.tex 
cd _build/latex
make
cp sasoptpy.pdf ../html
if [ $# -gt 0 ]; then
if [ $1 == 'no-ex' ]; then unset ignore; fi
fi
