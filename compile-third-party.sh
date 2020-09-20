#!/bin/bash

#Reference for installing Moses -> https://www.youtube.com/watch?v=aaalgJoRy54

MONOSESFLDR="$PWD"

CURRENT="$PWD"/third-party

#Install required pacakages
sudo apt-get install g++ git automake libtool zlib1g-dev libboost-all-dev libbz2-dev liblzma-dev libgoogle-perftools-dev

#Download & Install GIZA++

cd $CURRENT
git clone https://github.com/moses-smt/giza-pp.git
cd $CURRENT/giza-pp
make

# Back to `third-party`
# Copying GIZA++ Binaries to MosesDecoder:

cd $CURRENT/moses
mkdir -p $CURRENT/moses/tools
cd $CURRENT
cp giza-pp/GIZA++-v2/GIZA++ giza-pp/GIZA++-v2/snt2cooc.out giza-pp/mkcls-v2/mkcls moses/tools

# Install Moses
# cd `third-party/moses`
cd $CURRENT/moses
./bjam
# NOTE : This may take a lot of time!


# Compile Z-MERT
cd $MONOSESFLDR/training/tuning/zmert
make

# Compile fast-align
sudo apt-get install libgoogle-perftools-dev libsparsehash-dev
cd $CURRENT/fast_align/
mkdir build
cd build
cmake ..
make

# Compile Phrase2Vec
cd $CURRENT/phrase2vec
make