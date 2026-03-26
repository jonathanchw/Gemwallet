# syntax=docker/dockerfile:1.4
# This Dockerfile is used to build the Android app (no signing).
ARG BASE_IMAGE=gem-android-base
ARG BASE_IMAGE_TAG=latest
FROM ${BASE_IMAGE}:${BASE_IMAGE_TAG}

ARG REPO_URL=https://github.com/gemwalletcom/wallet.git
ARG TAG=main
ARG SKIP_SIGN
ARG BUNDLE_TASK=":app:assembleUniversalRelease"
ARG GRADLE_OPTS="-Xmx8g -Dfile.encoding=UTF-8"
ARG R8_MAP_ID_SEED=""

RUN git clone --depth 1 --branch "$TAG" "$REPO_URL" $HOME/wallet && \
    git -C $HOME/wallet submodule update --init --recursive

WORKDIR $HOME/wallet/android

ENV GRADLE_OPTS=${GRADLE_OPTS} \
    R8_MAP_ID_SEED=${R8_MAP_ID_SEED} \
    SKIP_SIGN=${SKIP_SIGN} \
    BUNDLE_TASK=${BUNDLE_TASK}

COPY --chown=root:root local.properties ./local.properties

CMD ["bash"]
