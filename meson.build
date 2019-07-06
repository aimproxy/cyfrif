# project name and programming language
project('com.github.aimproxy.cyfrif', 'vala', 'c')

add_global_arguments ('-DGETTEXT_PACKAGE="cyfrif"', language:'c')

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
    'src/Windows/MainWindow.vala',
    'src/Services/Service.vala',
    'src/Services/TimeOut.vala',
    'src/Services/TimerLabel.vala',
    'src/Services/State.vala',
    'src/Interfaces/Timer.vala',
    assets,
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('glib-2.0')
    ],
    install: true
)

subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')
