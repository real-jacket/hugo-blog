#!/bin/bash

export TZ='Asia/Shanghai'
git config --global core.quotePath false
git config --global core.autocrlf false
git config --global core.safecrlf true
git config --global core.ignorecase false
git ls-files -z | while read -d '' path; do
    touch -d "$(git log -1 --format="@%ct" "$path")" "$path";
done
hugo -v --minify --gc
