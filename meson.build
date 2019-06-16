# project name and programming language
project('com.github.aimproxy.PomodoroApp', 'vala', 'c')

add_global_arguments ('-DGETTEXT_PACKAGE="rush"', language:'c')

gnome = import('gnome')
i18n = import('i18n')

assets = gnome.compile_resources(
    'as-resources', 'data/css.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
    meson.project_name(),
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/Service.vala',
    'src/TimeOut.vala',
    'src/TimerLabel.vala',
    'src/State.vala',
    'src/Interfaces/Timer.vala',
    assets,
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('glib-2.0')
    ],
    install: true
)

subdir('data')
