public enum State {
    WORKING,
    BREAK;

    public string to_string () {
        switch (this) {
            case WORKING:
                return ("Working");
            case BREAK:
                return ("Breaking");
            default:
                assert_not_reached ();
        }
    }
}
