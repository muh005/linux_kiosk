FROM oott123/docker-novnc

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl wget nano ca-certificates software-properties-common && \
    apt-get install -y xfce4 xfce4-goodies && \
    apt-get install -y network-manager dbus-x11 xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable

# Budgie Desktop
#RUN add-apt-repository ppa:budgie-remix/ppa
#RUN apt-get update
#RUN apt-get install -y budgie-desktop-environment

# ---------------------------------------------------------------

# compiler, editor
RUN apt-get install -y vim iptables git ntp ntpdate iperf wireshark \
                net-tools iputils-ping sudo cmake clang-tidy clang-format cppcheck bash-completion repo git-core tcpdump aircrack-ng \
                emacs valgrind g++



# Chrome
RUN curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable
ENV CHROME_ARGS --no-sandbox

# Docker CE
RUN apt-get install -y apt-transport-https software-properties-common apt-utils
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-cache policy docker-ce
RUN apt-get update && apt-get install -y docker.io

RUN usermod -aG docker user
RUN usermod -aG sudo user

# VSCode
RUN wget https://github.com/codercom/code-server/releases/download/1.408-vsc1.32.0/code-server1.408-vsc1.32.0-linux-x64.tar.gz \
     && tar -xzvf code-server1.408-vsc1.32.0-linux-x64.tar.gz && chmod +x code-server1.408-vsc1.32.0-linux-x64/code-server
 
# Autoremove & Clean
RUN apt-get autoremove -y && \
    apt-get clean

# Set bash as default user terminal shell
RUN chsh -s /bin/bash user

# add in code folder
ADD ./code/ /code

# Specify entry point
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

# ---------------------------------------------------------------
