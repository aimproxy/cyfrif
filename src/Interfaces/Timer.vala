namespace App.Interfaces {

    public interface Timer : Object {
        public signal void finished ();

        public abstract void start ();
        public abstract void cancel ();

        public abstract uint get_elapsed_time ();
        public abstract uint get_remaining_time ();
        public abstract uint get_total_time ();
    }
}
