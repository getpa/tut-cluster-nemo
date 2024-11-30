shopt -s expand_aliases

NEMO_PATH=$CONDA_PREFIX/lib/python3.10/site-packages/nemo
KENLM_MAX_ORDER=12 # n-gramの解析をする最大の次数

if [ -d "$NEMO_PATH" ]; then
  echo "The folder '$NEMO_PATH' exists."
else
  echo "Error: The folder '$NEMO_PATH' does not exist. Specify it as a first command line positional argument!"
  exit 1
fi
cd $NEMO_PATH

git clone https://github.com/NVIDIA/OpenSeq2Seq
cd OpenSeq2Seq
git checkout ctc-decoders
cd ..
mv OpenSeq2Seq/decoders $NEMO_PATH/
rm -rf OpenSeq2Seq
cd $NEMO_PATH/decoders
# cp $NEMO_PATH/scripts/installers/setup_os2s_decoders.py ./setup.py
wget -O setup.py https://github.com/NVIDIA/NeMo/raw/refs/heads/main/scripts/installers/setup_os2s_decoders.py
./setup.sh

# install KenLM
cd $NEMO_PATH/decoders/kenlm/build && cmake -DKENLM_MAX_ORDER=$KENLM_MAX_ORDER .. && make -j2
cd $NEMO_PATH/decoders/kenlm
python setup.py install --max_order=$KENLM_MAX_ORDER
# export KENLM_LIB=$NEMO_PATH/decoders/kenlm/build/bin
# export KENLM_ROOT=$NEMO_PATH/decoders/kenlm
conda env config vars set \
  KENLM_LIB=$NEMO_PATH/decoders/kenlm/build/bin \
  KENLM_ROOT=$NEMO_PATH/decoders/kenlm

pip install flashlight-text