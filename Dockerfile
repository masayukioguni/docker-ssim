FROM ubuntu:trusty

RUN apt-get update && apt-get install -y openssh-server libopencv-dev build-essential cmake pkg-config yasm libjpeg-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev python-dev python-numpy libtbb-dev libqt4-dev libgtk2.0-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils unzip git libpng-dev libtiff-dev libgif-dev

RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd

RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/UsePam yes/UsePam no/' /etc/ssh/sshd_config

ADD build /tmp/build
RUN chmod a+x /tmp/build/build.sh
WORKDIR /tmp/build/
RUN sh ./build.sh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]