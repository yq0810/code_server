FROM ubuntu:20.04
RUN DEBIAN_FRONTEND=noninteractive apt update && apt-get install -y tzdata &&\
apt-get install -y wget build-essential pkg-config libssl-dev software-properties-common language-pack-zh-hans git g++ build-essential gdb make gcc intltool &&\
wget http://jaist.dl.sourceforge.net/project/kmphpfm/mwget/0.1/mwget_0.1.0.orig.tar.bz2 &&\
tar -xjvf mwget_0.1.0.orig.tar.bz2 && cd mwget_0.1.0.orig && ./configure &&\
 sed -i '/<iostream>/a #include <cstring>' src/httpplugin.cpp &&\
 sed -i '/<iostream>/a #include <cstring>' src/ftpplugin.cpp &&\
 sed -i '/<sys\/types.h>/a #include <cstring>' src/downloader.cpp &&\
 make && make install &&\
wget https://github.com/coder/code-server/releases/download/v4.4.0/code-server_4.4.0_amd64.deb &&\
dpkg -i code-server_4.4.0_amd64.deb && cd .. && rm -rf mwget_0.1.0.orig

RUN wget https://github.com/microsoft/vscode-cpptools/releases/download/v1.9.8/cpptools-linux.vsix &&\
	code-server --install-extension cpptools-linux.vsix &&\
	rm -f cpptools-linux.vsix

RUN printf "{\"security.workspace.trust.enabled\": false,\"workbench.startupEditor\": \"readme\", \"workbench.colorTheme\": \"Default Dark+\", \"workbench.panel.defaultLocation\": \"right\", \"terminal.integrated.shell.linux\": \"bash\", \"files.associations\": {\"*.qasm\": \"cpp\"}}" | tee /root/.local/share/code-server/User/settings.json
   
ENV PATH "${PATH}:/usr/lib/code-server/bin"

ENTRYPOINT ["/usr/lib/code-server/bin/code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "."]

ENV LANGUAGE "en_US:en"
#ENV PASSWORD 123456
EXPOSE 8080
EXPOSE 8090
CMD ["/usr/lib/code-server/bin/code-server","/root/code", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
