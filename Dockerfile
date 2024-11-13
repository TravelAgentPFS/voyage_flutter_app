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

# Clone the Flutter repository
RUN git clone https://github.com/flutter/flutter.git /flutter

# Set the working directory to /flutter
WORKDIR /flutter

# Checkout the desired Flutter version (3.22.2)
RUN git checkout 3.22.2

# Add Flutter to PATH
RUN echo "export PATH=\$PATH:/flutter/bin" >> /etc/profile.d/flutter.sh

# Run flutter doctor to check everything is installed correctly
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
