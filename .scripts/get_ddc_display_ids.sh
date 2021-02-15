#!/bin/bash

ddcutil -t detect | grep Display | sed 's/.*Display //'
