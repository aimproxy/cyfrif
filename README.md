<h1 align="center">
  Tomato
</h1>

<h4 align="center">
  Simple Pomodoro made for elementaryOS App Store
</h4>

<div align="center">
  <img src="https://raw.githubusercontent.com/aimproxy/Tomato/master/media/Screenshot.png">
</div>

### Building, Testing, and Installation

Run `meson build` to configure the build environment and then change to the build directory and run `ninja test` to build and run automated tests

    meson build --prefix=/usr
    cd build
    ninja test

To install, use `ninja install`, then execute with `com.github.aimproxy.tomato`

    sudo ninja install
    com.github.aimproxy.tomato
