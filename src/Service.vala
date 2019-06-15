public class Service : Object {
  public Timer? timer { public get; private set; }

  public bool running = false;
  public int work_interval { get; set; default = 1500; }
  public int break_interval { get; set; default = 300; }
  public void start_work () { start (State.WORKING); }
  public void start_break () { start (State.BREAK); }

  public virtual signal void start (State state = State.WORKING) {
    debug("Starting");
    running = true;

    if (timer != null) {
      timer.cancel ();
    }

    timer = create_timer (state);
    timer.finished.connect (() => stop ());
    timer.start ();
  }

  public virtual signal void stop () {
    running = false;
    timer.cancel ();
  }

  protected virtual Timer create_timer (State state) {
    debug("Create Timing");
    switch (state) {
                case State.WORKING:
                    return new TimeOut (work_interval);
                case State.BREAK:
                    return new TimeOut (break_interval);
                default:
                    return new TimeOut (1);
            }
    }
}
