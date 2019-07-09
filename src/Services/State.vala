namespace App.Services {

    public enum State {
        WORKING,
        BREAK;

        public string to_string () {
            switch (this) {
                case WORKING:
                    return (_("Working"));
                case BREAK:
                    return (_("Break Time"));
                default:
                    assert_not_reached ();
            }
        }
    }
}
