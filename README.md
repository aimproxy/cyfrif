<div align="center">
  <h1>Cyfrif<h1>
  <h2>Simple Pomodoro app made for elementary OS</h2>
</div>

[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.aimproxy.cyfrif)

[![Build Status](https://travis-ci.org/lainsce/quilter.svg?branch=master)](https://travis-ci.org/aimproxy/cyfrif)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

<div align="center">
  <img src="https://raw.githubusercontent.com/aimproxy/cyfrif/master/media/Screenshot.png">
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
