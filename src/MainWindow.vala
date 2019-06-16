public class MainWindow : Gtk.Window {
    Gtk.HeaderBar timer_header;
    TimerLabel timer_label;
    Cancellable cancellable;
    Service pomodoro;

    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            height_request: 600,
            width_request: 800,
            resizable: true,
            title: ("Tomato"),
            icon_name: "com.github.aimproxy.tomato"
        );

        var s = new Service ();
        set_pomodoro_service (s);
    }

    construct {
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
        actions_header.title = "Tomato";

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

        var header_grid = new Gtk.Grid ();
        header_grid.add (actions_header);
        header_grid.add (timer_header);

        var sizegroup = new Gtk.SizeGroup (Gtk.SizeGroupMode.HORIZONTAL);
        sizegroup.add_widget (actions_grid);
        sizegroup.add_widget (actions_header);

        add (main_grid);
        set_titlebar (header_grid);
    }

     public void set_pomodoro_service (Service s) {
        pomodoro = s;
        pomodoro.start.connect (on_pomodoro_start);
        pomodoro.stop.connect (on_pomodoro_stop);
     }

    void on_pomodoro_start (State state) {
      if (pomodoro.timer != null) {
        debug ("Pomodoro started");
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
    }

    void on_pomodoro_stop () {
      if (cancellable != null) {
        debug ("Pomodoro Exit");
        cancellable.cancel ();
        timer_header.title = "Finished";
      }
    }

    Gtk.Widget create_timer_label () {
      timer_label = new TimerLabel ();
      timer_label.get_style_context ().add_class ("timer-label");
      timer_label.get_style_context ().add_class ("h1");
      timer_label.label = "00:00";
      timer_label.expand = true;
      timer_label.valign = Gtk.Align.CENTER;
      timer_label.halign = Gtk.Align.CENTER;
      return timer_label;
    }

    Gtk.Widget create_btn_start () {
      Gtk.Button btn_start = new Gtk.Button.with_label ("Start Working for 25 min");
      btn_start.get_style_context ().add_class ("btn-start");
      btn_start.clicked.connect (() => {
        pomodoro.start_work ();
      });
      return btn_start;
    }

    Gtk.Widget create_btn_pause () {
      Gtk.Button btn_pause = new Gtk.Button.with_label ("Take a Break for 5 min");
      btn_pause.get_style_context ().add_class ("btn-pause");
      btn_pause.clicked.connect (() => {
        pomodoro.start_break ();
      });
      return btn_pause;
    }

    Gtk.Widget create_btn_stop () {
      Gtk.Button btn_stop = new Gtk.Button.with_label ("Stop");
      btn_stop.get_style_context ().add_class ("btn-stop");
      btn_stop.clicked.connect (() => {
        pomodoro.stop_all ();
      });
      return btn_stop;
    }

    Gtk.Widget create_app_label () {
      Gtk.Label app_label = new Gtk.Label ("Actions");
      app_label.get_style_context ().add_class ("h4");
      app_label.xalign = 0;
      return app_label;
    }
}
