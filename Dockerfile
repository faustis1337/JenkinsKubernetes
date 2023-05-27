FROM jenkins/jenkins
USER root

# Install Docker
RUN apt-get update
RUN apt-get install curl -y
RUN curl -fsSL https://get.docker.com/ | sh
RUN usermod -aG docker jenkins


# install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl; chmod +x ./kubectl; mv ./kubectl /usr/local/bin/kubectl

# Instal dotnet
RUN apt-get update
RUN apt-get install wget
RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get update && apt-get install -y dotnet-sdk-7.0

COPY ["config", "/root/.kube/config"]

USER jenkins