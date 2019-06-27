using App.Windows;

namespace App {

    public class Cyfrif : Gtk.Application {

        public Cyfrif () {
            Object (
                application_id: "com.github.aimproxy.cyfrif",
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

            Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;

            var provider = new Gtk.CssProvider ();
            provider.load_from_resource ("com/github/aimproxy/cyfrif/Application.css");
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

            add_action (quit_action);
        }

        public static int main (string[] args) {
            var app = new Cyfrif ();
            return app.run (args);
        }
    }
}
