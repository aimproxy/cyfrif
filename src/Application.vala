public class Tomato : Gtk.Application {

    public Tomato () {
        Object (
            application_id: "com.github.aimproxy.tomato",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new MainWindow(this);
        main_window.show_all ();

        var quit_action = new SimpleAction ("quit", null);
        quit_action.activate.connect (() => {
            if (main_window != null) {
                main_window.destroy ();
            }
        });

        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("com/github/aimproxy/tomato/Application.css");
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        add_action (quit_action);
    }

    public static int main (string[] args) {
        var app = new Tomato ();
        return app.run (args);
    }
}
