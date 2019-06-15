public class MainWindow : Gtk.Window {
    TimerLabel timer_label;
    Service ps;

    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            height_request: 500,
            resizable: false,
            title: ("Pomodoro"),
            width_request: 700
        );

        ps = new Service ();
        ps.start.connect (on_pomodoro_start);
        //ps.stop.connect (on_pomodoro_stop);
    }

    construct {
        var ac_label = new Gtk.Label ("Actions");
        ac_label.get_style_context ().add_class ("h4");
        ac_label.xalign = 0;

        Gtk.Button btn_start_working = new Gtk.Button.with_label ("Start Working for 25 minutes");
        btn_start_working.clicked.connect (() => {
          ps.start_work ();
        });

        Gtk.Button btn_start_break = new Gtk.Button.with_label ("Start Break for 5 minutes");
        btn_start_break.clicked.connect (() => {
          ps.start_break ();
        });

        var actions_grid = new Gtk.Grid ();
        actions_grid.get_style_context ().add_class ("actions-grid");
        actions_grid.orientation = Gtk.Orientation.VERTICAL;
        actions_grid.row_spacing = 12;
        actions_grid.margin = 12;
        actions_grid.add (ac_label);
        actions_grid.add (btn_start_working);
        actions_grid.add (btn_start_break);

        var timer_view_label = create_timer_label ();

        var timer_grid = new Gtk.Grid ();
        timer_grid.row_spacing = 12;
        timer_grid.get_style_context ().add_class ("timer-grid");
        timer_grid.attach (timer_view_label, 0, 0, 3, 1);

        var main_grid = new Gtk.Grid ();
        main_grid.add (actions_grid);
        main_grid.add (timer_grid);

        var actions_header = new Gtk.HeaderBar ();
        actions_header.decoration_layout = "close:";
        actions_header.show_close_button = true;
        actions_header.title = "Pomodoro";

        var actions_header_context = actions_header.get_style_context ();
        actions_header_context.add_class ("actions-header");
        actions_header_context.add_class ("titlebar");
        actions_header_context.add_class ("default-decoration");
        actions_header_context.add_class (Gtk.STYLE_CLASS_FLAT);

        var timer_header = new Gtk.HeaderBar ();
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

    void on_pomodoro_start () {
      debug ("Pomodoro started");
      if (ps.timer != null) {
        timer_label.set_time_in_seconds (ps.timer.get_remaining_time ());
      } else {
        debug("Timer is Null Abort");
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
}
