FROM gitpod/workspace-flutter

USER gitpod

RUN sudo apt-get update -yq \
    && sudo apt-get install -yq \
        apt-utils \
        libpulse0 \
        android-tools-adb \
        android-tools-fastboot \
        openjdk-8-jdk

# Android
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV ANDROID_HOME="/home/gitpod/.android"
ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ENV ANDROID_SDK_ARCHIVE="${ANDROID_HOME}/archive"
 ENV ANDROID_STUDIO_PATH="/home/gitpod/"

RUN cd "${ANDROID_STUDIO_PATH}" \
    && wget -qO android_studio.zip https://dl.google.com/dl/android/studio/ide-zips/3.3.0.20/android-studio-ide-182.5199772-linux.zip \
    && unzip android_studio.zip \
    && rm -f android_studio.zip \
    && mkdir -p "${ANDROID_HOME}" \
    && touch $ANDROID_HOME/repositories.cfg \
    && wget -q "${ANDROID_SDK_URL}" -O "${ANDROID_SDK_ARCHIVE}" \
    && unzip -q -d "${ANDROID_HOME}" "${ANDROID_SDK_ARCHIVE}" \
    && echo y | "${ANDROID_HOME}/tools/bin/sdkmanager" "platform-tools" "platforms;android-28" "build-tools;28.0.3" \
    && rm "${ANDROID_SDK_ARCHIVE}"

RUN yes | flutter doctor --android-licenses -v
RUN echo 'export PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:$PATH' >>~/.bashrc
