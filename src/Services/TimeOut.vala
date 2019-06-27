using App.Interfaces;

namespace App.Services {

    public class TimeOut : Object, App.Interfaces.Timer {
      uint interval_in_seconds;
      TimeoutSource time_out;

      public TimeOut (uint seconds) {
        interval_in_seconds = seconds;
      }

      public uint get_elapsed_time () {
        return interval_in_seconds - get_remaining_time ();
      }

      public uint get_remaining_time () {
        var rem = nanoseconds_to_seconds (time_out.get_ready_time () - time_out.get_time ());
        return rem > 0 ? rem : 0;
      }

      int nanoseconds_to_seconds (int64 ns) {
        return (int) (ns / (1000 * 1000));
      }

      public uint get_total_time () {
        return interval_in_seconds;
      }

      public void start () {
        if (time_out == null) {
          time_out = create_time_out ();
        }
      }

      public void cancel () {
          time_out.destroy ();
      }

      private TimeoutSource create_time_out () {
        var time = new TimeoutSource.seconds (interval_in_seconds);
        time.set_callback (() => { finished (); return false; });
        time.attach (MainContext.get_thread_default ());
        return time;
      }
    }
}
