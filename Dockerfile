FROM ubuntu:18.04

LABEL MAINTAINER="Ricardo Santana <rsantana@kenos.com.br>"

# Copy local iReport tar.gz file
COPY iReport-2.0.2.tar.gz /iReport-2.0.2.tar.gz

RUN apt-get update \
	&& apt-get install -y openjdk-8-jdk libxrender1 libxtst6 libxi6 \
	&& apt-get install -y xfonts-base xfonts-75dpi xfonts-100dpi \
	&& apt-get install -y libxext6 libxss1 libgconf-2-4 \
	&& tar zxvf iReport-2.0.2.tar.gz \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /iReport-2.0.2.tar.gz

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Set Java system properties to fix display issues
ENV _JAVA_OPTIONS="-Djava.awt.headless=false -Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel -Dswing.crossplatformlaf=javax.swing.plaf.metal.MetalLookAndFeel -Dsun.java2d.xrender=false -Dsun.java2d.pmoffscreen=false -Dsun.java2d.d3d=false -Dsun.java2d.opengl=false -Dswing.volatileImageBufferEnabled=false -Djava.awt.useSystemAAFontSettings=on -Dswing.aatext=true -Dsun.java2d.noddraw=true -Dsun.java2d.ddforcevram=false"

CMD [ "/iReport-2.0.2/iReport.sh" ]