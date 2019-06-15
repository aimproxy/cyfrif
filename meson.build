# project name and programming language
project('com.github.aimproxy.PomodoroApp', 'vala', 'c')

gnome = import('gnome')

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
    assets,
    dependencies: [
        dependency('gtk+-3.0')
    ],
    install: true
)

#Install our .desktop file so the Applications Menu will see it
install_data(
    join_paths('data', meson.project_name() + '.desktop'),
    install_dir: join_paths(get_option('datadir'), 'applications')
)

#Install our .appdata.xml file so AppCenter will see it
install_data(
   join_paths('data', meson.project_name() + '.appdata.xml'),
   install_dir: join_paths(get_option('datadir'), 'metainfo')
)
