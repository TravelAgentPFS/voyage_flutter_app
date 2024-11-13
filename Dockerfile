# Use an official Flutter image
FROM cirrusci/flutter:stable

# Install dependencies for Android SDK
RUN apt-get update && apt-get install -y \
  openjdk-8-jdk \
  wget \
  unzip \
  git \
  curl

# Install Android SDK tools
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip -O /tmp/tools.zip && \
  unzip /tmp/tools.zip -d /android-sdk-linux && \
  rm /tmp/tools.zip

# Set up Android SDK environment variables
ENV ANDROID_SDK_ROOT=/android-sdk-linux
ENV PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH

# Install the Android SDK and accept licenses
RUN yes | sdkmanager --licenses

# Update the SDK tools before installing packages
RUN sdkmanager --update

# Install required SDK packages
RUN sdkmanager "platform-tools" "build-tools;30.0.3" "platforms;android-29"

# Clone and checkout Flutter 3.22.2
RUN git clone https://github.com/flutter/flutter.git /flutter
WORKDIR /flutter
RUN git checkout 3.22.2

# Set Flutter environment variables
ENV PATH="/flutter/bin:$PATH"

# Set the working directory for your project
WORKDIR /workspace

# Copy Flutter project into the container
COPY . .

ENV TAR_OPTIONS="--no-same-owner"

# Get Flutter dependencies
RUN flutter pub get

# Build the APK
RUN flutter build apk --release

# Define the default command
CMD ["flutter", "build", "apk", "--release"]
