#!/bin/bash

KANATA=$(ps -e | awk '{print $4}' | grep kanata)

if [-z "$KANATA" ]; then
	echo ""
else
	echo "\$$"
fi
