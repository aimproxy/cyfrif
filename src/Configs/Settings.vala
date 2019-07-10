namespace App.Configs {

    public class Settings : Granite.Services.Settings {

        private static Settings? instance;

        public int work_interval_time { get; set; }
        public int break_interval_time { get; set; }

        private Settings () {
            base ("com.github.aimproxy.cyfrif");
        }

        public static unowned Settings get_instance () {
            if (instance == null) {
                instance = new Settings ();
            }

            return instance;
        }
    }
}
