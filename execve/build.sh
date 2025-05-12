#!/bin/bash

aarch64-linux-gnu-as -o execve.o execve.S
aarch64-linux-gnu-gcc -nostdlib -static -Ttext=0x400000 main.c execve.o -o execve_sh
