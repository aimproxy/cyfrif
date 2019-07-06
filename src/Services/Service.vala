using App.Interfaces;

namespace App.Services {

    public class Service : Object {
        public App.Interfaces.Timer? timer { public get; private set; }

        public bool running = false;
        public string state_info { get; private set; }
        public int work_interval { get; set; default = 1500; }
        public int break_interval { get; set; default = 300; }
        public void start_work () { start (State.WORKING); }
        public void start_break () { start (State.BREAK); }
        public void stop_all () { stop (); }

        public virtual signal void start (State state = State.WORKING) {
            running = true;
            state_info = state.to_string ();

            if (timer != null) {
              timer.cancel ();
            }

            timer = create_timer (state);
            timer.finished.connect (() => stop ());
            timer.start ();
            Notification notif = new Notification (_("Pomodoro Started"));
            GLib.Application.get_default ().send_notification (null, notif);
        }

        public virtual signal void stop () {
            if (running == true) {
                running = false;
                timer.cancel ();
                Notification notif = new Notification (_("Pomodoro Stopped"));
                GLib.Application.get_default ().send_notification (null, notif);
            }
        }

        protected virtual App.Interfaces.Timer create_timer (State state) {
            debug("Create Timing");
            switch (state) {
                case State.WORKING:
                    return new App.Services.TimeOut (work_interval);
                case State.BREAK:
                    return new App.Services.TimeOut (break_interval);
                default:
                    return new App.Services.TimeOut (1);
            }
        }
    }
}
