FROM vognev/base

ENV     WINEVERPATH=/opt/wine
ENV            PATH=/opt/wine/bin:${PATH}
ENV      WINESERVER=/opt/wine/bin/wineserver
ENV      WINELOADER=/opt/wine/bin/wine
ENV     WINEDLLPATH=/opt/wine/lib/wine/fakedlls
ENV LD_LIBRARY_PATH="/opt/wine/lib:/opt/wine/lib32:${LD_LIBRARY_PATH}"

RUN sed -e 's/\[arch=amd64\]//' -i /etc/apt/sources.list && dpkg --add-architecture i386
RUN apt-get update &&\
 apt-get install -y zlib1g zlib1g:i386 &&\
 apt-get install -y libxml2 libxml2:i386 &&\
 apt-get install -y libxext6 libxext6:i386 &&\
 apt-get install -y libfreetype6 libfreetype6:i386 &&\
 rm -rf /var/lib/apt/lists/*

ADD wine.tar.gz /
