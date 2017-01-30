#!/bin/bash

PORT=${1:-8000}
cd parcel-and-csd
echo Parcel repo available at `hostname`:$PORT
python -m SimpleHTTPServer $PORT
