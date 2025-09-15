#!/bin/bash

# Cập nhật danh sách gói
apt-get update

# Cài các thư viện cần thiết
apt-get -y install libfreeswitch-dev libssl-dev zlib1g-dev libspeexdsp-dev libwebsockets-dev

# Tạo thư mục build và vào đó
mkdir -p build && cd build

# Build với cmake
cmake -DCMAKE_BUILD_TYPE=Release ..

# Biên dịch và cài đặt
make -j$(nproc)
make install
