# Cyfrif
## Simple Pomodoro app made for elementary OS

<div align="center">
  <img src="https://raw.githubusercontent.com/aimproxy/cyfrif/master/media/Screenshot.png">

  [![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.aimproxy.cyfrif)
</div>

### Building, Testing, and Installation

You'll need the following dependencies:
* meson
* libglib2.0-dev
* libgtk-3-dev
* valac

Run `meson build` to configure the build environment and then change to the build directory and run `ninja test` to build and run automated tests

    meson build --prefix=/usr
    cd build
    ninja test

To install, use `ninja install`, then execute with `com.github.aimproxy.cyfrif`

    sudo ninja install
    com.github.aimproxy.cyfrif
