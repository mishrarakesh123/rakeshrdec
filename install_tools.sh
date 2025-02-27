#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Update package lists
sudo apt update && sudo apt upgrade -y

# Install Java 17
sudo apt install openjdk-17-jdk -y

# Verify Java installation
java -version

# Install Node.js and npm
sudo apt install nodejs npm -y

# Verify Node.js and npm installation
node -v
npm -v

# Install Android Studio dependencies
sudo apt install -y unzip wget lib32z1 lib32ncurses6 lib32stdc++6

# Download Android Studio
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/latest/android-studio-2023.1.1-linux.tar.gz -O android-studio.tar.gz

# Extract Android Studio to /opt directory
sudo tar -xzf android-studio.tar.gz -C /opt/

# Remove downloaded archive
rm android-studio.tar.gz

# Create a symbolic link to launch Android Studio
sudo ln -s /opt/android-studio/bin/studio.sh /usr/local/bin/android-studio

# Install Android SDK
mkdir -p $HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH

# Download and install Android SDK command-line tools
mkdir -p $ANDROID_SDK_ROOT/cmdline-tools
cd $ANDROID_SDK_ROOT/cmdline-tools
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O commandline-tools.zip
unzip commandline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools
mv $ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest
rm commandline-tools.zip

# Accept SDK licenses
yes | sdkmanager --licenses

# Install one SDK (Android API level 33 as an example)
sdkmanager "platforms;android-33"

# Cleanup
sudo apt autoremove -y

# Notify user of completion
echo "Installation completed! Run 'android-studio' to start Android Studio."
