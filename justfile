default:
    @just --list

setup-git:
    @echo "==> Setup git submodules"
    @git submodule sync --recursive
    @git submodule update --init --recursive
    @git config submodule.recurse true

ios-bootstrap:
    @cd ios && just bootstrap

ios-build:
    @cd ios && just build-for-testing

ios-test:
    @cd ios && just test-without-building

android-bootstrap:
    @cd android && just bootstrap

android-build-test:
    @cd android && just build-test

android-test:
    @cd android && just test

core-upgrade:
    @git submodule update --recursive --remote
