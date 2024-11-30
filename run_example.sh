#!/bin/bash
source ~/.bash_profile
source .env

mamba activate nemo

c=`cat <<EOF
import torch
import sys

print(f"python version={sys.version}")
print(f"is cuda available={torch.cuda.is_available()}")
if torch.cuda.is_available():
    for i in range(torch.cuda.device_count()):
        print(f"cuda:{i} {torch.cuda.get_device_name(i)} capability:{torch.cuda.get_device_capability(i)}")
EOF`

qcmd "$CONDA_PREFIX/bin/python -c '$c'"