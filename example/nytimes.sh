#!/bin/bash
set -x
root=`pwd`
echo $root
bin=$root/bin
dir=$root/data/nytimes

# mkdir -p $dir
cd $dir

# 1. Download the data
#wget https://archive.ics.uci.edu/ml/machine-learning-databases/bag-of-words/docword.nytimes.txt.gz
#gunzip $dir/docword.nytimes.txt.gz
#wget https://archive.ics.uci.edu/ml/machine-learning-databases/bag-of-words/vocab.nytimes.txt
#
## 2. UCI format to libsvm format
#python $root/example/text2libsvm.py $dir/docword.nytimes.txt $dir/vocab.nytimes.txt $dir/nytimes.libsvm $dir/nytimes.word_id.dict

# 3. libsvm format to binary format
$bin/dump_binary.exe "$dir/nytimes.libsvm" $dir/nytimes.word_id.dict $dir 0

# 4. Run LightLDA
$bin/lightlda.exe -num_vocabs 111400 -num_topics 1000 -num_iterations 1 -alpha 0.1 -beta 0.01 -mh_steps 2 -num_local_workers 8 -num_blocks 1 -max_num_document 300000 -input_dir $dir -data_capacity 800
