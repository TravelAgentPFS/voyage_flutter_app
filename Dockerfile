# Use the official Jenkins LTS image
FROM jenkins/jenkins:lts

# Install required dependencies (curl, git, etc.)
USER root
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    xz-utils \
    git \
    openjdk-17-jdk

# Install Flutter SDK
RUN curl -fsSL https://storage.googleapis.com/download.flutter.io/flutter_linux_3.22.2-stable.tar.xz | tar -C /opt -xJf -
RUN echo "export PATH=\$PATH:/opt/flutter/bin" >> /etc/profile.d/flutter.sh
RUN flutter doctor

# Set the default work directory to /var/jenkins_home
WORKDIR /var/jenkins_home

# Expose Jenkins and Flutter ports (default Jenkins ports)
EXPOSE 8080
EXPOSE 50000

# Switch back to Jenkins user for Jenkins service
USER jenkins

# Start Jenkins
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
