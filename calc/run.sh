#!/bin/bash

name="calc"

lex $name.l
yacc -d $name.y
gcc lex.yy.c y.tab.c -o out
./out
