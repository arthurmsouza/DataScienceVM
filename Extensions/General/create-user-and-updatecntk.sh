#!/bin/bash

# Create N users. If no arg is specified 1 user is created. 
# Script also updates CNTK to RC2 and reinstalls tutorials
# This is for Ubuntu DSVM. Extensions run as root

if [ $# -eq 0 ]; then
        num=1
else
        num=$1
fi

source /anaconda/bin/activate py35
pip install --upgrade --no-deps https://cntk.ai/PythonWheel/GPU/cntk-2.0rc2-cp35-cp35m-linux_x86_64.whl
cd /etc/skel/notebooks
python -m cntk.sample_installer

for i in $(seq 1 $num);  do
  u=`openssl rand -hex 2`;
  p=`openssl rand -hex 3`;
  useradd -m -d /home/user$u -s /bin/bash user$u
  echo user$u:A1imdl$p | chpasswd
  echo user$u, A1imdl$p >> '/tmp/usersinfo.csv';
done