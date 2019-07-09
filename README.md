<h1 align="center">Cyfrif<h1>
<p align="center">
    <a href="https://appcenter.elementary.io/com.github.aimproxy.cyfrif">
        <img src="https://appcenter.elementary.io/badge.svg">
    </a>
</p>
<p align="center">
  <a href="https://github.com/aimproxy/cyfrif">
    <img src="https://img.shields.io/badge/Version-0.1.5-orange.svg">
  </a>
  <a href="https://github.com/aimproxy/cyfrif/blob/master/LICENSE.md">
    <img src="https://img.shields.io/badge/License-GPL%20v3-blue.svg">
  </a>
  <a href="https://travis-ci.org/aimproxy/cyfrif>
    <img src="https://travis-ci.org/lainsce/quilter.svg?branch=master">
  </a>
</p>
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
