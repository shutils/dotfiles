#!/bin/sh

exec vim -c 'set signcolumn=no nonumber norelativenumber' "$@"
