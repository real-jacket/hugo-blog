#!/bin/bash

export TZ='Asia/Shanghai'
git config --global core.quotePath false
git config --global core.autocrlf false
git config --global core.safecrlf true
git config --global core.ignorecase false
hugo -v --minify --gc
