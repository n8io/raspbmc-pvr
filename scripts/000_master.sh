#!/bin/bash
sudo wget "https://raw2.github.com/n8io/raspbmc-pvr/master/scripts/001_update_pi.sh" -v -O "./scripts/001_update_pi.sh" --no-check-certificate
chmod a+x ./scripts/*
sudo ./scripts/001_update_pi.sh