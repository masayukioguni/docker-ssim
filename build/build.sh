#!/bin/bash

tar xzvf libwebp-0.4.2.tar.gz 
cd libwebp-0.4.2/
./configure;make;make install;cd ../

unzip opencv-2.4.10.zip
cd opencv-2.4.10
cmake -D WITH_FFMPEG=OFF -D WITH_WEBP=ON -D WITH_1394=OFF .
make -j2
make install
cd ../

/sbin/ldconfig
git clone https://github.com/yohsuke/ssim_opencv
cd ssim_opencv/
g++ -o ssim ssim.cpp -I/usr/local/include/opencv/ -lopencv_legacy `pkg-config --libs opencv`