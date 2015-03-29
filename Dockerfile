FROM ubuntu:14.04
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y dist-upgrade && apt-get install -y openssh-server
RUN mkdir /var/run/sshd && echo 'root:shibby-arm' | chpasswd && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
RUN apt-get install -y build-essential
# RUN apt-get install -y autoconf autogen make automake1.9 automake1.10 automake1.11 texlive nettle-dev mlocate  autopoint binutils bison bzip2 flex gawk xsltproc libxml-parser-perl gcc gcc-multilib gettext gperf g++ g++-4.4-multilib libc6 libncurses5 libncurses5-dev libstdc++6-4.4-dev libtool libssl-dev libxml2-dev libelf1:i386 libc6-i386 lib32z1-dev meld mtd-utils m4 mercurial bzr ecj cvs patch pkg-config shtool sqlite zlib1g-dev re2c libncurses5 libncurses5-dev m4 bison flex libstdc++6-4.4-dev g++-4.4 g++ libtool sqlite gcc g++ binutils patch bzip2 flex bison make gettext unzip zlib1g-dev libc6 gperf sudo automake automake1.9 git-core lib32stdc++6 libncurses5 libncurses5-dev m4 bison gawk flex libstdc++6-4.4-dev g++-4.4-multilib g++ git gitk zlib1g-dev autopoint libtool shtool autogen mtd-utils gcc-multilib gconf-editor lib32z1-dev pkg-config gperf libssl-dev libxml2-dev libelf1:i386 make intltool libglib2.0-dev libstdc++5 texinfo dos2unix xsltproc libnfnetlink0 libcurl4-openssl-dev libxml2-dev libgtk2.0-dev libnotify-dev libevent-dev mc
RUN apt-get install -y autoconf git-core automake libncurses5 libncurses5-dev m4 bison flex libstdc++6-4.4-dev g++-4.4 g++ libtool sqlite gcc g++ binutils patch bzip2 flex bison make gettext unzip zlib1g-dev libc6 gperf sudo automake automake1.9 git-core lib32stdc++6 libncurses5 libncurses5-dev m4 bison gawk flex libstdc++6-4.4-dev g++-4.4-multilib g++ git gitk zlib1g-dev autopoint libtool shtool autogen mtd-utils gcc-multilib gconf-editor lib32z1-dev pkg-config gperf libssl-dev libxml2-dev libelf1:i386 make intltool libglib2.0-dev libstdc++5 texinfo dos2unix xsltproc libnfnetlink0 libcurl4-openssl-dev libxml2-dev libgtk2.0-dev libnotify-dev libevent-dev mc
WORKDIR /root
RUN wget http://tomato.groov.pl/download/K26RT-N/testing/automake_1.13.2-1ubuntu1_all.deb
RUN dpkg -i automake_1.13.2-1ubuntu1_all.deb && apt-get install -y automake && locale-gen en_US.UTF-8
RUN echo "dash dash/sh boolean false" | debconf-set-selections && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash
ADD get_shibby.sh /usr/sbin/
