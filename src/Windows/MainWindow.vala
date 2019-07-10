using App.Services;
using App.Configs;

namespace App.Windows {

    public class MainWindow : Gtk.Window {
        Gtk.HeaderBar timer_header;
        TimerLabel timer_label;
        Cancellable cancellable;
        Service pomodoro;
        App.Configs.Settings settings;

        public MainWindow (Gtk.Application application) {
            Object (
                application: application,
                height_request: 600,
                width_request: 800,
                resizable: true,
                title: (_("Cyfrif")),
                icon_name: "com.github.aimproxy.cyfrif"
            );
        }

        construct {
            pomodoro = new Service ();
            pomodoro.start.connect (on_pomodoro_start);
            pomodoro.stop.connect (on_pomodoro_stop);

            settings = App.Configs.Settings.get_instance ();

            if (settings.work_interval_time != 1500
                || settings.break_interval_time != 300) {
                pomodoro.work_interval = settings.work_interval_time;
                pomodoro.break_interval = settings.break_interval_time;
            }

            var label_app = create_app_label ();
            var start_btn = create_btn_start ();
            var stop_btn = create_btn_stop ();
            var pause_btn = create_btn_pause ();

            var actions_grid = new Gtk.Grid ();
            actions_grid.get_style_context ().add_class ("actions-grid");
            actions_grid.orientation = Gtk.Orientation.VERTICAL;
            actions_grid.row_spacing = 12;
            actions_grid.margin = 12;
            actions_grid.add (label_app);
            actions_grid.add (start_btn);
            actions_grid.add (pause_btn);
            actions_grid.add (stop_btn);

            var timer_view_label = create_timer_label ();

            var timer_grid = new Gtk.Grid ();
            timer_grid.get_style_context ().add_class ("timer-grid");
            timer_grid.attach (timer_view_label, 0, 0, 3, 1);

            var main_grid = new Gtk.Grid ();
            main_grid.add (actions_grid);
            main_grid.add (timer_grid);

            var actions_header = new Gtk.HeaderBar ();
            actions_header.decoration_layout = "close:";
            actions_header.show_close_button = true;
            actions_header.title = _("Cyfrif");

            var actions_header_context = actions_header.get_style_context ();
            actions_header_context.add_class ("actions-header");
            actions_header_context.add_class ("titlebar");
            actions_header_context.add_class ("default-decoration");
            actions_header_context.add_class (Gtk.STYLE_CLASS_FLAT);

            timer_header = new Gtk.HeaderBar ();
            timer_header.hexpand = true;

            var timer_header_context = timer_header.get_style_context ();
            timer_header_context.add_class ("timer-header");
            timer_header_context.add_class ("titlebar");
            timer_header_context.add_class ("default-decoration");
            timer_header_context.add_class (Gtk.STYLE_CLASS_FLAT);

            var menu = new Gtk.Popover (null);
            menu.add (create_menu_settings ());

            var menu_btn = new Gtk.MenuButton ();
            menu_btn.has_tooltip = true;
            menu_btn.tooltip_text = (_("Settings"));
            menu_btn.popover = menu;
            menu_btn.set_image (new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR));

            timer_header.pack_end (menu_btn);

            var header_grid = new Gtk.Grid ();
            header_grid.add (actions_header);
            header_grid.add (timer_header);

            var sizegroup = new Gtk.SizeGroup (Gtk.SizeGroupMode.HORIZONTAL);
            sizegroup.add_widget (actions_grid);
            sizegroup.add_widget (actions_header);

            add (main_grid);
            set_titlebar (header_grid);
        }

        void on_pomodoro_start (State state) {
            timer_header.title = state.to_string ();

            Idle.add (() => {
                timer_label.set_time_in_seconds (pomodoro.timer.get_remaining_time ());
                return Source.REMOVE;
            });

            cancellable = new Cancellable ();
            Timeout.add_seconds (1, () => {
                timer_label.set_time_in_seconds (pomodoro.timer.get_remaining_time ());
                return !cancellable.is_cancelled ();
            });
        }

        void on_pomodoro_stop () {
          if (cancellable != null) {
            cancellable.cancel ();
            timer_header.title = _("Finished");
          }
        }

        Gtk.Widget create_timer_label () {
            timer_label = new TimerLabel ();
            timer_label.get_style_context ().add_class ("timer-label");
            timer_label.get_style_context ().add_class ("h1");
            timer_label.set_label("00:00");
            timer_label.expand = true;
            timer_label.valign = Gtk.Align.CENTER;
            timer_label.halign = Gtk.Align.CENTER;
            return timer_label;
        }

        Gtk.Widget create_btn_start () {
            Gtk.Button btn_start = new Gtk.Button.with_label (_("Start Working"));
            btn_start.get_style_context ().add_class ("btn-start");
            btn_start.clicked.connect (() => {
                pomodoro.start_work ();
            });
            return btn_start;
        }

        Gtk.Widget create_btn_pause () {
            Gtk.Button btn_pause = new Gtk.Button.with_label (_("Take a Break"));
            btn_pause.get_style_context ().add_class ("btn-pause");
            btn_pause.clicked.connect (() => {
                pomodoro.start_break ();
            });
            return btn_pause;
        }

        Gtk.Widget create_btn_stop () {
            Gtk.Button btn_stop = new Gtk.Button.with_label (_("Stop"));
            btn_stop.get_style_context ().add_class ("btn-stop");
            btn_stop.clicked.connect (() => {
                pomodoro.stop_all ();

            });
            return btn_stop;
        }

        Gtk.Widget create_app_label () {
            Gtk.Label app_label = new Gtk.Label (_("Actions"));
            app_label.get_style_context ().add_class ("h4");
            app_label.xalign = 0;
            return app_label;
        }

        Gtk.Widget create_menu_settings () {
            var menu_grid = new Gtk.Grid ();
            menu_grid.margin = 6;
            menu_grid.row_spacing = 6;
            menu_grid.column_spacing = 12;
            menu_grid.orientation = Gtk.Orientation.VERTICAL;

            var separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL);

            var title = new Gtk.Label (_("Duration in minutes"));
            title.get_style_context ().add_class ("h4");

            var work_time_adjustment = new Gtk.Adjustment (0, 0.0, double.MAX, 1, 5, 0);
            var work_time_spin = new Gtk.SpinButton (work_time_adjustment, 4, 0);
            work_time_spin.set_value(convert_seconds_to_minutes(settings.work_interval_time));
            work_time_spin.value_changed.connect (() => {
                var work_time_in_seconds = convert_minutes_to_seconds (work_time_adjustment);
                pomodoro.work_interval = work_time_in_seconds;
                settings.work_interval_time = work_time_in_seconds;
            });

            var break_adjustment = new Gtk.Adjustment (0, 0, double.MAX, 1, 5, 0);
            var break_spin = new Gtk.SpinButton (break_adjustment, 1, 0);
            break_spin.set_value(convert_seconds_to_minutes(settings.break_interval_time));
            break_spin.value_changed.connect (() => {
                var break_time_in_seconds = convert_minutes_to_seconds (break_adjustment);
                pomodoro.break_interval = break_time_in_seconds;
                settings.break_interval_time = break_time_in_seconds;
            });

            menu_grid.attach (title, 0, 0, 2);
            menu_grid.attach (new Gtk.Label (_("Work Time:")), 0, 1);
            menu_grid.attach (work_time_spin, 1, 1);
            menu_grid.attach (new Gtk.Label (_("Break Time:")), 0, 2);
            menu_grid.attach (break_spin, 1, 2);
            menu_grid.attach (separator, 0, 3, 2);
            menu_grid.show_all ();
            return menu_grid;
        }

        private int convert_minutes_to_seconds (Gtk.Adjustment val) {
            var secs = val.value * 60;
            if (secs == 0) secs = 1;
            return (int) secs;
        }

        private int convert_seconds_to_minutes (int val) {
            var min = val / 60;
            if (min == 0) min = 1;
            return (int) min;
        }
    }
}
