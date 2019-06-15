<h1 align="center">
  Pomodoro App
</h1>

<h4 align="center">
  Simple Pomodoro App made for elementaryOS App Store
</h4>

<div align="center">
  <img src="https://raw.githubusercontent.com/aimproxy/PomodoroApp/master/media/Screenshot.png">
</div>

### Building, Testing, and Installation

Run `meson build` to configure the build environment and then change to the build directory and run `ninja test` to build and run automated tests

    meson build --prefix=/usr
    cd build
    ninja test

To install, use `ninja install`, then execute with `com.github.aimproxy.PomodoroApp`

    sudo ninja install
    com.github.aimproxy.PomodoroApp
